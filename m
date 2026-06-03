Return-Path: <netdev+bounces-294741-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oIaxLwIjIGr4wgAAu9opvQ
	(envelope-from <netdev+bounces-294741-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 14:50:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA73637B15
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 14:50:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=bFhP+6J0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294741-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-294741-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BDAE83007ADA
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 12:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB83C46AEEF;
	Wed,  3 Jun 2026 12:46:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD6F47F2FA;
	Wed,  3 Jun 2026 12:46:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780490773; cv=fail; b=kiCUlB4w230+9Ah+xLRIoo/tAo27Sc3cukLqqQx8OhZMYZ5lvGMWP74R5q/wfYEmhxBQkAOYA14k5ha69PuLQHr6BBnSt/n2cWSIZY4V5TaVtSaUSMsornY5FBBdQdvkwodyOzFjHEjgqZHqrC9T+BoDqYKQp8v9T27DVoK8nU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780490773; c=relaxed/simple;
	bh=iFK8j0clds6sb58LduNus9fxIfQDQt12YDR0W6ySepg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nphwj2BuupjxEgGTMaTbe3YgpAPenLXMKFFPHp+7HUdhaB9G5nvc9QB1YMFC7irqo6YLjhxz8C17aL1FiC/vxifqKdJLpdiWkgKvIMPjrZ6AIFApgMw36z4ZibPAoVNs+5PLF6wLIAThmo1eC2uzE/NVI/VvPhB2nGr7onmaCd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bFhP+6J0; arc=fail smtp.client-ip=192.198.163.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780490769; x=1812026769;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iFK8j0clds6sb58LduNus9fxIfQDQt12YDR0W6ySepg=;
  b=bFhP+6J0gY+etjDDwpGsoQN35zxpsHErQclvxUZDEyKjrcpNRWcgdMRf
   51CjciKTpIxDsI3TR7XUBN08UC76ODBp3ik/ghyvoEjpvJQrNaKo6Rc3O
   rzTp3I8dz1sb5Ss+mYhqTE6Akx/t/t62ox9k0eY4KSQm8RHd7VvmEgVAm
   VKzOm6h1FD3czMtlqGHZjywlW6fEilp3ZygI+gHoARypfbtlET+juCaCA
   zm5QWPwr2r/bepUBOKYLF8eIcqN7H4MrsYUtUhhXI+MOAS63qrCMe7G3N
   Ha/aKiCXUOs3aryWc/N0quvHQ23dEjgcVK2jvFonZ/OQhx36So3rsheXe
   Q==;
X-CSE-ConnectionGUID: WJZo59acT6GNy9928eGAGg==
X-CSE-MsgGUID: uuJRUoqeT1SGoN6txIOHcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="106749886"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="106749886"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 05:46:08 -0700
X-CSE-ConnectionGUID: svit2qEdQd6BhKRQ0Hm+aA==
X-CSE-MsgGUID: G7FQNzqAQB+P4F6VAK7pbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="237883292"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 05:46:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 05:46:07 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 05:46:07 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.52) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 05:46:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXsijr1r2uYOWCebceO+QFromPWwzEqKu7cdhuNyLF3NiPvGaHZOTOetiBbFtz7cJV4hDrX/J0vGkFgmGwveeybwoR9T9ztRj3h8Mh8Za7zJ0HEh6KF8xrAcXAuGgyvfXG75lQSgEy0fPBBuT4ArjBR36tUyOa/Ulp8Vt3nDQykgommvsUBgZfE3c0SZc9uiTKToKRkELA5QNPvwNUs9qg7yuTXl2sGlABgl4aIhQgA2hp58aDZjoL4T4GOUQpbHZcVxijBVkhMgYjTiOvEKw3H9Wi5L0HWYrVlFW5fkgb3ILdcFZmy+EisFMv2dMyeQ1n9PQ35cJc1cZD0MCX7j5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgWBWSKqDNuRsLQwQ8gA3t7KKLuGcwJW1wMdjHpSNYQ=;
 b=guLYiVOL+Aj2qWqkBz587eN5KnTEejF9oykl5wowtypfw/5ThJ/osmuhUiISJvC9kC36m/fGpdLlakIWgobIfyQvpep6ywRTGRxtjfwP394PH8dpKYZYp3sIZknPDqAWgJWKvf3DZaSAeERZIRuLO36X+CWHzmolhASE03kr3O/82rPHB3JyIq78YPQAPQEWKB4hXWI0XELj4LlcwLXgDqdSpLNWKkVGYrYQIuw0Ku3xj06P2GRAOCRLbrSDepAAo85++yPqqOoZszv6jxQ9ReJ+e9unkQ0qMdorUnJJCdmjAZdJA4sSK1Xrx3+QIyQU6ZM7sk9EjX2deYcO2HY+Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SJ0PR11MB6815.namprd11.prod.outlook.com (2603:10b6:a03:484::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 12:46:03 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 12:46:03 +0000
Date: Wed, 3 Jun 2026 14:45:53 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jakub Raczynski <j.raczynski@samsung.com>
CC: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
	<linux-kernel@vger.kernel.org>, <k.domagalski@samsung.com>,
	<k.tegowski@samsung.com>, <cs0617.lee@samsung.com>
Subject: Re: [PATCH net-next v2 1/3] net/stmmac/dwxgmac: Modify DMA functions
 for future hardware
Message-ID: <aiAiAbasQA3B3aT_@soc-5CG4396X81.clients.intel.com>
References: <20260601162537.553512-1-j.raczynski@samsung.com>
 <CGME20260601162618eucas1p1fb6e7ed11e0a77e709bca37cbc7e4f28@eucas1p1.samsung.com>
 <20260601162537.553512-2-j.raczynski@samsung.com>
 <aiAULX7SlidVGmhq@AMDC4622.eu.corp.samsungelectronics.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aiAULX7SlidVGmhq@AMDC4622.eu.corp.samsungelectronics.net>
X-ClientProxiedBy: WA2P291CA0039.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::25) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SJ0PR11MB6815:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c1b8893-9a4e-4f5d-1186-08dec16e1283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|56012099006|4143699003|11063799006|5023799004|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: YkGqiQ+2c4f+8VqQy+eSnzyDt9R5sb6QAu0de/XV4mpy+t/5P2Wfmp/DCY6OzeGfBMRJ8FivQqaujF19Vp4hJDA9p0paOyLgAeKb8hqdivDqBc/TlMkNVkch/FBCFom39F/KNOOof64k5QUf0NAXLbLYtUD3ClL6SGM3S9PyCCzSWC/SEWkE8fQ7xVrxXGtX5CM3z5Y0MuFz3MHtjf2qTRLXC17Zw95dCaozOASSWojsULmJzHRUSUv9A2af0/ZE22+aHt64sO6fsF2y/o1wOzwqrWeBmQYlL2bHSZyhZonKGnhAwH1dn5HPIxn1T6rYBqGmt0W5EQmoPshIUE2Wtbm+pcBlLkCEDE23fKPzt8qErOjeBERcY9/cFXmGFKyW4U34aZLyg+qgw6Yjfj6xiUZXdadnmLOgsV6IuF2lzkzz9hHJ4S2/s0QokCRgIpT4t8kGpixUPperi80D3LyzCXwPdlLz1T2n2xFkDd6JRBTTFPlkpCOT0hTEwnO3G676/9WatPun823sJUs7flEqBask2sTSdk+DOEAE5dEkEywsS32xGkIJxJnxhHWggqP3cvjCw/RnaskcOZCuglgGZus7vI9Sm827X5fZD2/kv8Bu56oqIBuDmf9i0T9VYu78jDG9noP0TynnpTj7KXBeCuxkA6mrSuY6+pe7Hy6z+NcU8N+TY9Zo+wuE5gMF7zuX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(56012099006)(4143699003)(11063799006)(5023799004)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5t6vnoXSBQmaChfZPfINggAvf8BwjD3vpk/ombCi9iQ19W+mARsZmkbpyxaO?=
 =?us-ascii?Q?ZItGK/MvetlSQEgc0UsORU1bksHOGjVNFH4MoOCYf6CcmqwU6N0NmhTqpLnv?=
 =?us-ascii?Q?cKzbcyKQ7BjNih4R8B1bOjJ2Dro3cCESbyFPt568SjCruPbG1Dd7Tlnzuvku?=
 =?us-ascii?Q?T/OlzlmCwxMbE3MfhvuPcqbZZd20w9w/fdLtWBZm94smLu083qLgodm+/rKq?=
 =?us-ascii?Q?vKfSOgkiajGdMyR9ta+f9kVZWiKDpX4vWG9i9dXxfytRZv870gSbvtq/ieJg?=
 =?us-ascii?Q?2Yx1j9psGEdffCkMasBmAHGbd/9SjG8wBMHYJhb6n1NMxQmXe3bu72zAOAGs?=
 =?us-ascii?Q?S5As5VUj8RakwXCBleMSSNtbtCxoAxqfNSxhZmj2BuOAvTIbb/siAuXTXwzA?=
 =?us-ascii?Q?fV/ER+PDoL0rq25M624CMpzqyMcoS9fsP3SMNX3BRX0+YUjI0VHfweq9t/+N?=
 =?us-ascii?Q?mKjUt2MXXE4KjqOfRqyqZiQRoincNrPQiDEd12W2jhjSUqnt36FmatiQOa6A?=
 =?us-ascii?Q?lwmsh8jfeAsDpR2IOdId2dbAdoXw1BhHpUYLZBw1gSODM6ITRA53gcNJ2YJP?=
 =?us-ascii?Q?5pl/RVWg84yPPkQQdu+UNl4+aqah1PBzvq+NMwg2PaN6ikC7HC10fUbDQseT?=
 =?us-ascii?Q?2O93GKcNcrYFqwE/IiMIJxDjnSTtOBq+PomdmQRvlUaeLe4av8Igo9E62DAD?=
 =?us-ascii?Q?I1iKjDV8drh+vuZoV1RFp7F4WrrPWL+OUSuNdDJPQw5mGHeW47v+FHeK75M5?=
 =?us-ascii?Q?UUlGWLPO5CxeZ5J9yM8PxIOns0UGjvXSGi4vZnJz/2mI2/3JtuCbct+KNRrp?=
 =?us-ascii?Q?vv9rrMq41HvlHR+k4E3BZDzS0jo835loMRxe23L8bPtQIvFrLUvj/6OfxFy4?=
 =?us-ascii?Q?1YJT0YRO7N91oo/PDs7olTkC4u/1yzBtsjrIMkr7EI+t07yopKQCV5Rt25IS?=
 =?us-ascii?Q?g2N49Pxmz+vkLFp8L1/5bIspam7gcMePXFHJFr1MDjfPPSlC7Dzr2VWG9+Qg?=
 =?us-ascii?Q?si92NTUoKd4NYgq6hxhYi0k3aEWjQtggrEgyiXrUI51z8F62kv7xhKxwpnbu?=
 =?us-ascii?Q?TM5PzrBjCN1lThAh4a5rFQq9U6hVE6auwDgutREp/24tvbd6PHscIv2qEoRs?=
 =?us-ascii?Q?wdAX9oagh66Fmt1NNp3PbKeklNVLV4Nq33+aTeGDtRm1fbiHjEvmMY1lQAxW?=
 =?us-ascii?Q?i978BzQDnF/Z9ve/cqfWVwcleEQhjWsmxpfJyJ0yvR0SspXpl3lczg+wT6+d?=
 =?us-ascii?Q?lTCmJR5XFl+kNC+K4oQwkthHRlY6JssVh/RmK9+TFBweivvHb0luJffDHWO6?=
 =?us-ascii?Q?31q+I1yxU/cV6X8p4Jqhq4aU74vc4NCHlfjaGIJNb2OZQckIlEaH8PcQmLmt?=
 =?us-ascii?Q?EkqEhSptZi3kytB5orpDbQAe9mbv2SvM89mL7uu8aoXX7Xhl4yaWbPe90qxf?=
 =?us-ascii?Q?gcAjT0fOfUs3y9iTAeAm1HUCyhrAZoaMOAuMuTfyqq+RV5p99hiLFIPzecLq?=
 =?us-ascii?Q?WuKehx7zeaJRwipq7QPP+dHbON9c/6b5spqZps7+H0da3Iko7VC5FBEUq/MY?=
 =?us-ascii?Q?OFbuC37KaYk8+eUTNvkSdblg/ShrtaQrJjof3DHhvhFsIPORAuiQiBYkdvyF?=
 =?us-ascii?Q?zSqQ4YVTsSQ9+SYhDjQ0r04K+VvFAce+33jz45skivCXDtUg2m5fCgooNsDw?=
 =?us-ascii?Q?V5F1NHRxlVeo2i0PB4YPMi1GvFni4mHVBqxwIkQSZ76v0OmZnQGuha0J0Yta?=
 =?us-ascii?Q?zT+2PRt4TkUrxmBxACnddVI1ACCYGcyIlfMpR1mxaVW93dM2yHbe4kkEb9aV?=
