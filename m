Return-Path: <netdev+bounces-230948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 976C5BF23A8
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 17:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D49463AFE21
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 15:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8012777FE;
	Mon, 20 Oct 2025 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nfwg2R/u"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0E02750FA;
	Mon, 20 Oct 2025 15:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760975488; cv=fail; b=hDKqESMWzAP2q8ztHd3ARQ01/eLQvpz3r9ZK7M1+O6zJzqpJYv4lDNAbKjJjx8eGis/QkrObCn4DaxAfW6oiKj+LHaYM3q4KKEbuuQ+MuGG4LJhDJLIQXUMB2fiHM6fjEa4CAPkVJOGKn+c6LHHETzFsn/JvBVV/ovKq4EMfebg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760975488; c=relaxed/simple;
	bh=MlRuVTBjzCOsCYdSV7LMUJSjEn3QZ3eo0bXZ4H76B/0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LPlVO/ykWK+WDPDrc+sYhTGkKgPCvPuTWgzfCBOknrjfvlMtywxC/f2zkaBf7K6gLxuSh52Pmz37HCAlm7XELW+dNZm/T4wZzJSjmyCqNQWexhYPhmhLKqOPdzg88mngrQ9SV+XbmWhiqSD3ZVHiYTEOTSzXMbZQw2wvSO93sXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nfwg2R/u; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760975487; x=1792511487;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MlRuVTBjzCOsCYdSV7LMUJSjEn3QZ3eo0bXZ4H76B/0=;
  b=nfwg2R/uTwcYlz0cFrwF8E0iSoMVhp4QZjBkquZi3X0VQ3vi+dYrV1Tv
   ZO6b7BfHtPUM7kjSGtwHN1bfgdZqPf4CrH+MtoJwQNaMAqPWYqltOVCnS
   DiukoTToSGRbz+uwf9jMzBrsyY9/UQsdBhv22egMx6JweDXTMPrhy9vwW
   ZdgHO1ONntud/KJk/3eEcWJITHwMSopWSIpNAF3leHq8lFn9rRQSjW7NN
   bcAFTpW5zTRO6Wp6yY1diLm+7PSpIGTCIDQ9oG96DkKPo54OmOUEmsKZJ
   T1kJLmCvFpl/MXSGncyvwOei4H6JhWHd91KO/hO77rvllTREfMM2I+2eQ
   w==;
