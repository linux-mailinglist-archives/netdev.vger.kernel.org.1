Return-Path: <netdev+bounces-293159-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIF6GSq6GWpByggAu9opvQ
	(envelope-from <netdev+bounces-293159-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 18:09:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC44E6054D7
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 18:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B37FB302AC05
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 15:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBFF33BBA7;
	Fri, 29 May 2026 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JrirpoHs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8386303A37
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 15:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068122; cv=fail; b=WD44rxCeXVhC0XICYaBZ2KFiA+jBmvCwNITu0KbeZpYIj8z8iDllBl5Lj4wBhR9qLSoskoP6wyFd5d1jGE3B4JC6xulo2QCS5uLUgz0psb5j3m5Ohcv9l5r36vbQk07avc5Zl7HzNgsLdK0NrBPtNKUTV/tn7huAZO8Yt69gVoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068122; c=relaxed/simple;
	bh=22fWWyKomaWiG54pe5FddiQPdEuUedn+o0u5mCTT5N8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uC4pQbVrXGH9DSYutdLNiYs1PBKbN/nBxn8PyN9CIWxOVualpRdxviCAcjEuGBh7Xbdq8c5ilvBM4XVrbfAn0gcllztGDsvbC4UqcS+Ss1z4Lvj6fA7srceFhD5OJ1RlR0QrYz6QzZaS18csD7bMqSzKDUwZLYMM5axvl5vWhHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JrirpoHs; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780068121; x=1811604121;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=22fWWyKomaWiG54pe5FddiQPdEuUedn+o0u5mCTT5N8=;
  b=JrirpoHst4wplHKNC/RbDPCNFTjhjxW7vTCSelyusfQoEIixIe2KJUw4
   I43jj5DvSiAG2fY/KeutyTIGbaKJeSCng9l8hikF7OVjwU9p+sN4EtrfG
   tEllpocAvWtqO2WSZYQBs4KU8RUcmBpAEKmMMBY+UzE965G6r/BS2dHH+
   l4zmzell0pCqCb04GmUm0MguYidIHesI1cmpGd9ZIRPKNScT868WihNdm
   L2G1ZUdG4fDyv+107qix72Oj1qkeMLo2d/7zEvP+s74+kZWrUJmnyKJmH
   Y/9AlOr/EzkUSJ2Uq+4K3SvcsPewLv4vk93Z1YgTwlnBtZi2cX2XMzNP9
   Q==;
X-CSE-ConnectionGUID: rir5SdR/TbibrQbxz4+tmQ==
X-CSE-MsgGUID: hZqaPrwISmW1C9pRwFBzsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="81104309"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="81104309"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 08:22:00 -0700
X-CSE-ConnectionGUID: bjTIShd4QIOKvhfiaEGX0g==
X-CSE-MsgGUID: PLw1YLpdTOGyhj2KTAMjzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="238486200"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 08:22:00 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 08:21:59 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 29 May 2026 08:21:59 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.60) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 08:21:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQfbRSKNrb4UnsuazZ988Et6KxkPRV1+o33ey3CpOpN2LvAKFYuC+flD43FDseyGRqfXorRSp8P1DWUvmOwUIXYhRZLdhSpNm6BGMSnZjaLuKpd5UIlj+VDk7C1HCA8PZB1wq1yXNf6gdp8JpOj7Tllq+pFr4F42dXNE1vmqs2kcZ6t5Gp1pJwnwrB15GufLXrpml41I9moe2gNlTb2ZNmiPJnQsTZoBxcGQA1HGxBBsNnUW6iSdQZbooHbkMyJGPyPyW3ckEu7uLN+yKLStXoGxtN8qyCYMBXw/wFVj6bjBgeKDutSazcLgBrDeRDF49tk7qnjL/+AIWUdOu3SKYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHy6WJZocsDdWVjVLmYbGzticqkbrEatU1QL4I8pxpg=;
 b=YuBGE4/o2ZgU+ZDwvX8qEaGFp97ka2Me1CwKmVauMoaVuM1oyKUBAloKNqYsOQ2E5P0tI1rGX4flvzoKjk5QXl9TLKsvgjieZ0OXE57R0Rd5JW6eHF0n0thS1GkEexYs+rCzsHNgCtd4kLcHxdFkWKBUGBpUocHTCkrPX3T1PxUtiPc7Wj6DdbWDIP/WWCZ8OZxBkURmPfdFgIjtAfJ8rkcHU9DkmqX1aoRuN8Hub0njIXPjrtS+mgisz+JJyUq1tiU1OoymRbyuivf/zjTpf7Nyz/e8IcrHTZPe1w0Dbc1M7Kj8gVtiYgHY5mtvi0dcgXHGhWTz5xcVINf6NZ+llg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS0PR11MB7852.namprd11.prod.outlook.com (2603:10b6:8:fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 15:21:53 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 15:21:52 +0000
Message-ID: <7a234f03-74cd-44ff-b972-8aa11593dd5b@intel.com>
Date: Fri, 29 May 2026 17:21:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] pcnet32: stop holding device spin lock during
 napi_complete_done