X-MS-Exchange-AntiSpam-MessageData-1: Q3As8D388rYf2wy740Zh11EmkPFO7z9BZ90=
X-Exchange-RoutingPolicyChecked: O9EqptiVSyKGE8wvGtEXMbvPwHDindGvBNNcR6+hKRjIpeyovWxcf3EGZWjIaqHd73W50qQ3NuSJL4pmNs/7FJ9iT47baAdevNA7+xBhHZsA9BB+Rh8iEp6t9E055LD7E0yMGN+8jrYsBSrz97aJOIVTOMdjShbUDcbmNS9XtKwl4uLPIkTStMENNNThcXILngUN6QNIfhaecFTVQeAeZpW9FP+0m2eNI2uXKZlSPklBxfYA90+JDcCSVP5vMGrv11B3KMM4L/4m6XCH+foyxV9/EVQzA/HviF7TJX7mU2wkWV6p8OR0SqYJR73wVKkyuVENT+eODrPVulQpFzJMcw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1b8893-9a4e-4f5d-1186-08dec16e1283
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 12:46:03.6912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R87c/lWSJXcjMpZ4V5/peCC5PSFnJmEFY8IvhVfdJM+hzJuh98nsQDfO0K4sIXn+hlhCAb66lXll7iDSzxJ6MNoqQ23cbgYQZzFgya08tes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6815
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-294741-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:j.raczynski@samsung.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:linux-kernel@vger.kernel.org,m:k.domagalski@samsung.com,m:k.tegowski@samsung.com,m:cs0617.lee@samsung.com,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,samsung.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,intel.com:from_mime,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,soc-5CG4396X81.clients.intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BFA73637B15

