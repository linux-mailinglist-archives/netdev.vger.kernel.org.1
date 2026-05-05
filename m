Return-Path: <netdev+bounces-284593-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAwcLI1x+mkDPAMAu9opvQ
	(envelope-from <netdev+bounces-284593-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 00:39:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 197404D467B
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 00:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43AAA30099A8
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 22:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89357314A98;
	Tue,  5 May 2026 22:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dSm+OBth"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF162C21EE;
	Tue,  5 May 2026 22:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778020744; cv=fail; b=V2kKSQJz16BU9XEohxERLxTQ+vcO2hjyLPn3gxv7Ac5u+fitdeWE2zPGaKrouhyERfiMNI38jr+qcIp1/IHY/qUzoJu5bUKT9JBufSzxJl32cpKabINMZgTB58FEz9fqzGcmsQJ4eGi8HE5xBOFpyFeSCG3uExCL3eWKa0pjeCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778020744; c=relaxed/simple;
	bh=21ZPhnkQGh1IxPiRsrT6I9mvcq2DeGIlJ1qH1HbLCQQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HEXYhHZOpS6T5qgFqIOy3bN79szO3yTb+AnPx66Ti9BtBxOMgSwn717BPHfSRyjC5536rEz/SI06lGMMNdxNumV6zUCtJDD+4iCP0zkAsLZQ5QS2IW8FNq9QVnprS8yBz8Kj5qyP/7vwjiXJnaBsha4pAL0EMKM/n7XxJLit5e0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dSm+OBth; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778020743; x=1809556743;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=21ZPhnkQGh1IxPiRsrT6I9mvcq2DeGIlJ1qH1HbLCQQ=;
  b=dSm+OBthEBmk7BZgLRTzzK7wmcBR+RUSjqwX0Ni1la4ihXmK9AkTxlhP
   rA/xRiT6Z929IAV4M8qOj6U4DhZK+C3x3+vMRxNS4A+Ca+SZtCdORPhjX
   3quOMTMnZrH5RXuH7gxLRaHwsN48v2WA+iSetp0bhzTaDMB6Nbxd97Tbr
   CwuOoya0veDGMGcXYWRqaJofEPBH/ntmWowC1mgam1kCzJ2SF1OtNX+1J
   n81UOZVRV4yOLxzD7/KYPrgzSQ7T+eKrlRGxMPDsXiGnZsauaCzyfRshd
   HsYrhic9JBbE0ITWJgDhRcwvaj8sVDUP8E/CaY+UPj3op7pkgHrybBw1D
   g==;
X-CSE-ConnectionGUID: k/L9CniSQrivgBX4Hy7bGw==
X-CSE-MsgGUID: zQ8j5ye2QvONT3OwUeb/0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="89606173"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="89606173"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 15:39:03 -0700
X-CSE-ConnectionGUID: lYBqw6/5SO6f/Ni7LE2Q5A==
X-CSE-MsgGUID: CIbck4DzSJ28BuUQ85oVAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="231359699"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 15:39:02 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 15:39:02 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 15:39:02 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.10) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 15:39:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hso6/H0g1w8R2uU1d7RtDq/bZK3nd0f7xoxLpbJN2yHzRYqm5GKjf45lpZUmkS7zk2hKsGcSKExUwrZ5LG6ohPYuix6xXVjIQrBwIpjrTwhDuOO31Fbim+Kkvk2rS3iZDPZax16IEcVMvJMYlHSg5S5D6DaCRCdi97ffU6ul1GrN8ny02y5XxIg21sZvWs9fGdCmcNGgkb2cJwCwf/UyVY8isUBDyCO0BGpiEMeael2xY6Y0BSSG0t3eCVzdjkz5SGLDZsexqBCcu7Yd4WNSm4cay7N2ttWMa+jNz7+v4ER2reXdFk4CPIixa01hoc8fzQBNsT9z1BZ4EKoszttb1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p50N+T137WAJqyvM9Regz+AbVOR3K9FGg86hXZNEtdE=;
 b=hNEc7o8MAorJyOf7iNyDj3yu/lkulgsqIEGeJuFxFcEZqqOlmx7PEa3mZnxeMPRYpQBrWIHzR3BqSIfsigbjRrfDZQRw7hraSKS/VgYnJ8POcXHaKbdPFBYg1qIGocErio1YHCw1CQme9nMMMT9ql6buAHkLDVrgFfzVpHKjAY5YJ1BwM2UsJEcSw0JpSv9/8wvlrf6j2B4xvGCwCAbKdVftXCieLd7kn/suyYEHfsOir/12QaI3wzPbxVpJz++P9R04aaoNplk4F7vSEhauOu9eMsWYAbl+Aff+/PqkOtztmQWrWOh5uQSIVRCLGBBe9nI2+/AsxYnd5eHutdx7bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7592.namprd11.prod.outlook.com (2603:10b6:806:343::16)
 by IA0PR11MB7884.namprd11.prod.outlook.com (2603:10b6:208:3dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 22:38:57 +0000
Received: from SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6]) by SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6%6]) with mapi id 15.20.9870.022; Tue, 5 May 2026
 22:38:57 +0000