To: Oscar Maes <oscmaes92@gmail.com>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew@lunn.ch>
References: <20260528140320.5556-1-oscmaes92@gmail.com>
 <60438b0d-e664-4c86-b4f6-27343fe2fc7a@intel.com>
 <20260528170747-oscmaes92@gmail.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260528170747-oscmaes92@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0023.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::35) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS0PR11MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: c604f4ca-97ca-4bd7-ddd9-08debd96030a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|6133799003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: yAOPoK1PuBNsN3k9HHocOMLEOf+Rs/UZM383s5nEcuEqjL2yqzNMYjO7cwLWUM0W7EebNXJDpdKz2cNOY3NbAxKG/h6Ukmq1KfWe38j8ne0Sva2C2DPqgrS9l5Bs2AsmGjyGMSW3+KlcHsZb2IzebgQO1t7b8MKklY29rF1ns+Ok45KpXLeHBZLrhDnGfFxxVaaU6TFSqGR9czGXhHFlhtk3nhyBmdRt5THqAKooIwmztlw41/DomfbePlX42cl0JpYOOlBqDEY8lHZ7vs/cYF6tau+2y2BrY00Nmlj8mSzWiPINFiWUbIHvMMNbijBA/Zu/TBj2oDKY4XWeaC4rjqkSfXg5IqJRUPleZh0bcsY9aWgC3p5uMX0NF7dG1UFu+iop7FQeDEJEdpOYa7geW6cPqpVqm8no5Zz7dyNzmd3Yg/fXRc3NKq3vCosxpQZRMCxoSvnNubgACWw+AlnoT/WCsJdVaaqkcy05GRvsC0hNCCjz+CQS2KgLJyPHY1GkkFZYb1mnogbT9QtT0RBem5h31B+V+g/t9X2Xfu7Cw1pb7dPG8wK0Ap2VvtQYjKPUYi+aOgnvV9692Vfb5oh/lScjqFlGMXK3mRV7yU7kaJ15+zvBm5nh87ZU9vhhPqiRpvR8lkJut7ShmrhtYV4ikw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WE1qSXhvRERranZYZnFmbytpbTBLaGYralBIb2NhMDZwUHhzSGk1MW4vRFNU?=
 =?utf-8?B?TE84QWlsOFhUekpCd1g4V3o3cGxPd1hydWlIQzYzOWdQd2F5SVlLV1Q0RVZs?=
 =?utf-8?B?VjFoQ2FaVWdnb0N2YyswMGt1cDFIUzl6aVN0VmN3NUhLTzlOallrWTNvb29G?=
 =?utf-8?B?Z1BiY1BqZXJJNTdlLzkrU1Z5SVIwTkhud3NSTmlDT3c5MHBxak5iZllwTjJH?=
 =?utf-8?B?VEdZU0FxZUtJR3FwZDVoMzdtd0F4eWhBWHFTK2ZtWkM1ajFhYlExTXJPMlp4?=
 =?utf-8?B?RHBVWENMZm9weFU2TDVWS2xsZDl0SDlESGFmd0Z3YlFkaFMyRnIzZW5PcmZy?=
 =?utf-8?B?Z3MyaVY0bjliTkUyYXVJYVNkYnlxdldPWURGaER5SlpidzRIeWhxaFI4VW04?=
 =?utf-8?B?b3owR2pxaHpnUnJLMlVSeHptRHpjempaTmhBVS92MG1JRkVMZmF6ZzBOS09D?=
 =?utf-8?B?dzh6b09mUm5kZEF2ZnlLMDUzZFNMSytsMUt3VXlKRDZLdTlJRlJkb2E0S1ZK?=
 =?utf-8?B?bE9CVS9XaWhDa2VBODVHQldrMVlQRGpTZzRzMUIxcmZVdVAzUExaeWVoZUw5?=
 =?utf-8?B?ekNLMzl1TjFDMEZaSWU5VzhiY0x3VkkwdEttMDIya3VqYkJmei9qR3RCUllW?=
 =?utf-8?B?KzBhSzBuT2ptaXVEc3Vsc1Z3OWxIQ3VKRXJKUEJCSENQZ24rank2TXdrVjh5?=
 =?utf-8?B?ZVRkSjduSWhaZUlUNFkvUmVzYlREY3lod1BoNkpxL0l5NkFvcW4yejBST2t1?=
 =?utf-8?B?cnJwT0FzSFRaaVlQc2FBVGJETkZOYlI4L29YYmJUbjZoTWFUQzRnZ3pzZVJn?=
 =?utf-8?B?VmN3SHNrSVFRRG11ZlJSajRHTnBZQXRJYmJpeTg0Y3pDMFk2T0p5aFJhS3hp?=
 =?utf-8?B?Yld5VVcwRkpKNndaZ3lCSm5Td2RmWXVBVHgzb3RzVjVNNldzWUcxSk50OWRr?=
 =?utf-8?B?aEhmOHhmVmlOeEpiVmFmb3VaNmZKeUhjc2ZFUEpTQUJaVWwxSng1MFplbUJT?=
 =?utf-8?B?WCtCSG9sZ0F5bkpGUHEvcFFTcVJ0NkN5T3FQVTlPNUEzd2Y5ZnM2Q0hMaUg3?=
 =?utf-8?B?cmlEb3hBd3hsMnZ0MTNHT2IvdEsxWVNUcTl3cjdvb2g2ZVBwV09CczVaNUEz?=
 =?utf-8?B?eDFCZHRBVkg5VmtGamw2MVB4REpiTTljbWQ4WXNqYjMwVVlQOVBqbENZZVRJ?=
 =?utf-8?B?QzNVNldQL3BHL2ZRVE14SVk4WUNUY0VqNGdTdktQUC9sNWFsempDL1prU3p6?=
 =?utf-8?B?SXBBUE9xKzI1VkRteGlVU0JBNjVJOVdkb2lndEZFRi9pemliZUZzUkErNk5u?=
 =?utf-8?B?c2dEOFI5aEI5Wm1yT1prc3pYQXpwQUxQZFZhc2pIaUx2WHQrWnVxamJDbUUy?=
 =?utf-8?B?K1ZjdXIxV3JCUHh3RDJHb1VEOGlFSml2L2tyOEJsT002TENLWkdrZnBOM2tT?=
 =?utf-8?B?Uy9KQnRCQlFCQlc3T3ZVSzZXZW83NUVLTVlJekJrWGV5STJGQzhoUzFKcnAw?=
 =?utf-8?B?ZW9zblBpc3E0bEMxWTlnNGdWeG0vWWQrVEJTV0k2QUVsbHhkY2JnUWJ2K09o?=
 =?utf-8?B?Q2xOc1hUYVA3amh2RDBXdmxHTndVYUo4dEdCcGxvL3BmR1VsQUNvcmx2RVdz?=
 =?utf-8?B?L2RXM2c0anpRMEg0dS9MUXNiVlhHdkQxMDFhT2lUbTRtQ3JJRk9Ccy9ibmp5?=
 =?utf-8?B?OTRrS2JJNUR0UHVhSFE0ZzVCbFZ5NFhUc3I0WjVmNXpjT25ZZEdCYWxQNWdB?=
 =?utf-8?B?WTRadlh0dlNleXlaZ1J4bHV0UTdwYk1DTWZWTysyTVNPb3Z0MVN5aFNRdlRE?=
 =?utf-8?B?OGExeE10Zmx0RkRMQThJcmpYVzNGblN4MHh6Q3BVNEFNRG92MTkvcTdWOWs4?=
 =?utf-8?B?U0tVV1pvOXBIeGdPTUo4VDhwWTBrYmpnb0x6V0xEbXo0ZGNGa1kyNDd2STVG?=
 =?utf-8?B?ZWkxbEdYc2I1Q0Z5VFNjK3RkUTdEKy9TVm1HMWRETm1zSVhtd2ZTa3lGUXVs?=
 =?utf-8?B?L0ZEOU1nQ3R6L0J2T21YZkhKRjIvelpxbHhNa0xSb2xmbFljNVFIa0ZJb1px?=
 =?utf-8?B?WXhrK2dFTWNSdTlUQ2IxZXU4VnQ1bGNOd0ZCdHhDNlQvbFZSYnlYclk1Q2l4?=
 =?utf-8?B?NVNWYkE3UXUvYnV6d21mTzhGTHBUMlBhMEdhclpOQlJpejlWcnpJUXE3dDhI?=
 =?utf-8?B?UmtNZGdmaGtqeFFiYjlaMTI0ZHdXTnp4V0pLb3FGWFowT2VyMkJjQW5TVUFp?=
 =?utf-8?B?cVpyMlhvZGY1TThuWmprZit2WTB3YVMrZjY2ZXlob3gvNnBWeWlQNVc3SnBl?=
 =?utf-8?B?WDRiUkJJRVdMdUF1NW41QXpTS1ZlYXRkbkJGZTFnSXhXTzczYUpzQjZ1dHkv?=
 =?utf-8?Q?5uVVxzf0X+HnUbbA=3D?=