Overall looks fine, but some adjustments won't hurt.

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>

On Wed, Jun 03, 2026 at 01:46:53PM +0200, Jakub Raczynski wrote:
> Gonna respond to Sashiko comments.
> 
> > > --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > > @@ -97,11 +97,19 @@ static void dwxgmac2_rx_queue_enable(struct mac_device_info *hw, u8 mode,
> > >  static void dwxgmac2_rx_queue_prio(struct mac_device_info *hw, u32 prio,
> > >  				   u32 queue)
> > >  {
> > > +	const unsigned int numtc = hw->priv_data->dma_cap.numtc;
> > > +	struct net_device *ndev = hw->priv_data->dev;
> > >  	void __iomem *ioaddr = hw->pcsr;
> > >  	u32 clear_mask = 0;
> > >  	u32 ctrl2, ctrl3;
> > >  	int i;
> > >  
> > > +	if (queue >= numtc) {
> > > +		netdev_err(ndev, "%s: invalid TC queue %d, supported %d\n",
> > > +			   __func__, queue, numtc);
> > > +		return;
> > > +	}
> > Does this artificially restrict the configuration of valid RX queue priorities?
> > It looks like the queue index is being compared against the number of
> > traffic classes (numtc), which could prevent mapping priorities on valid
> > queues greater than the number of traffic classes.
> > [ ... ]
> 
> No. These registers just don't exist to support more.
> Synopsys seems to have done this this way because there there is no free
> space after XGMAC_RXQ_CTRL3.
> So if this becomes a thing, we will have big new driver dwxgmac3.
>
> > > @@ -246,8 +263,15 @@ static void dwxgmac2_set_mtl_tx_queue_weight(struct stmmac_priv *priv,
> > >  					     struct mac_device_info *hw,
> > >  					     u32 weight, u32 queue)
> > >  {
> > > +	const unsigned int numtc = priv->dma_cap.numtc;
> > >  	void __iomem *ioaddr = hw->pcsr;
> > >  
> > > +	if (queue >= numtc) {
> > > +		netdev_err(priv->dev, "%s: invalid TC queue %d, supported %d\n",
> > > +			   __func__, queue, numtc);
> > > +		return;
> > > +	}
> > > +
> > Because dwxgmac2_set_mtl_tx_queue_weight() returns void and is invoked via
> > the stmmac_do_void_callback() macro (which unconditionally returns 0), will
> > this early return cause ETS qdisc queue weighting on higher queue indices
> > to silently fail? 
> > It appears userspace will receive a success code while the hardware is left
> > unconfigured.
> > [ ... ]
> 
> As talked in previous mailing, answer is yes, there will be error in dmesg,
> but no fail, for very simple reason that we would need to rewrite A LOT to add
> proper error handling.
> I just hope that if user misconfigured this stuff they will read this error
> and fix it rather than complain.
>

But previously those callbacks did not have any failure conditions, so I would 
say that adding a message-only failure does constitute a minor regression.
 
> > > @@ -357,6 +388,8 @@ static void dwxgmac2_flow_ctrl(struct mac_device_info *hw, unsigned int duplex,
> > >  			       unsigned int fc, unsigned int pause_time,
> > >  			       u8 tx_cnt)
> > >  {
> > > +	const unsigned int numtc = hw->priv_data->dma_cap.numtc;
> > > +	struct net_device *ndev = hw->priv_data->dev;
> > >  	void __iomem *ioaddr = hw->pcsr;
> > >  	u8 i;
> > >  
> > > @@ -366,6 +399,17 @@ static void dwxgmac2_flow_ctrl(struct mac_device_info *hw, unsigned int duplex,
> > >  		for (i = 0; i < tx_cnt; i++) {
> > >  			u32 value = XGMAC_TFE;
> > >  
> > > +			if (i >= numtc) {
> > > +				netdev_err(ndev,
> > > +					   "%s: invalid TC queue %d, supported %d\n",
> > > +					   __func__, i, numtc);
> > > +				/* This will skip all other wrong channels,
> > > +				 * but triggering this is preceded by warnings
> > > +				 * from other functions, so limit the spam.
> > > +				 */
> > > +				break;
> > > +			}
> > > +
> > If the hardware supports up to 16 transmit queues but only 8 traffic classes,
> > does breaking this loop at numtc skip TX flow control initialization for
> > valid higher queues? 
> > The XGMAC_Qx_TX_FLOW_CTRL registers appear to be per-queue rather than
> > per-traffic-class.
> > [ ... ]
> 
> No, queues are in order. If dynamic queues get implemented then maybe?
> Depends how this will get implemenented.
> 
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > index 3591755ea30be..5917bf47c7de6 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > @@ -4140,7 +4140,7 @@ static int __stmmac_open(struct net_device *dev,
> > >  	u8 chan;
> > >  	int ret;
> > >  
> > > -	for (int i = 0; i < MTL_MAX_TX_QUEUES; i++)
> > > +	for (int i = 0; i < priv->plat->tx_queues_to_use; i++)
> > >  		if (priv->dma_conf.tx_queue[i].tbs & STMMAC_TBS_EN)
> > >  			dma_conf->tx_queue[i].tbs = priv->dma_conf.tx_queue[i].tbs;
> > The tx_queue array inside struct stmmac_dma_conf is statically sized to
> > MTL_MAX_TX_QUEUES (8). If priv->plat->tx_queues_to_use is dynamically set
> > up to 16, does this cause an out-of-bounds access that corrupts adjacent
> > memory?
> > I see this is resolved later in the series by commit 9cc40baf0739 which
> > increases the macro to 16. Could this intermediate step in the series break
> > bisectability due to the buffer overflow?
> 
> Nah.

Maybe worth adding a WARN_ON to indicate that such case can only come from a 
programming error?

> 
> BR
> Jakub Raczynski



