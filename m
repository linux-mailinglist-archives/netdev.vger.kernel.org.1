Return-Path: <netdev+bounces-297705-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yErHJfp0KWqGXAMAu9opvQ
	(envelope-from <netdev+bounces-297705-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 16:30:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD47466A396
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 16:30:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Vvj9T1G4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297705-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297705-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC61D304AFB8
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 14:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5E32F747A;
	Wed, 10 Jun 2026 14:18:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05CF2BEC45;
	Wed, 10 Jun 2026 14:18:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781101116; cv=fail; b=cqeyTO487WWY+keHAkMFwfyvsvemDJJ71b/u2sLcus5jW2AhVzabRCra07F+V+VGAKAV4+tMwLsRxEePtZ5NQUTp3ZLCwvty4In3rUoLbu43vvClBuSs5ChWxUUVb0atI4S31UAHwhStF1Pl16wvlviGk+wS3cCBGhcvsaEKIxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781101116; c=relaxed/simple;
	bh=Lu14LA87Ga4r2B0SI6SKFabjWnpreSZwrDDFLMnswb0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZwHaGZEsEVkw5/Gwe26xVMe9G8GpsP6ieVb8Qihk0IMaPawUhDSdCNDHrK3kAzc0gPG//F8Lgro5BSKxrw+wy5ISNbbbhF4hw4W2DHnu/a3rG6DZ+pbbcij1zCF60KffkIVF+Ot0AYm5EFHKAwFR2knECO/HVK6B3rga0WEJeKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vvj9T1G4; arc=fail smtp.client-ip=198.175.65.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781101114; x=1812637114;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Lu14LA87Ga4r2B0SI6SKFabjWnpreSZwrDDFLMnswb0=;
  b=Vvj9T1G4MpjnuVxWGewedYjWnMtjn20nZ3kUpx0Jy5clleu0f11u4una
   HuY7ZcxIKauG6k80fbfhkviVOx9GEnmz7S7Zc/+HaK0TVz6PMZzXjcUio
   EmM1OcKQKLU1b1EaJrM6xmtK/OEVLrCmF0j7y9a1MZ3fhV31KzI34OT8I
   MiertxzRozasy4tTQ7mfBvMXLfkhfB63RPePRUH/BxbcyjudWL18tt1qQ
   NEpp4k+DgoSBzcasfCIsuqDz/+ZnbeXPy8hZd8EhI/FLSme7ozd9B46gR
   GkRIJW1HSOnW6cFE+u9dWBI8heOXNEY72ckxSl+bi2JLVOEt9mS7qwNFq
   g==;
X-CSE-ConnectionGUID: JwhD+G4eQlWewnaxH9tZgA==
X-CSE-MsgGUID: Wbta8yfRRZ+347IRb2ZlfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81801812"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="81801812"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 07:18:34 -0700
X-CSE-ConnectionGUID: R584WLszQYWpNf2oj/y5Vg==
X-CSE-MsgGUID: PDOymEo6SJK5RwWQn0Vikg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="248051044"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 07:18:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 07:18:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 10 Jun 2026 07:18:33 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.0) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 07:18:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wr0ccP717kL3+XHef8TqSevbacLuTbAfD5rOcWHybPuuJhJT5B5D3YygvckNS8jPUg1FvloyRm1rV4Yb3rBOtlCgQKn/amOdt7HdWumQ/bVN+zeGDz3j7+7+PfvfinAmKtUttcrqIxO+Yq30MgfrWCKOC1KVwjsql8PM3PVviQLWNdhzh05oehd20GPlfjvVuPK63PiDI+xqWza5bTZo9eXt9cxiAH72SDdSJAgBLwxfZ5mKiZGdb2R1NTDNTKvT3Ut6jJMsrTIJ5vRlHgb6NGT+wqtisPBzsKnp/jR6a0TGO0qfqkrQR1WgLZ8dydunpG+Ch2xus+1cvYYTS6sQLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDvwyPrTLpZubgMD0SOidFrkwKY/oHNuLERa0e5Tg/Y=;
 b=XACHt8TJ5c/Q5dk0m8T0Mmz9J9QAEye2pmo/IWvCIICw0oBJlyC/KDhzRY5jjJrdOoQjKs4ycEta9XDwJQd90kYb8uZZqpBI/Q24DUZYQ98Eg+5njuy4a84LCZsgamvllJV2BCXsLbjDPOKaCXqQEVGnvLpsXxHg+YkxVnDdiSZp98hwTSUnKukcz0xh9IIRRLJ5444wWMf+BIXgVg0cxAHQIa3jw6z3P7lCa3l/A2rFruvKmnt52l83lha4MigmgtyAQjowK8ihztJ0fczwkAvpQDlFerc++LSgmkomXIX0GXADa8H6y3CcwnsM/HNdPOY7I5NUVeb3GuygggiPdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by LV3PR11MB8674.namprd11.prod.outlook.com (2603:10b6:408:217::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 14:18:21 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 14:18:21 +0000
Message-ID: <dfe4dc2f-c740-45e6-b564-d4d601f7c2ff@intel.com>
Date: Wed, 10 Jun 2026 16:18:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tipc: fix slab-use-after-free Read in
 tipc_aead_decrypt_done
To: Doruk Tan Ozturk <doruk@0sec.ai>
CC: Jon Maloy <jmaloy@redhat.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <netdev@vger.kernel.org>,
	<tipc-discussion@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
References: <20260610130046.59867-1-doruk@0sec.ai>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260610130046.59867-1-doruk@0sec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0051.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::15) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|LV3PR11MB8674:EE_
X-MS-Office365-Filtering-Correlation-Id: 86a80d7e-b532-45eb-8ff9-08dec6fb2002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|11063799006|56012099006|83080400003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6+uUV5Qcyd7ScCg0+9O5STmWJ/9WZQ4AonpN9mffnK7FueWUGTU9ZjBVG0DetVf02hIUSSrKW1AJ82Gt1w9K04a/Ay2QuxUqZkKWQI+9N1rPxy4GML3CLAn5M45Itf4KWDmxB/XFc376LOTHZtyfaj6Po+9Zic1qaEULbAiKFxmVBoLVtkj92sO5ublxjLI2BbHAjrTqThhssQPgujPd+XgHgn8R+mtGtV1IZQQFLr0feHm4x/aH1woEvdaNJWtH6XJEBCAs27mCFvrYCefBj3h2SnVlvSzC+eiA7DbsMZ/aj7SXfh1ohwKgsn8w84qIns+5VItKQAovl1xR/gCNh01vBg15bAwkfNufMCV32lK8SqaISXASYnmB/ph853Y6Av6RXVM9EucxRHrhbocLcL6+kwY9d9vE0l3sUy+2U+/f7oUmPNWNzyYkIv4J7fq4JbANwBdWNL4NsmR4RJnlfZd9MDgR/+Jij6jEjGFBZtTOtdn7l7pGUf8iBS3nAWtQsCy6WBJvz/sK4nIKOSD/q6F1r0vH+HeKiFTkvUmB1nCUmPm71x+0hV2wvlPnOY/oN/9TcVNegae1TH0/I0hS2Yk6ZQUjMhWSUOSWCor/5j9rLWzq+RICxEkZVvWA5vZ1+mLd6UQqHV5969vd/Q5krpMOFgDOI9klU9VkL3GU2LCTNzt5dCygcjZVgTz5dEw+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(11063799006)(56012099006)(83080400003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzA1TkFndW9xNElHOHNoVE5oMzlpWE1rUzZ6Z05WTW5aTmMzcEV0cDhLSm5z?=
 =?utf-8?B?dEhJTFJIemNuZFpIekxRQWUvaDk2ZkVHVjBSTitWQy9YK3l5RUlXanFnQk1F?=
 =?utf-8?B?b0RFMk13NUVHQXBsL0RKeFViL1I2STZjV1JLOGJYV0tkanVtbmtNczVNZkFi?=
 =?utf-8?B?a2I5OTd0UXZhUGZtcURGT0RaM0VyeWV5bXkzMm5URXRCeVlkb3d6c0RkeWlH?=
 =?utf-8?B?ZURLdWhKYzlUVndmcHdjMXpqTGZWT1hwVmZ5RHZQcGUrZUN6aVFlRzVxa2VR?=
 =?utf-8?B?MllHTWdIdDhnejJUVk9mcXNDK2tVUHdjWHZLM1l4Y0djQ3M2WDVRVHgza0x6?=
 =?utf-8?B?OWEzVWxkSHhGdmd4Z1Z6b3ZhK3pJQ2psZytBZmJ1aG05dXAzSlVlTXhCdHFx?=
 =?utf-8?B?eC80MEJYK3hLbkZXQWJJdjIvU2s5azdtVUdCSDJha3FBTU0yT1JtNUFxUUVh?=
 =?utf-8?B?WDY4QUxnamFTdGYzYWZ0WVBnSWlNM2FPK1FQZzM3MHVlS0hmTFFnTVlIQlR1?=
 =?utf-8?B?SW1WM1dlRk9YY1psdWpVb3M2WkFTZGhxbFlPczJtVnhTMlkxd0xxZHc5OGlD?=
 =?utf-8?B?YmhtVWdyUWpMcm5seGZWamtveU9ia2cxdlJnTjhpQVpUTzhyVGVMcUZjSHRS?=
 =?utf-8?B?WWZ6WkxMUzBmdzlqS3dYSDJHd0UzSk43b2pXSzhVbkQra2ZQWXFtVGJjQUZw?=
 =?utf-8?B?ZDNwUCtGVjlPTytOQTdCRjVXWEtZT0JENHQ0Z3h3d2FINmQ4dU1qNyttSjNz?=
 =?utf-8?B?Tnh1bC9CZXFMMEZHVVRTTnAwRkR4WmJkcG8xbnE4cjBGVFF3QW9vUDJlbkZy?=
 =?utf-8?B?MjJzUXkvQkRGckd4MzVnbURpdEZveTNCQlA0WDk5OENoT2Z6V2xWUmRXeTNa?=
 =?utf-8?B?c1RDNlNKYzVyM0J5VzdWK3ZMdktzM3VVVFJQMEQwN2MydnZhaHZKQVI0SFZD?=
 =?utf-8?B?Z1JPdUpQUjV0eFRwNFlLT0w2bWsvM0Vnb1lRZlJ0Rmprck96UWRhcEFDOUl3?=
 =?utf-8?B?VGt0ZU1VcHByTm12UWlHa2dleldHVm1jV2JPYzVVSERXQTMyL0FSb3hneHZF?=
 =?utf-8?B?VHF2Uk1qeDU3MVNCdlFlUFRWSTVzdnBOTm5jU214ck9RUmZQSmJYOHZyZ0VT?=
 =?utf-8?B?bWs4ay83c0NQcktSS1diTkRmL3BuTXduMU1DY2VSUGtVVFVJdGNXVUpiSzd6?=
 =?utf-8?B?SHltY3BXZ3c4cWw0TTNrUkkvS1JHeHd1TmhYeFU0ZXd2YUR5OWJIbXhCWUo0?=
 =?utf-8?B?Wi9Td1BmQzg4QWVYOVdpeHAxd1Y2TDlnLzd6b2Y3V2VSR3BsVGJhSGlYOWhH?=
 =?utf-8?B?bkp1Q2RSbGFmRU5HbWh6RWVrZ1play9uY0RZb1MrQytsRDBoK1hIRlJYZjA4?=
 =?utf-8?B?NmRoK1JmS3RiNDNLZld5UFRYQWRmaXVJMVNWa3EwRThtSTZiOGVHVTRvckNW?=
 =?utf-8?B?VjZFNmdYQU0zb2tKTW10VEx2MXdyN2MrY3JMLzNBUnJhN1RkcWN6SGdPbHVC?=
 =?utf-8?B?a1JyY3NDQmtqcDB2c251b0NHUTljbzIyUXJTVmxRZWJiczM3SVVhMTZyS0Er?=
 =?utf-8?B?cGlZa3c3RFBRQ2NWOWVhQkV5eVg0T0Z3V3JyeEZSdStGb2VRa3dWWW5tNDcy?=
 =?utf-8?B?ZytoazRNWkNOd2RzZHgyMmRjTVZFK3lnVzk4eVNmeHpEbXBnQmlJRnhYb3Ev?=
 =?utf-8?B?MERzWng4Qnp2a0dKMUtrV1hjcnZtTE9DZUlHUWVZd29jOHkzWTlvTGRtb2R5?=
 =?utf-8?B?QnhYektXbnZoSEhBVWthTldaM3VRNWlSYmtoNFJpMGVGb3R2b3VqdG1ER2Jk?=
 =?utf-8?B?SXVjbFN3MlhIM2pjSEo2UEY3cG9YWEZHMytvbGxaOUFCRmg2UXF2RzdlbGpv?=
 =?utf-8?B?b2ZaNklZUU9Ka0FleGFUTXZXTVpsZmhwbHZpSnh1NGloS25WYlMyTnpoYjZQ?=
 =?utf-8?B?VzZpaElqVjZ4SHd4RWw3MVA5bGRPN05wZ2lURXJQTG0rMW9vbTZNQXUyWEF4?=
 =?utf-8?B?Z3Eya0N5RXZpQzZ5c0Q2dkFubW9Bazlqa3IwakJwdy9jZDArcm82Vys3ODg1?=
 =?utf-8?B?eWhxcklqMFRBaU9jeWVjbi9kQmJkYlp2S2NOM2FjZk8zbHdRTVBtd1lmWitN?=
 =?utf-8?B?aWo0NkdUbTN3aGlROFlRSHhoMHMrWXJvT3hSYUh2eXVjdnZIK1ZVZHhuanRy?=
 =?utf-8?B?bVE3S0d5NlBFSkU2aWRSMDQ0VVFMeXFYM1pEWjIvdkJMSFdTZFg3SUF1YTkv?=
 =?utf-8?B?Z1ROUGlZTTZBcFNnVkRQYmwvbXlndEtvaEJsWFJLVHFjN3Azazg2dDFjejA0?=
 =?utf-8?B?STUreVdET3dic2JYaXBzdTBtck9KSUlrNUdSVWp3QmhvVUpVUmQzV0xvOTlT?=
 =?utf-8?Q?Te92onZ7qGaqzTGw=3D?=
X-Exchange-RoutingPolicyChecked: a5ima3NKw3TY2xtwNUjCMY4UmbSDd0lmJ4rryj34gyOCIF3WMpoGNu62ps8wS36WXfqEGhMc//wnRgrNJ1iimypkVtprINCVg7o421GGUt3Nwuth4lh0489Xa6FQoNj4mKPOalbnk0ItBIq2nhsH5lQ6QTdAQ2r19ZGmcfencD9htmTgTPUlQRmD4L3i/upZoVhK6JomzAoXJDH1H/sQokXD2+vI7rRc/c+PJFUw7dUOph6lwxBqH4ktmQE7a+hGhHBHkG34N2WKVQecGsGkSPtFTq3ba4vts+EeZ0XpTKYKw0NCjbiM8qg9x7qNkJPumWZM98y1UhwvU8rzAkdfAQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a80d7e-b532-45eb-8ff9-08dec6fb2002
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 14:18:21.2318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yJdIJSz3mXu9pjJAXRC8M0pXZVtbxjkrUIg8CLjH1wNIo4Vk3VNy65EJIrx4XerhiCdursNOVaI1okr1s5fZ0UZ/EXRegrC91cTtmRpy6Hk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8674
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297705-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,0sec.ai:url,0sec.ai:email];
	FORGED_SENDER(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:doruk@0sec.ai,m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD47466A396

From: Doruk Tan Ozturk <doruk@0sec.ai>
Date: Wed, 10 Jun 2026 15:00:46 +0200

> The async decrypt completion path mirrors the encrypt one but is missing
> the net reference that guards against the tipc_crypto being freed during
> netns teardown.
> 
> When crypto_aead_decrypt() is offloaded to cryptd (the SIMD aead wrapper
> queues the request when crypto_simd_usable() is false), the cryptd worker
> runs tipc_aead_decrypt_done() asynchronously. If the bearer's netns is
> torn down in the meantime, tipc_exit_net() -> tipc_crypto_stop() frees the
> tipc_crypto, and the completion then reads it: tipc_aead_decrypt_done()
> dereferences aead->crypto->stats and aead->crypto->net, and
> tipc_crypto_rcv_complete() dereferences aead->crypto->aead[] and the node
> table, reading freed memory:
> 
>   BUG: KASAN: slab-use-after-free in tipc_crypto_rcv_complete
>   Read of size 8 at addr ffff888104c8c808 by task kworker/3:2/70
>   Workqueue: cryptd cryptd_queue_worker
>   Call Trace:
>    tipc_crypto_rcv_complete+0x1dd6/0x2240
>    tipc_aead_decrypt_done+0x1c3/0x300
>    cryptd_aead_crypt+0x3ae/0x660
>    cryptd_queue_worker+0x12b/0x200
>    process_one_work+0x66c/0x10c0
>    worker_thread+0x55d/0xc80
>    kthread+0x269/0x340
>   Allocated by task 1550:
>    tipc_crypto_start+0x7e/0x890
>    tipc_init_net+0x30d/0x480
>    ...
>   Freed by task 116:
>    tipc_crypto_stop+0x1a4/0x2a0
>    tipc_exit_net+0x11c/0x1c0
>    cleanup_net+0x510/0xaf0
> 
> This is the same class of bug that commit e279024617134 ("net/tipc: fix
> slab-use-after-free Read in tipc_aead_encrypt_done") fixed for the
> encrypt side. The encrypt path takes maybe_get_net(aead->crypto->net)
> before crypto_aead_encrypt() and drops it with put_net() on the
> synchronous return paths and in tipc_aead_encrypt_done(); the -EINPROGRESS
> /-EBUSY return keeps the reference for the async callback to release. The
> decrypt path was left without the equivalent guard.
> 
> Mirror the encrypt-side fix on the decrypt path: take a net reference
> before crypto_aead_decrypt() (failing with -ENODEV and the matching
> bearer put if it cannot be acquired), keep it across the -EINPROGRESS/
> -EBUSY async return, and drop it with put_net() on the synchronous
> success/error return and at the end of tipc_aead_decrypt_done().
> 
> Reproduced under KASAN on v6.12.92: a UDP bearer with a cluster key is
> flooded with encrypted frames from an unknown peer (driving the cluster-
> key decrypt path) while the bearer's netns is repeatedly torn down. The
> SIMD aead must be forced onto its cryptd async child for the completion
> to outlive tipc_crypto_stop(), and the cryptd worker was delayed to land
> the narrow race deterministically; with the patch applied the same
> workload runs cleanly. Found by 0sec automated security-research tooling
> while auditing the siblings of commit e279024617134.
> 
> Found by 0sec automated security-research tooling (https://0sec.ai).
> 
> Fixes: fc1b6d6de220 ("tipc: introduce TIPC encryption & authentication")

Cc: stable@vger.kernel.org ?

> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks,
Olek