X-CSE-ConnectionGUID: 3h+A3Z70Q3aIm/6TiZOrjQ==
X-CSE-MsgGUID: PXRvqjccSpuk4vqnbLzGRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="66926168"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="66926168"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 08:51:27 -0700
X-CSE-ConnectionGUID: j4GLhvCYTtiaLHixTS/w7g==
X-CSE-MsgGUID: 5QrG6+NhRZm6udcgJxOpEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="187375703"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 08:51:27 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 08:51:25 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 08:51:25 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.47) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 08:51:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODVmv+HiGo40lM5vuxSpKyyrM3UzrNYirnfar3psh7S9dQzvbRfVaLcjxn2MbGv5AmJ0luhBDrXvAbSf5N8D/rBNgZJzVumkOypiedamGIdE3/JZ4BVbf9Mb6TG71yHzIlhMnzwf82XE/oaNNIUVIqpNh4g7kULrgV18beOLkq7o8XBPUcdD5F8vlsksfAIqi/B3NR+q0KKDH/PHGu0zDNn6XvH60uIgHwiNU2nNoj73d9L5h4TUBBJldoQpW48npGhGZRfk7h7u4up7Gs9igeuk2QioUeryTwIwd+6Xd0DTHA2ddcB6qnsmDJ5TSxMMsETGcuY0cLPG6sjM2BRIeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XSo/GRTY7jpicdQ8gpIpZfmGTxcLC0ia60F8FEvL9k=;
 b=B++rxITnB+qTTsCfW0WNBcOlrJy6mYjc7XN8fVgqJgfMBLu/r3mjW7hrw+4mzuJY8BOUrYUe4uPqpxLHi176uu/QGuO+vrvhceU9rVkASi1+41cXie3wiq1i7zsFkYcAnBTMicAEt0gK/S1LIlXYMFTnw/zYqFIRPp/6l1P+QUYYem4JxO4DutgRTjlQ33yEP816N3YLg7b8oYXLJ2FKqDJ6Tyb2QcKLnkYt8vwX04biS6WYuVDwkrRZ1ZOnpeefZwsj7ekRiRR9+ISz0nlB5yU2wmXKRLBOLHEpYY1u+vNy6BJFs2tMufS082vrvPqjlGFx+OQSvs0tmfBCCeHI/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CY8PR11MB7243.namprd11.prod.outlook.com (2603:10b6:930:96::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 15:51:23 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 15:51:23 +0000
Message-ID: <6303480e-8e08-4171-9374-75b6183df690@intel.com>
Date: Mon, 20 Oct 2025 17:51:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ti: icssg-prueth: Omit a variable
 reassignment in prueth_netdev_init()
To: Markus Elfring <Markus.Elfring@web.de>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Byungchul Park <byungchul@sk.com>, "David S.
 Miller" <davem@davemloft.net>, Diogo Ivo <diogo.ivo@siemens.com>, "Eric
 Dumazet" <edumazet@google.com>, Grygorii Strashko <grygorii.strashko@ti.com>,
	Himanshu Mittal <h-mittal1@ti.com>, Jakub Kicinski <kuba@kernel.org>, "Jan
 Kiszka" <jan.kiszka@siemens.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, MD Danish Anwar <danishanwar@ti.com>,
	Meghana Malladi <m-malladi@ti.com>, Paolo Abeni <pabeni@redhat.com>, "Ravi
 Gunasekaran" <r-gunasekaran@ti.com>, Roger Quadros <rogerq@kernel.org>,
	"Simon Horman" <horms@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
	LKML <linux-kernel@vger.kernel.org>, Anand Moon <linux.amoon@gmail.com>,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>
References: <71f7daa3-d4f4-4753-aae8-67040fc8297d@web.de>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <71f7daa3-d4f4-4753-aae8-67040fc8297d@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0019.eurprd08.prod.outlook.com
 (2603:10a6:803:104::32) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CY8PR11MB7243:EE_
X-MS-Office365-Filtering-Correlation-Id: c66a34ae-b6a2-4fce-ab17-08de0ff08502
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VnVkcG5UK2dYdS9vdWJ4QjRDUE9jd0RTb2tzc3RJQzB3MzNFL0ZWRGM3VzFN?=
 =?utf-8?B?VkF6REMvaWMrRmRqSjlQSjNYNGRHdi80a2JJVFhqbXZrbU1oczl1WUgyRCto?=
 =?utf-8?B?UFJGTDN2ZC90cmo2VXJNcFphVFFVQXlNL0JoZkNXUVF4cEJFTGtuZFJrK1dB?=
 =?utf-8?B?SDVOdFV1czk0M3NIRkFCQmJJdjZqdHdRRGJRSmdQUGFQUkNVOG9qOE0xNm9p?=
 =?utf-8?B?cnBwdUw0MEdEMTZONWlGbUxzT0FlQWdRS2VNMzlqOGo1d2JIWFFZa2kxbkhE?=
 =?utf-8?B?ZHV2d0lkRGprS2NyREptZ0xCbVFOSUVRVlpHUnZmL2YzM0RvT2kwY3o2L2t6?=
 =?utf-8?B?dUFPcy8zWDNOSXJLeWdkbzJMaWFnZFJqQWxJeDVvdGljdndkM0VydWNOcnhp?=
 =?utf-8?B?QmVaNnVyQ0dMRDBtaEltbC85dTRGaVpLc0o0WHlHRXZQc3A1aHpvK256RXVr?=
 =?utf-8?B?enppUzY5dmZOeGREeVBwWGFFaU1wQis3SWM0b3pxWEJOYnlXUU8vQXBTR1g2?=
 =?utf-8?B?OTFBV0RrNlNZZ3N1UU9iaW14d05lclRzQTRPNUh3WVBRVlVRd096M01wb1NS?=
 =?utf-8?B?Y044WGlmWlBpUDRNa3Q0aDFzSGFqdmlpaGpCR2RuQitWUVpUWjY0ZnptUEdB?=
 =?utf-8?B?Mkxmdm1tWGNyMlVLRXBVWGRPbS9uaTlqeWZrNWZiYWsvRmVKaTlvVVVNRUw3?=
 =?utf-8?B?QmVLQW1qOUpsOVlRTjF6TzJXUW9pUXVDZFJGcGRhSUl2KzEwd3gxL0wvNTlk?=
 =?utf-8?B?a3owWXVla3daYnRuOEZ6NXhaalZ2eHJCYXdBcWlWWnJvNTkyT0h0NFc3T0xq?=
 =?utf-8?B?NjBCS3M5WWh0Qk9hTEFXR1dnb2lHVTB0OHcyOURUSTY5UWZXS0xNL0IvekZq?=
 =?utf-8?B?ZTVzUkl0MTlhSEhyKzRRQkNxTmc3dWNtVFNyM1k1dGhoYmhuOStIMFU2NDlM?=
 =?utf-8?B?R2NQSDdwN2Fic0ZVV1BOM1FCK1hOdW1zSmpQVUc1L3lTK1lmRGMwWWYvSDlZ?=
 =?utf-8?B?ODdtcUxhK2pkdzlSc1NxU1IxNllmMHkwMjYvcjg1dHNOdDgxTitoWHJ2UDM1?=
 =?utf-8?B?SmRaRGZiSVFpVzcvU1dtMnRkU1FlUVQ4akNkMXFJeVhGZTNXL1plZEFPaUxu?=
 =?utf-8?B?eWlSTkxWZllqa0EwTzU1UEZ1NFY1TXNCTWJ5dVRTcVlNU0FkaHN6MVh4bHUw?=
 =?utf-8?B?NUNEMVVQVTZqd2hmQ0RYN0JWSXZaOXhVY041T1ZpVWF3Z2M3eWZ4SXVnN1lo?=
 =?utf-8?B?VWgwSUVwTHJPT3ZOdml4bXN4Uzg4cDU0VytsTFhtOGVLb2RNNDMycE1FV3Vw?=
 =?utf-8?B?Nk9UTFZJWExyU01aYzdabmJ2U09NaHpGdnprNzZsWVRCcnNPTUE3VW1DM0w2?=
 =?utf-8?B?SVRuUWtPeHNBaG9MWjdhQkVhcy93VDZ3RXVFT0JaUmk1UzF5YkdzeFpNdXBX?=
 =?utf-8?B?WXhJei9FbGdhS1ZNdFZsUkVvcW9TWkdYcGo2OWVhbkQxVnZ5ZHB2ajZ0WXRV?=
 =?utf-8?B?MHRoNzY0Q0J2Zkp3NnlmLzQ4a2l6VVR0WDN0L3RES0xJTUJZcDVPM2VmQTFE?=
 =?utf-8?B?K1pNM3ZLT3VhQzRjS2s4UHJqU1dIaktNdkhQRHhxVjMxRG5CN09QTzRXbyt5?=
 =?utf-8?B?YmVQTXlSRTZnNkpwYUJXR0liQVRhSjBNbTBTam9nMGxRYmlEOFVyaDh2UXNs?=
 =?utf-8?B?OG0vcmc2R2xETXREMEljZG8wTThvQjRGQm9VS3Y5bnhGaFVGZmdtK0gwYXdw?=
 =?utf-8?B?SVh4Q2dYREFRdVFnVmJOeTRNR1l1YWNSWWxITHptTzVUVUxWbGJPcC9INXZv?=
 =?utf-8?B?amMxMVJmbnNOcnNINkZoWTViTzFzaWFKcGU0ZjZNUndRSXhrTkErTlV1b041?=
 =?utf-8?B?cGR6Wk1vTGhwYlM5RkFJR1FCZDVUR2EyYnZWMUw1dkl1MUg1S1I4SnFrV2xr?=
 =?utf-8?Q?kWJHsQH3UBNqTUEe+9dI5jPFDJ8IOG/h?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NW9aeGlOOVcveUkxd2ZKajRHUGVKVU43M2NzMjYzKzVsZExuR0dDOEYyWUgz?=
 =?utf-8?B?Um1qL2hwMkVCZEhScytFQkl2M0xXNUpNc1pOSy85a1krR2hGUEFlWS9rWFZt?=
 =?utf-8?B?Zm5RYmhtaDZSajk1anN1WHkxaXhxRkZlSmdUQ3M3aW8rT08vSmlwL2VXY2Ra?=
 =?utf-8?B?UmM4VW0vNlhPeXFwUENIMmdTUEJYc1dHOTRUU3RiMStiVmRvM2RTSkRaM0o3?=
 =?utf-8?B?bnFQZmhsUDZ5NW9xUENiVmxKa1hUbXBZSVhaRVZ6YUs0TDBtMWlnUHlRSGlS?=
 =?utf-8?B?YWt3NzFSY1RHU3hHMkVmUlRkdXJMU2hUenIzOE1SSjVIUnRhT2s0MzdZM0VB?=
 =?utf-8?B?N1Q1QWtzbEpjb3I2V3hJZ3o1c2EramtXVnZXb2pXaytxMCsycWczT3JPQ3dM?=
 =?utf-8?B?M3JJQVJueTBKVFB4ak5RdHhQMW1SQmZzbndDYUhsQlYxK2I1N3ZMK01TM2d3?=
 =?utf-8?B?WFZXSXJ4S2FqZW93VmtFeGxUMWFVNDAzbHhLaVYybXc4bldMSGp6WUM1WWlF?=
 =?utf-8?B?Rk5uWC9EWkszSVJid2RaYW1QYXkxWmVsR3V3RGI1d1plbXFwMnVjaVRKbmZH?=
 =?utf-8?B?WTlzbHA0ZW13S1c4eFVUWmMrT09vVHdvZ2o5VmlzaUN2Z2ZQMm1kK0ZQTitt?=
 =?utf-8?B?VEJVbENjWU1UbUVNL3BveGQ2SEJObUNzVnZOTHhZQkR2RytzVFZUb05SdjVD?=
 =?utf-8?B?bjdLSnhZdm10LzRnZDl2QXB6c1B6L2cwWmhTNGJLR3VhaTN0RHl0a3lOaytx?=
 =?utf-8?B?Y1Y5SFBpVmN0Rk5RVUpBZkpUK2lZLytUSXZHZXJPV3pzKzZyRi8xMHZRS0U3?=
 =?utf-8?B?K0dCZXk3MnVHdzd5eEZNTkl3YlFmbmJRMDNUK0RuRkJ1aU5hU1pTU2taVXpP?=
 =?utf-8?B?QndmSFNYMm5RWktjeG13dzJxRzFCY1NQRXRGR01ac2RLSDhVbjg0d00wRzIx?=
 =?utf-8?B?VVk3OHRnaHRzajNpV0xJUGlpNG96TnJPem0xZjdaZ0wybmRjaGY3bmh1KzhZ?=
 =?utf-8?B?ell6Mm9HWDJPOEIxSGJDVjFOVjFaM1Q1RWJIZkFpU3BrTTJBVWZNVkVrYlJU?=
 =?utf-8?B?NjhhM0JyWStUQ0lMdkorSlpVS3Z2elhUQXVTOTVjeENWYStTVUpDZUhVY2hS?=
 =?utf-8?B?aTRvWm5aVXRMZmNYQURBNkFBOEozY0ZRMHN1VTRCdFAzYklQZWE5OG5kczRC?=
 =?utf-8?B?Vitya0RQUDNLekJPUTZBa29BODJTK1ZUT2RtZnBpYi9FblpDeHkxdzZBckky?=
 =?utf-8?B?M1Z1NFViNDVNb2dMNzlCTmc4elNscjJodGt1eEtoQ2hHR3BlMllxWVEySXpQ?=
 =?utf-8?B?cVo0OHdid1gxZ2dQMktLOVA2bEMyOVhmaVpoS2JvVFA3WFBmeWw2aXl2SUpV?=
 =?utf-8?B?ZHAzK2hCRDlZNWpYUUpxRnk2bVBwZG9XRDVmRU5kdmJackRXV0xJN1BnMkkx?=
 =?utf-8?B?QlovRFQ0ajRUZXZWaFNUZEk5VjdiUHdUYXVuUlVzVXl4ejhUNUsrRFZaMTdE?=
 =?utf-8?B?QVhzUkwzTWU4NXlJQzBTMnZ3TlZ1aE9UZ3l4VStUeUdtcmVGNVNjUWcwN2xk?=
 =?utf-8?B?OVh2ZTJoYXMvUWo3NWlRT0RDYUM1ODZVMnZwWElzVFUrRWdnTmRaYTRPTkZx?=
 =?utf-8?B?OXRtT1RYek1LMllnRkd2MUhjK094VEFWS0VxT2QvWk9RcUhZS08yNTkyMUFE?=
 =?utf-8?B?OGE3UTFkMEVjUEh4cG80R21pRmpaN3ZjMmI1a24wOTZvdFptc2l6K3BaNDNt?=
 =?utf-8?B?ZGdKYXVFYzZkUmU2blQzU1hkZ2lzT3F6NXFKN1MrTkFrdS9tRzNVcWNRaVB0?=
 =?utf-8?B?d3gyZ1dldTJPQWtvNWdNbitMYk9ITUtRNExTUnhIb2JTdlZmckd6eEMycndt?=
 =?utf-8?B?d0Y0VGpNaWFZaWhWNUZJbTBuMEVrQ01xb05KZGF3MDFyVVI1ZC9xcnFmM0Fo?=
 =?utf-8?B?dGJ5S0RWZmtwbFVKVmxkcndaY0dCbWRRS092VERXdXBDRkZVdjZORW95UENM?=
 =?utf-8?B?NGF5ZG10TmkwS1d5VXBBWk5RYUh4dWhtSHRDVnMvT3B3VUVWY2l3ZTRIbDdV?=
 =?utf-8?B?Lys5WHFPRXBqR0ltcFpvV0FZbXJRc2oxbVNmcGk0am9uUmpLRXdNT2xnU0xa?=
 =?utf-8?B?SmUzNFdkRk5IZy83Qk1JbmwwczF0cWJHeVZUZzdsbUZJOVhrMW8vUnBTZG85?=
 =?utf-8?B?SEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c66a34ae-b6a2-4fce-ab17-08de0ff08502
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 15:51:23.6066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F6SpJIQnZWwR+qNTVImy2fSBnmZUVoj3d2iZWrSxmxjEorwAZpzDz2F16PzdotirpxoDXKeMlr6nWuXbofhpihbZK1JvbvxtBUzsTvFl9OY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7243
X-OriginatorOrg: intel.com

From: Markus Elfring <Markus.Elfring@web.de>
Date: Mon, 20 Oct 2025 16:02:56 +0200

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 20 Oct 2025 15:46:11 +0200
> 
> An error code was assigned to a variable and checked accordingly.
> This value was passed to a dev_err_probe() call in an if branch.
> This function is documented in the way that the same value is returned.
> Thus delete two redundant variable reassignments.
> 
> The source code was transformed by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by Alexander Lobakin <aleksander.lobakin@intel.com>

> ---
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c     | 3 +--
>  drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index e42d0fdefee1..0bfd761bffc5 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -1248,8 +1248,7 @@ static int prueth_netdev_init(struct prueth *prueth,
>  	} else if (of_phy_is_fixed_link(eth_node)) {
>  		ret = of_phy_register_fixed_link(eth_node);
>  		if (ret) {
> -			ret = dev_err_probe(prueth->dev, ret,
> -					    "failed to register fixed-link phy\n");
> +			dev_err_probe(prueth->dev, ret, "failed to register fixed-link phy\n");
>  			goto free;
>  		}
>  
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> index 5e225310c9de..bd88877e8e65 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> @@ -816,8 +816,7 @@ static int prueth_netdev_init(struct prueth *prueth,
>  	} else if (of_phy_is_fixed_link(eth_node)) {
>  		ret = of_phy_register_fixed_link(eth_node);
>  		if (ret) {
> -			ret = dev_err_probe(prueth->dev, ret,
> -					    "failed to register fixed-link phy\n");
> +			dev_err_probe(prueth->dev, ret, "failed to register fixed-link phy\n");
>  			goto free;
>  		}

Thanks,
Olek