Message-ID: <0caedb23-b433-4c76-8b12-be5d0d7768f6@intel.com>
Date: Tue, 5 May 2026 15:38:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 14/15] ice: dpll: fix rclk pin state get and
 misplaced header macros
To: Ivan Vecera <ivecera@redhat.com>, Jakub Kicinski <kuba@kernel.org>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, Simon Horman <horms@kernel.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, "Jagielski, Jedrzej"
	<jedrzej.jagielski@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Nitka, Grzegorz"
	<grzegorz.nitka@intel.com>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Wegrzyn, Stefan" <stefan.wegrzyn@intel.com>,
	"Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
References: <20260430-jk-iwl-net-next-2026-04-30-v1-0-6f27ae1cd073@intel.com>
 <20260430-jk-iwl-net-next-2026-04-30-v1-14-6f27ae1cd073@intel.com>
 <20260502190952.063d3eff@kernel.org>
 <SN7PR11MB75929B70DB2AC21CA8E36116D6312@SN7PR11MB7592.namprd11.prod.outlook.com>
 <070a7a14-d27a-4831-b596-a806a9d93dbc@redhat.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <070a7a14-d27a-4831-b596-a806a9d93dbc@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0298.namprd04.prod.outlook.com
 (2603:10b6:303:89::33) To SN7PR11MB7592.namprd11.prod.outlook.com
 (2603:10b6:806:343::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7592:EE_|IA0PR11MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: 03d18b68-929e-4e37-0b90-08deaaf71858
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: RdFpjR5WKFnn6cNrJgMTIOaHuN/6ClX/448T+cq7VE42yzhZHIRVOdCoVDnqA4LL5eLqK5qxgmYbPpkyVe2S++78shonozvgx40AZnqwj/CLkWI47geqd9ub7IfyJPBjx7zTB4vazWOrWk9LzTD9d7y1ciOxRZKDCzes6pvdD41EXNSoEaEuiX1kp+dDGlIZc1R5V0AKvgfPIDYwjWos9uEvDQysWeXptrMaFYTztc4NRCZ9Am3QvWgDGZFCVm+m//DFJOpRejcHUZY4jf9WbHiTKb7Mr19Y92lHr2klmQxePX18ldIOdSzZFpRs0LhoD2POQeg5LGSsXTIwRGQaC/99RJsZeT21NLpPtMbMxeEp5RBjP1B0AFiD1wVdWe6hvEi95puDs5Hwg3Rq2lMyVxKVsEaGCYWbupSOoV12aSwxc20m63xDJTaEY+nqYtb3nnatW7DYXfgqoCfCQHwfqiYzJ1VSIwqKvIRZl1sq8fpD+r7+4Fv/q8KqoW5wylplkntWsxt9K2sIiyUp6aEE0f/+mYsJXYoewiB9GvH8m27O4r66l2AkAZf07evi05q3WR5fNlUpA7b5Z2yHWCdVf7hlvAT25pUD6yvCHTQjNDJ1ZPKecpo3QQuGNTrh/lbQqXjq3/Ur15wsxHiNTz+VIr3Hh/yED6r46I+1JIuo58XhFZKNmsLDAq6rghsPozvn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUs1enNPVTJBVXNjaWJIQkwrN1hJR0xVMTRZemhmV2RmRTc2a1E0Z25BakVB?=
 =?utf-8?B?OFRDejRWVyt5RzB2VEZPTFI1TDNjN2FjcHU4b3JqSVY1ZWg2dkpzeGZDSHZ5?=
 =?utf-8?B?WW9NQklBakpvZWM1OGJhcnM2LzVQVWRMMkk3cmdVaThYTjhTQmZ5VjJ6WDcv?=
 =?utf-8?B?aFk1R29rU21FdVVzQmJmQlgvdGR0NzNnRDhSQkx6K1hvRm1VdG5Yczg0RTVn?=
 =?utf-8?B?SmZVa1lBbENNcld2MWhYV09ibHZTbmhpWE5HaGowbVpxL1ZuWGUzOHVaek92?=
 =?utf-8?B?amtKTkRGV211SkM3dEo2THVPZjF2T052TnZRVDZrVnFuUDdtWFprRXpUTmpH?=
 =?utf-8?B?VXdhVE4xeDJxczBOV1lRMkphY21wcDRrMldpSE03RkNSMmlNV1UwWDYvVW1O?=
 =?utf-8?B?dFAvV2FUc21MVVBOVlcxUDFXQUpmaFY2dkxLTFN2R1VaMHhRb2tPYk8wNEpZ?=
 =?utf-8?B?RitEU21yWjBzOTd1VnlicmlGdjRJN01WaUlmajduU1JCOGFqbXJVSzkxb0hl?=
 =?utf-8?B?ZmtWZ0lvZmpSODJBZUoxZVZIeUFFaXBQcHdGV1VFaHQrbWIxck1qRVpCS3FF?=
 =?utf-8?B?UnFoaEJoNW81dk5PTE8xT243cXo3b2FmMkExZklQWHFobFdCL1dqNEVqZVZm?=
 =?utf-8?B?OHdIa2JXbHZZQ0tnSG1RWkRvWEd5NEozOFEvdmpER2NZMDJSaktzUkFYMzVI?=
 =?utf-8?B?YXl6bVUwOWh6c2g3YUpHVklQV2N0TERoYTY5alJ3YUFnVHJvdWUzYXFTYlY1?=
 =?utf-8?B?Nzh1d0w3Y1NKTzRDTmx1clZ4eHFhRm5JT2pCT09NVmsrQ3U5TFNuRkZPTWli?=
 =?utf-8?B?ZlNzNUNYYjAwbG51ckd3ZWdlenJiVTZLM1dXN09oczJwaE9VUngzb1ZjWFlH?=
 =?utf-8?B?c21McEp4QnhjZGVseDM3Y0ZpRnZZbXFTTUhOSDZxMHF2SE9ZeGFzZTg1dldP?=
 =?utf-8?B?Z00rVnF4TFVkc0w4QklHbUQvOGQ3MFZzazYwczlpaTc1RElvS21HMm5weHlm?=
 =?utf-8?B?eURqRloxY2JLcFV2cE0rMWRnUGhlanZUK1dnRVZzWE1hRjN5b09ZR1JXQ0pl?=
 =?utf-8?B?RkJvTkZBem5pek0rOVd6dWZEdWoxWTc3Vyt0TjJIRlg1ZHZoV1didlEyR3hO?=
 =?utf-8?B?TXFySGVUbWdUS0tXSHNSeWNrcHVZbjR5Nnc3NlBCeFc5Qy9iWC9YNXprUTIw?=
 =?utf-8?B?UWdvWUxlM29rTFBCbWU4TzVBdlk2Z3lvYWlyMUNSenc1Nk94YVJHd3R4M2px?=
 =?utf-8?B?TUJneEZxLytjdDZmMVBTN2tCM21ETXIzWGg3bTBvUlFLcURvdURkREpVdkZV?=
 =?utf-8?B?TXk2dTVnLzBJTXNXMitxaUtKUURiS0VkYVZQbStzcFhZeElZNnExYTlzYit0?=
 =?utf-8?B?UGdDYmFCdVlhUGlmL1ozM0tyTDJ5aVh0OGtUQis1a0lzbmxlRXpEWjNGODJi?=
 =?utf-8?B?Q2N1eVBDN050akF2Q3FHbkRZWFZzUS91NkpYYkJYRVhxTGZzRHdPRS9jRnEv?=
 =?utf-8?B?SnBLNnJ3akw1bkYxdU5ML1VjQ253S1hEQlJ1bjlsZXJHSzZDRW5waGxKdFdR?=
 =?utf-8?B?N3Z3ejZIamlRNkxIdXR3Q2crSHZoeFNsdHVrK2dFL3d4anlmUUUyRU80ZWp2?=
 =?utf-8?B?Uk1RMHpEK3lRNjBBOGw3SWdwN1RtUkNGOFI1alZYRzNnTHhnK3M2WjlxYjJO?=
 =?utf-8?B?cDRmUmJNRWcrVjRNMjViTEVkclE2alRXb2kyY3l1azFjQkRDVGxaWnpQOVRm?=
 =?utf-8?B?RWE1RHdKNzFldCsxdHUxNWFjeDBzbE50M1hBUFU5TGxCL1h3M0JaaHVhTitL?=
 =?utf-8?B?Z1JHMGRLUndWcm5JWEt3bXQ1azkrN3lZek1HTUhwb285SGJtM09CM09TeFlB?=
 =?utf-8?B?T0VrNFFGeG9iVUNPVGNWaDUyeWFTYVlBM00wUFhuY0d2U0JLR3pMNWFBUklP?=
 =?utf-8?B?UWJ3Skt3b2szQWNJTTJ0KzZPMG9LVGVpZFIwMGtMNDJzNU95UDgxNlNtREVu?=
 =?utf-8?B?a1QwV1VNaitTbjNzajBMdFArOVRKNUpDQnpTMXpQSzhFUnRBNzl2V3dBU0kr?=
 =?utf-8?B?Z2krSDhqb1VRTGxpdWkxQUJiaVhkYitOcE1WSDlyN3I0eXNHY2tBSXkwSjB2?=
 =?utf-8?B?OWNhNnU0bU1mRFdEZ20reEFPdGIxMloxQzcwaUJJN1RHK3RjaWhTU1BMaWRM?=
 =?utf-8?B?WkNVbjd4RUZxZWpRZFk2MXpma0w2Yko2Wmd4aXdoOHRjSTc2NkFWWDZyWmtK?=
 =?utf-8?B?c2J1UkZGSk51Z2ZIVVdYdTN5dWI1MGdCc1FVVSttS1YyRmhPNGsrQU5BQ1Ri?=
 =?utf-8?B?S3FpYzVpT3FJUFpQRFVGemdMUzl1c1NyeFA4TXJpQm91Q283NmRwdz09?=
X-Exchange-RoutingPolicyChecked: pVq3O87+v/BJiGoFTfCkki40stBJjzvQ+TvTN4kFUUPhiU5PCwdKVoqa4tRmVD46GrbBsotdVCHD/0r/h5hM5CVu+hv7AODmxBhHUQFVk7KAZWtlhXhbzbzcWnqiArz0NKnbu+JBpr/9ub3tKPgUxFuiVSXvaNOk6xPGYLORKi0sVdcOos7dL6hrBvsduM6xn9Wtv/viu0LQj0ERSe6kEzNT7prpg80Lyaj8ldlD4Gy5/akDidirv6ZmJMNOxYwBliLBZkr0j/6bdWfOY7TGPeWCWCQCvLr7/89gc767AfaQ68rdWd34NnZSEix+0KZO4LzO6ndFge5vbSXTZedDFA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d18b68-929e-4e37-0b90-08deaaf71858
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 22:38:57.7075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hgGXYr8Yd2wRdz9+oLFL+0IXcphdO0MGeN8ktquFAP7ur1VvQB0RtbBuNIHBcR9MpkPnF9+iQ6AcqOugyYpIX/Vu390BqDBtLUgBKvc1oq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7884
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 197404D467B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-284593-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]

