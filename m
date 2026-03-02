Return-Path: <netdev+bounces-262935-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NF2DuEWpmkCKQAAu9opvQ
	(envelope-from <netdev+bounces-262935-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 00:01:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A261E62E2
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 00:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF69C3015D9E
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 23:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0722DB790;
	Mon,  2 Mar 2026 23:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mVAmlRL5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B31430B514;
	Mon,  2 Mar 2026 23:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772492484; cv=fail; b=QGObkN9il4DTMIP29PPqFmM6AHfjhhbnGuzkApy/azvQw9wBURrcL1STnx3h7XgePErXB7eNXNqlH6uOXHCN2viAxW02QQjs69RQ6UX/+bYHVf2J60Cv5u1YkQo6paZSQ70lzzF0cC62NIOJIb8dWXmb9jncSn3Oql15sPAYi1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772492484; c=relaxed/simple;
	bh=BRnagR9pnTB0zMV1MK34h4tVyp2xO3CJV/w/g4lIn1I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lgz9/bkIC9E6Fk/SZe7XbOJDWYFw+8O46rZyZmbJ1EkwAk5Qp0jCuegfHs1UzipC+N53kH9h0pEqnQ5xrfPkJ1+v/kKdBOe+QKx20gh/rDEyQzcCoWIBki58lC8QbWoJoG1Az7nKzRtXUb72Cw/nEOK6bcUZ4GxJkTcRMIxi0X8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mVAmlRL5; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772492482; x=1804028482;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BRnagR9pnTB0zMV1MK34h4tVyp2xO3CJV/w/g4lIn1I=;
  b=mVAmlRL5qWB5L90mUP136keu7FqRVbUjbqYJ7StpzPCIJ5fPrPayx6Vl
   cbZfpEyklXb1NvMVYcmEBjaLIuCbv2icW/OK2oVAQzAD3+zLOfPGglcje
   H1QmkpPazKK+WuX9ETGboQkz7xTAd4Z4n59JIb5TEzx0fLf1by2A4ggvQ
   Jlhu4AjKEHJPkKd3Yr/4AT011SIpQA2p2rdwufX29if6ukvE5gGV/tlle
   zoNl0serfnq7ESG2Qgirmo6dEiuH07OdLjcJcQkQzQUgvxoMzwcuONRmu
   FuM3pJJYICnOHpvGS3ZKVdY35Y/stEVGRsiHBYoHpytM85PR66gKgjZwY
   g==;
X-CSE-ConnectionGUID: Od5+WP3NSaq+2nPwy1hamw==
X-CSE-MsgGUID: k69S5fahQZStUUPCRw0B7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="76117929"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="76117929"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 15:01:21 -0800
X-CSE-ConnectionGUID: /e9TGeTwQDeFLUnga9tn9w==
X-CSE-MsgGUID: KsLrQX/2TZWUQvH/7Euyog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="248300334"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 15:01:21 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 15:01:20 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 2 Mar 2026 15:01:20 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.18) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 15:01:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hdp4OMNcHr+rFXHmGVUBM185CletcdCh1wlqrmlbRZ8zurfbSSZU8vfcpuQX7hpwSm9a7CJMiAU4gAByA96XvLlOfHBnsbpGOWpUnEI5pgbijWUypVwuzWs4ntPdM1JL3KTNpycG/dCYmDT4UoUTbz6JbV7XUm2hNN5qNLpHk2AWikkLkDPia/F1lwrQbePh/1EeIs0jTrUV18Ot0KISbG40Zigbi4/82edWlhR5y9OIsIvWUDYV2aSKtgnPMO7u2FU4G8u6fqTmUyZZObq3MpX5vZSVZtLeJC2t7fb1lgSBT/dHj99Wlea+rcbgo+4MQTSnjVsPLsNd/FF2E1sucQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVY3BH0lDkwHV0LItMBInjm1B0JDnwtS4Ofu+vk8l2I=;
 b=dWxgfOdlQ6oprdUXxYmSHK0Kx5pLxPpJvS3ugRJ8ZN2R4wY3ZNpp+Iv1pYS+R0wvZWiJdwKELxg8QcED0nEW8ociNC+Uv7lvIr29/tGG9XTrV8cc9l7nIgpiHcr58zCW2WcMCvQrPfbreh7Ghps4cC77TT0SuVnXHlQzosl6rGZ8s3Emio0x9QWaOmW43/ROCN0vn7SZC9LgiABdaPounXPU1RReSe25IO+EEch9q6K5nJuqh/0xjbbzrsfAXBZ+NkL3Z9cUHQsZRCSj5Um/UEMlqCKEn1qoqpemvyvuE54iBCOXI+sZ+TW3wSC5VuS6YpN4nDsT1nNKcNyyTsDQlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 PH7PR11MB6956.namprd11.prod.outlook.com (2603:10b6:510:207::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 23:01:18 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 23:01:18 +0000
Message-ID: <4b8e99fa-9f4c-48cb-96d6-5479ba177948@intel.com>
Date: Mon, 2 Mar 2026 15:01:15 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] ice: use better bitmap API
To: Yury Norov <ynorov@nvidia.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>, =?UTF-8?Q?Thomas_Hellstr=C3=B6m?=
	<thomas.hellstrom@linux.intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Andrew Morton <akpm@linux-foundation.org>, David Airlie <airlied@gmail.com>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	"Matthew Brost" <matthew.brost@intel.com>, Paolo Abeni <pabeni@redhat.com>,
	"Przemek Kitszel" <przemyslaw.kitszel@intel.com>, Rodrigo Vivi
	<rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>, Yury Norov
	<yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	<dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>