X-Exchange-RoutingPolicyChecked: gi10tXNAjT4ge5KvoXawYBGrINbTA8UGqzbBJSMHnOQduKxFrVRx1DJDZeXDwtuSL7rzYtvF0PdB4Hmb0GUUsn05RgeJPh3KmU/dsfB/Tusbz3aPKnFp9Obp71DfGfOjH7Xuz6aywdhNtBEMAKvxosDIqX4OgH9SzJITnfRLIc7vI7TsnjKeAPnh3900i0oUQhlfmVPBRCTtF8oRCgpab5HdqDqOW+N2qhiMzs0z+ICnJA7H+YCMWugswYkeaUUEpNCe7Rr4PUAcc+ybB3Y9FwiKGPlcPE8Rc5Eudo9/oA6pDhZb1BDfvwnHuhenvjb7evSL4WSLAsRHFxVejZyhmQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: c604f4ca-97ca-4bd7-ddd9-08debd96030a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 15:21:52.9666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TZudrwA00A+whsj8wZ+E65UaxCKKyB6IqmN0mLLMCFQx0KT+65sUimzyLuot1XPLh+qMAR6ucrVH1dPFfDcsDFUJJKG7b8t8elKl4y008u8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7852
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-293159-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim,lunn.ch:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: AC44E6054D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Oscar Maes <oscmaes92@gmail.com>
Date: Thu, 28 May 2026 19:07:47 +0200