On 5/5/2026 1:33 AM, Ivan Vecera wrote:
> 
> 
> On 5/4/26 8:38 PM, Keller, Jacob E wrote:
>>
>>
>>> -----Original Message-----
>>> From: Jakub Kicinski <kuba@kernel.org>
>>> Sent: Saturday, May 2, 2026 7:10 PM
>>> To: Keller, Jacob E <jacob.e.keller@intel.com>
>>> Cc: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
>>> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
>>> Dumazet <edumazet@google.com>; Paolo Abeni <pabeni@redhat.com>;
>>> Lobakin, Aleksander <aleksander.lobakin@intel.com>; Simon Horman
>>> <horms@kernel.org>; Michal Swiatkowski
>>> <michal.swiatkowski@linux.intel.com>; Jagielski, Jedrzej
>>> <jedrzej.jagielski@intel.com>; Loktionov, Aleksandr
>>> <aleksandr.loktionov@intel.com>; Nitka, Grzegorz
>>> <grzegorz.nitka@intel.com>; Vecera, Ivan <ivecera@redhat.com>;
>>> Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>; Nguyen,
>>> Anthony L
>>> <anthony.l.nguyen@intel.com>; Wegrzyn, Stefan
>>> <stefan.wegrzyn@intel.com>; Kwapulinski, Piotr
>>> <piotr.kwapulinski@intel.com>; netdev@vger.kernel.org; linux-
>>> kernel@vger.kernel.org
>>> Subject: Re: [PATCH net-next 14/15] ice: dpll: fix rclk pin state get
>>> and
>>> misplaced header macros
>>>
>>> On Thu, 30 Apr 2026 23:37:25 -0700 Jacob Keller wrote:
>>>> Fixes: ad1df4f2d591 ("ice: dpll: Support E825-C SyncE and dynamic pin
>>> discovery")
>>>
>>> Why are Fixes going to net-next?
>>
>> Hm. It was targeted at next in the IWL patchwork. I'm not sure why
>> Ivan chose to do that. I opted to include this in the series because
>> the patches for unmanaged DPLL support have conflicts otherwise due to
>> the placement of the header macros. I didn't consider that "net"
>> material since its relatively minor issue that I think only causes
>> issues if the ice_dpll.h header gets included twice which it doesn't
>> seem to currently.
> 
> This was because it fixed a problem recently merged to next and at that
> time it didn't make sense to target net branch. Originally it was
> submitted on 02/10 !
> 
> Thanks,
> Ivan
> 

Yea, that makes sense. Unfortunately The Intel Wired LAN backlog is
quite large right now.

I've submitted it in the latest round of net fixes (with the decision to
split the two fixes)

Thanks,
Jake