CC: Simon Horman <horms@kernel.org>, David Laight
	<david.laight.linux@gmail.com>
References: <20260302011159.61778-1-ynorov@nvidia.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260302011159.61778-1-ynorov@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0021.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::26) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|PH7PR11MB6956:EE_
X-MS-Office365-Filtering-Correlation-Id: 7483c0d1-9448-4773-a518-08de78af9ce9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info: VjkTa6GeFLbkhFKcvkwZ5ww+OacrArtOvYaetn5ugsWBudwKxDtolPJ0EUSOARhixT+uxnWMLL3wPEFps+Omk175kmq7zJrg1S0DDlmCS8dRA7Ij3lKbU7akPnaxjoPD0Qmz0E6btImWMOItBdftdoktfnYlAwEcAuAg8UyeN93+lMi1Kpt1VQhBEogMfkiECaHQJWDSe2rhfskilcx5if/7Z2LdLQPrqN10HR9VffzoSa7rzf0yoTXuaUBgSgU8Kz4uHD3YBzCb+w9a3JeLE/s8PNqgNolsrbXtwSddy8eJK1cZlJ94Een+9q3d6NfdAuDOLGu+oS7p1lUvukIGcuZy/XbnAyVWjxd2Rv1MPD6jlk5HPMht1B2VnzEtnz+31M5THt/PYlRitSemmzEGMJ+yrf/2sw+tAuK8XEqZdF5XZF9qkdQnA/lHQAsXqA97LdTZQWCPl+Dh0mB7G/TvrsiWxYt2OYsqldn9x57TvpvrMLSMOxLmCitlp/e6tW1GBLQ3QDknZuDLkaa5z9PeSNY6g8A9Mn1FdEqnpR39dvuCnts1k3L6Ufwc6NlHmFQb9tAgicRddnUFgve7nup1in97b2V9EdmXZIGxVpqjstVU8Qdy+S6c1y2iDxdCko/AaTIfhM/hkcjYm3o7H7AfKiosoI0T+kdJnHFww4qGNRXFXDp6Brka9rO8W+t8XxtJ3XLyuUtt3Wn4XtmC/MQ766Jg6gPFy4Dogf5snYyenSqC4cja/XoHKw0LKHwjgZ6/PD/TExJaQ34OemV5Wca/6N+7LnLwvE20xw9ArADh1Qw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTBwVzVWekgwd3Q0cUhVNEhXa2xpN3RZREZOemxySWR5SG03ZENIdXl0Vytx?=
 =?utf-8?B?TjZ6WE9SVU42aFljRCtUYkQwL0luY1JrL0V3b1ZjeWJxaFZaTlBCTENjUzND?=
 =?utf-8?B?Ry83a3ZBR3dOU2IvMVZrcWxGaEZETnU0SURTQkRyQlc4NGxMcmE3dXBNdCtN?=
 =?utf-8?B?aHR5TFI5MXV0TnhRS2RVUFNlL1haekFKTU5QRTNSMHdWalZKVkI2bjd4Y09F?=
 =?utf-8?B?VGEzendwSXNmajBwZDEwNkg0SjhNQlc5WU90elY4TEZKeEdDWlJEUlprRTRX?=
 =?utf-8?B?K0lUNG54aDBBenQ3bGhKZ05WV1cybGs2MkJBc2p6M0t2Z1RDUGtPU3pBeXBz?=
 =?utf-8?B?OFlJclZ4RjM5QStRVkpXSWM1U1VvWGNmTmIxdEo3eDk1NWUrU0xLTUNPRlRw?=
 =?utf-8?B?ZHZHQ3lwbUlLVUNGaUZDVXZ4cXBlaHAydWhmWHN5Qk92WVJuTWNyWDNFRjlO?=
 =?utf-8?B?c0xxSUdCU2pXU2pIYmxkS2t1RmFocFg4cktHRWxSVmVGUHpidlJsZ2RUNFE1?=
 =?utf-8?B?UVo3SHhLSHdjYWtWRWNXTFpOQll5OWRwN0J3TmpmWHZyL2c1NUg5Q2xyRTRF?=
 =?utf-8?B?eGlCWjFpOVJRWitlZFBqcTlHZGpHSitDZjFMeDNMaDhWMFc2RGhFSkpMaHB5?=
 =?utf-8?B?MGt4Vlg4VzhNd3BReTVzcFNHNmh6eitha0FEYXlnZnFDOHFtaDhwUFlyWXRO?=
 =?utf-8?B?akpsS0NyZlRvV0lYUzlRZGtvYzBEdHduTTdRNmEzYlBMVExLWkFrYlFIcXZW?=
 =?utf-8?B?bm8zOHhvM1VMRGZpdWNHS3FYMGMvNFlSMTZ1c1dDdzgzbjFiMmthQ0VIR1o1?=
 =?utf-8?B?VHdMWW5LdDI2ZmszTVdJNFdOb2g4OWFKVmlodG9uL09CR2JsbUNlL1I0NkIz?=
 =?utf-8?B?MlEzT3NLSk9ZdFVQbkN4RHBGQnV6Wk1wM040SlhQZTQ2STdBKzJqSDNwWXkz?=
 =?utf-8?B?YkE3aXBsV3QvWnh1ZjFwOTRHTkZodHRURkFJQ1U1M0FOVlpjWFh4ejNSMUc4?=
 =?utf-8?B?S0p5WFRpTE9iL2pzU2RWWGNlRyt6aDhMSGlGN1dXZjFJeGNyOU9BNWd3WHJz?=
 =?utf-8?B?Z01GNGFVcExaTk54Z1FSTzAvUy9ONTFtRmk5VUNoYkZIdzlOZC80YmcxcXQy?=
 =?utf-8?B?TzlQVFpTcy96bFF4cVV0N2xiVy9GWGd3VmFQN0k4ZFFYSkdpUzZOcENXU3Vt?=
 =?utf-8?B?dW00UHBIRmFJK1E0QlgxblhCazhOaFA1R2ROcEt0azlZQ044akRBVDV1M09v?=
 =?utf-8?B?TUdIY0p6RDFJMDhlNWFyUWxqZEdyMTZDMnk2aFhRYnRSQ0hsK0dBNFFuVFVF?=
 =?utf-8?B?aXdqSWVoN1JDakpSYzA3UVo3S3dObkY2cGgyTVlqNGRrR0QrOXQ1djdWdFNV?=
 =?utf-8?B?ZGRsTzk2dnZBeTRvWnY1ZjdLTEQ0Z3hzSkw3cDd1ZTF2Mng3N0FLeURubTFU?=
 =?utf-8?B?bkJnWkRiUExvYWJTc1JOREUzbldXS0tJWmc0Z1l4ZFM3b25mUTR5ckxpamVt?=
 =?utf-8?B?OTRWOHhKdVBtOG9zcE5KdG1SUytJK292U2hETTh0UWtqUlBaSWhNNk1KYThr?=
 =?utf-8?B?RGsxQ1VveEVwT2MrUUZhcXV6eDVya1lUY1A5K0xWaVVIa01TcXIwNXB5TlFK?=
 =?utf-8?B?dGxLWTRIMktTQkxaMTdZRk9yOWxOTzArSE12NGVNOEhHZlJweC9MQ1lHUy9J?=
 =?utf-8?B?R29Ja0dnMzB5UndkNHBvbFBuTVNFWGdSSTdxZkZ0NkZxQUJ4ekRTT0RTeTdo?=
 =?utf-8?B?enFGSEFEd2paKzNiTTVVekUwVFNJZXd2cE9XUVp0czl3b2pKUWpkdjBPZ2RZ?=
 =?utf-8?B?NjYzeXdFbTZWQnJHR2dPeTMxMGV5K2hJeTk5bWRnakJ2SWFLdjF0aFArVldl?=
 =?utf-8?B?cDFkckVxS1VpZGJzUSswbUdFYkxIQUNCcTZmdG93WU9YaVE1VVYxRVQzMjFF?=
 =?utf-8?B?ZGZ6YjJGVll5cTUyNnJzVlNzcVJ2MndxMnZGNjdGNFpKbk1IcWNMNEYvQzVv?=
 =?utf-8?B?cG1HVlprQ3RjcDcwM2hVWlcrYWFZNENQRnpxemx0K2NNQzRGM3ZBLzBnTXJP?=
 =?utf-8?B?djA0OVErWUxyZXBZRjQ4ZXFJK0tqV0E2bWl1UGx3MzBsNnlvZmlPRlgrbElB?=
 =?utf-8?B?VXZHTVFoTlNaNGR0NE13OHZpbVJLVWdJcXZscFBOMnFMZElCZnlDeWlxQzR3?=
 =?utf-8?B?NzVIanhZNHpxN0Ixa25RZ3YyQmNXWVBsV2ViQkhDYUhoUVorc254YmVHcmV6?=
 =?utf-8?B?Y0pxZjFLOHoydmRkUUVhZ0xTNTdIcTZvL25TU3JsR2JNa2VDYktZYy9pSFhD?=
 =?utf-8?B?UUpxUGtwei9MdlBEcjNjQVpmTlJGOUZtdHhsSVdsYTJHOFl2bFNCZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7483c0d1-9448-4773-a518-08de78af9ce9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 23:01:18.4053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJXgs2IyBpexHwRwG6V4vhR86XdeRh1tCwJG30VtYZsKYk14VM4ryCq7MgFLPfuq8vaXvdt+rkXH87DgNTftMWFaeSN5oSNlWnvkJVnc3fM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6956
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: E7A261E62E2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262935-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FREEMAIL_TO(0.00)[nvidia.com,intel.com,davemloft.net,linux.intel.com,lunn.ch,linux-foundation.org,gmail.com,google.com,kernel.org,redhat.com,ffwll.ch,rasmusvillemoes.dk,lists.freedesktop.org,vger.kernel.org,lists.osuosl.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On 3/1/2026 5:11 PM, Yury Norov wrote:
> Use better bitmap API where appropriate. Patches #3,4 may be applied
> separately.
> 
> v1: https://lore.kernel.org/all/20251223162303.434659-1-yury.norov@gmail.com/
> v2:
>  - new v2#4;
>  - add documentation line (Simon);
> 
> Yury Norov (4):
>   bitmap: introduce bitmap_weighted_xor()
>   ice: use bitmap_weighted_xor() in ice_find_free_recp_res_idx()
>   ice: use bitmap_empty() in ice_vf_has_no_qs_ena
>   drm/xe: switch xe_pagefault_queue_init() to using bitmap_weighted_or()
> 

Good cleanups!

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/gpu/drm/xe/xe_pagefault.c           |  3 +--
>  drivers/net/ethernet/intel/ice/ice_switch.c |  4 +---
>  drivers/net/ethernet/intel/ice/ice_vf_lib.c |  4 ++--
>  include/linux/bitmap.h                      | 15 +++++++++++++++
>  lib/bitmap.c                                |  7 +++++++
>  5 files changed, 26 insertions(+), 7 deletions(-)
> 