> On Thu, May 28, 2026 at 04:55:55PM +0200, Alexander Lobakin wrote:
>> From: Oscar Maes <oscmaes92@gmail.com>
>> Date: Thu, 28 May 2026 16:03:20 +0200
>>
>>> napi_complete_done may call gro_flush_normal (though not currently, as GRO
>>> is unsupported at the moment), which may result in packet TX. This will
>>> eventually result in calling pcnet32_start_xmit - resulting in a deadlock
>>> while trying to re-acquire the already locked spin lock.
>>>
>>> It is safe to split the spinlock block into two, because the hardware
>>> registers are still protected from concurrent access, and the two blocks
>>> perform unrelated operations that don't need to happen atomically.
>>>
>>> Fixes: 5b2ec6f2be51 ("pcnet32: use napi_complete_done()")
>>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>>> Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
>>> ---
>>> NOTE: This patch was a part of the following net-next series:
>>> https://lore.kernel.org/netdev/20260525125437.4061-2-oscmaes92@gmail.com/
>>>
>>>  drivers/net/ethernet/amd/pcnet32.c | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/amd/pcnet32.c b/drivers/net/ethernet/amd/pcnet32.c
>>> index 911808ab13a7..4f3076d4ea34 100644
>>> --- a/drivers/net/ethernet/amd/pcnet32.c
>>> +++ b/drivers/net/ethernet/amd/pcnet32.c
>>> @@ -1407,8 +1407,10 @@ static int pcnet32_poll(struct napi_struct *napi, int budget)
>>>  		pcnet32_restart(dev, CSR0_START);
>>>  		netif_wake_queue(dev);
>>>  	}
>>> +	spin_unlock_irqrestore(&lp->lock, flags);
>>>  
>>>  	if (work_done < budget && napi_complete_done(napi, work_done)) {
>>> +		spin_lock_irqsave(&lp->lock, flags);
>>>  		/* clear interrupt masks */
>>>  		val = lp->a->read_csr(ioaddr, CSR3);
>>>  		val &= 0x00ff;
>>> @@ -1416,9 +1418,9 @@ static int pcnet32_poll(struct napi_struct *napi, int budget)
>>>  
>>>  		/* Set interrupt enable. */
>>>  		lp->a->write_csr(ioaddr, CSR0, CSR0_INTEN);
>>> +		spin_unlock_irqrestore(&lp->lock, flags);
>>>  	}
>>>  
>>> -	spin_unlock_irqrestore(&lp->lock, flags);
>>>  	return work_done;
>>
>> While this fix is valid, I'm wondering whether this needs a deeper
>> rework as it's generally a very bad idea to have IRQs disabled when
>> NAPI-polling (except for every short sections).
>>
>> Could these irqoff sections get narrowed down to reading/writing
>> interrupt registers only?
>>
>> Thanks,
>> Olek
> 
> Sounds like a good idea, however, I think it's out of scope for this bug fix.

Up to you, you might want to improve these sections later and send to
net-next, since (as far as I can see) they didn't cause any issues
except this one.

Just keep in mind in general that NAPI callbacks should in general
either fully avoid irqoff sections or limit them to the minimum, and
especially should not try to pass skbs to the netstack with the IRQs
disabled and in general not call any NAPI/networking-related functions
under irqoff.

For this particular fix:

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

How long has this issue been present in the kernel? You may want to add
"Cc: stable@vger.kernel.org" after the "Fixes:" tag to be marked as a
candidate for backporting to LTSes.

Thanks,
Olek

