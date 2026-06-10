Return-Path: <netdev+bounces-297702-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0Q5KDphzKWpNXAMAu9opvQ
	(envelope-from <netdev+bounces-297702-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 16:24:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA7D66A2F4
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 16:24:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=M29D85a9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297702-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297702-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BF34302A517
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 14:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D862409603;
	Wed, 10 Jun 2026 14:14:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82DD40BCCD
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 14:14:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781100860; cv=fail; b=R+iu/3dpiH/AfXEMB//e0/usSNDRQnBRvEXrrFUYP95HEyoPYavPE4NwsMIb9QIbX9PfKKuUIVmYtEUgFH2hhrD0r0ZNQXp7+gYvGVtbtwicRyzKGgF9kgN2apjJlDK8+SGPa4HVG3+KB5iccAenGaoH4mU7kbSMAnq7n8Dgds0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781100860; c=relaxed/simple;
	bh=pVAkP83ou9zlnsXtIsqZ1P0605bo1O3SkKCgnfUacsk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XrnGi6uZKDhHUlvQLqqrkVt+EPQA4cngFUasm94P3cYAf0Foi75gipNwVWamx+u7SpvaJyocJi8++LIOGdM4usxtMAPq/xz2y3PlbBWlZmIBdwIIcdb3EF/fxaZlxNwE13XX5hJ2WO4ILPSXaPEargppcUqP5EW6QJVav5ZRmFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M29D85a9; arc=fail smtp.client-ip=192.198.163.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781100860; x=1812636860;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pVAkP83ou9zlnsXtIsqZ1P0605bo1O3SkKCgnfUacsk=;
  b=M29D85a9qw+Xxpad92CExhQF/jZHJw3hz8xM14cY+iIS26qZ82BWmjSo
   KtL3CoDBeRZf9BbzwA0n+HdVpsCC/v2j1/jHeEBCMunOfGxSiFYkIyDsJ
   NGnysWvmOqiHY6P5ekMNK36hrv78pFysglrcAE+Sn1S6cihkPqqcln0jU
   Rx7XUWwNeyKweL2zJ33wc5yHfKRRaanZ94EMtbt8QnR+MAxc90VmwrhZI
   MVKbJ8hvAkKnCAu+jxf0hKjcuFBWFHoW6ZeMO3h7Y2t2wp4hCMlrC746V
   nPEAGOHiHWiWKYnWl3KcFfN2FA0cOzaYdHCay6XQu4dfxe6DoSolR9hyA
   w==;
X-CSE-ConnectionGUID: TcPagYKyTvqim3Zc82RsiA==
X-CSE-MsgGUID: zx9/Ly5dTeqOdbmm66tWgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="93281071"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="93281071"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 07:14:19 -0700
X-CSE-ConnectionGUID: nzEq6sWnQjqyjDQrqa6j2Q==
X-CSE-MsgGUID: SRfN9hiFTRWX4+UHkFQMkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="245058331"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 07:14:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 07:14:18 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 10 Jun 2026 07:14:18 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.52) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 07:14:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H//fK7HiGNCKHnpoO3TWvnWfoOcdAmDG/gzo3eye+JHaN5ped6Tla+1favv/jVyQeXxxJQQkiDI2YpPyjNea2IhsD8LgDyND19RQ05nXRR2zXekAh7miz8Ion9xaadKThuGSqTu9uDlSbhcd79trxRkxbh1JrGv9gG4OIkF6torZX/mx4WEjyWQUllj7IPq2fAZexgGEwo9udULKKlo4PMrQRrNiaeORm3kJP67NNh7KSlUl7RvGfzaMNEL40BceriGqN6DJVc9yoqBa1ZvYSIUZaEWzn3Lo7xM7o2sF9Y7jL6ie2+01a9AMNzBy8FWa3lPdHqCSkfa11Ifck6ylOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lT1+2nnm0DrPF9STIrlTkJeoFNqNeZKifA+aDKOQgz8=;
 b=EyK088/WogrViWj6IoE8F3Wyyho16gfzf8umrub5yuVdCsPb2ABPK1B3fm/q44jvj+rwiO8VNokP1PEai2KE3hHpgGN05S2ktXrUv7RkJEuvxD6j0am9WFoiTBsO6h71o9QwwW/CIzL6oSq8NkOErP+OCYqWjZIamGj3WM1WJXMGLhO0H5LVFvecCqNgrfRVYl+4p7uA18BeT368rh9fbDgZZHRSUGXKzFZZeoYO+T/3Svv1Oxwc9p0JwoONyBtQYMDWGK12gSvAZyC9CJWHjJBwp9oWroXfT2lsICW87UDfnBAyAjHzziO90mAfKlWn/sStOcT4ijIQ+8aTZqA5pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS0PR11MB7560.namprd11.prod.outlook.com (2603:10b6:8:14b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 14:14:15 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 14:14:15 +0000
Message-ID: <631650e8-a161-46bd-96a1-582adef84021@intel.com>
Date: Wed, 10 Jun 2026 16:14:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: airoha: simplify WAN device check in
 airoha_dev_init()
To: Lorenzo Bianconi <lorenzo@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<netdev@vger.kernel.org>
References: <20260610-airoha-eth-simplify-dev-init-v2-1-8f244e69b0d4@kernel.org>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260610-airoha-eth-simplify-dev-init-v2-1-8f244e69b0d4@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0347.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::27) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS0PR11MB7560:EE_
X-MS-Office365-Filtering-Correlation-Id: 62233415-3499-4774-6814-08dec6fa8d6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wUZG5NjH/jcObShJIW/7SetFBSoys/AyidQgc//pr9Qe0jYs0c1q4f3o9IVW3D6Ie67qg088Xk++ESgu23rFvfXzF9j4ZTBXPmvI/Xt0Di/exiqgFSR8VQnSwozY0xI2+OBCRxsLq1BF4ZCSppsP7T/NIqt8zpW/w8ZsDtT+MFbkcWMZwzf0wbqKELDNDm8XHenT6UPsvjq4afl2wJX7b0Me3hSkIfyn+MPxybRNDU/XuRAqBcwbq/ULWdfOnpv2EsQd4LIbeNALzBsD4Idfb+aYmOOFltfg2915dIuDbR17hQEg1X5JSBdYIgs+G9NHBfdSo4ktz3OimkgycZhIrNaNXGmNHc37HCIWX1srPeeXOvPhQmJJp8NrG0KrvfPlzdQpxJcbVgN89Sr7t9svnV76qQ06OOe4t3y9i7DR5XUrzHWHswJDNkcPWnxicro8LwjBCwXl0EE88QlSqxpt4+uuicwuSLnGNdaTMPGjgb3Sk7tn3385F2QMTguGqKZoQg/kq8A69TTWEM5utQ+b1AryhKt0BR/HFOs2vR0UBRbXMoYff5gwonm5Qqk8MSPz3+X299KKEQF/OeUcTNIjr4GpmQfaCj56em/IxWdKnVY7YAXvZaRZLX4ZQ+qeS+yZ4Q4tkGS6o3zm7rQLSE0ZMnA8J+v5XfW6VIx1XFJEc1FOHMvEyQEAjhZIy1YlGLUG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnNJbUJEY216MTh6ZktrVW5ueGZjWVpXN2l2enhpZGJEeDhLdXRoM1V2Z1ZT?=
 =?utf-8?B?L3ZGelV3cVJLS2ROUjFmSENjTEJiQlJSU1hMUXpqamZpQWdXV2k4L1ZnbEpv?=
 =?utf-8?B?WjdocFRMRUpuc2tPKy9Jd3VJSzc1V05acE1kMU5oQzd4ZzJwU0ZOWkU2SklX?=
 =?utf-8?B?ejFISHkzQ2VxSUFVQ3RSS3NaNUtKS2pyeGJBcmFzeVk5d1hDbFFFOEFDcFdp?=
 =?utf-8?B?MkwvSHdGU08rL0VxQ0tvb3FOZkdpS283ZzlSaEY2WmNWRVFqZ1RWOXlqNmFC?=
 =?utf-8?B?RWtqMG5oYnRpTE9USGdGN25GcmlOeCtxczdOaUpJa2JXclJvcnVKWHBFSjc1?=
 =?utf-8?B?Nlk5YldkMWY4Z1o4Wi9XOWROd3pZdXIrVUorYVVpbDZYdUo1WmQ4M0VrWmFO?=
 =?utf-8?B?TE9ISy9sOFh6dEZPTTZUR28rVkwxUHg4N0NRZTBwcGtHQjhiM1U1OHNlRlky?=
 =?utf-8?B?T1RVL3ZlUkVIUTlaY3BjU1daeGlxTVF5L3BYTmxETnpEZkhMeW5FcS9maFhk?=
 =?utf-8?B?VG54dEd6NDB5bmhxNURqa0xxL25XZXBlRHRGdWljazBWbTNpRGlrTU1oYnA3?=
 =?utf-8?B?Vk9FcVZ0SnFwYlFOcmZsakkwSUJYb251MjREQ2pTbHF1R05QS3lmRWpFcE1Z?=
 =?utf-8?B?TW5USHVBQzA0NW9FMWlwWWRsdWVnL1djYXU0c1dEVlA5WmhTVkx3QXh5VzRk?=
 =?utf-8?B?VTZaZUFLRG5MbVA5S1JCdVNqK3pxV1VaOW91cTFVVEd6VFRGQkdjd1JyQzI3?=
 =?utf-8?B?SVh3b2h4TUg5cTMrcDFkYk1KdzdDUFExWHRGR2IwYU5VNGxqdDdzek11SlZm?=
 =?utf-8?B?TkdpNXJ0NEpRSlVndFo0UHRUQmJ1Z1lpMDVSL1lVK1FFOVVHWG90ZU9rdlNL?=
 =?utf-8?B?OGVGOXpydFNsa1RNSExTUGRtMG84VEJzRDhFc1JXRW1SNitoTGRLTXhUVVBP?=
 =?utf-8?B?NXB0a0lac1ZGV1ZEbGtkSnpWZ3VVRkJyZFNFSmJkaXdCaUNnZklsWjQ0ZlUr?=
 =?utf-8?B?UWsyQm5MYkMza0k2WEtsQzhtWlRRT3VESE9PdHo5bk1PUVVpem1sYmw5Vkd3?=
 =?utf-8?B?NVJ6YkNLUlJ1Um1OZnZnVHczZ0IybEhQWkpqeVdjakJsMWpVSHY0bzg3d0FV?=
 =?utf-8?B?RVhEMVpqMDJjQ014cU5YUlZiKy9YRm5SMld5a1RDWGJsZkhrSXlZenJkbDE4?=
 =?utf-8?B?ekVpNThuQXRjWFJPT0JOS1dIb1ZzMkVDSUdlSzFFQ1VKRkVZa1FicnFlQ2x0?=
 =?utf-8?B?Q3NXODFhK3B5aWFrRXhOazNqbFZUM2pMM21jSGlhS2FLZGNxMXNRS0FTbDls?=
 =?utf-8?B?c3piaEgzYW40bEZzYmcyUzNFNy8yZDRPYkh6TEwzeXJDN1kySmV3QXE1Q05P?=
 =?utf-8?B?MHNISWk3MVNBeXV1RDNMZUxNVEEvMHRsWU9QbnFFK3pCaEhSb0NBTUt4bWdT?=
 =?utf-8?B?bVhGUkJJNTVzeG9hMHQ2VkwrZ1kyV3FzOUsrSFpiUG52VlhaRjUwR2FuRmRY?=
 =?utf-8?B?aTlldXhsTTlkdjl1VWQzSUdkeStLVnpqYlpVak9FMGFNZmpVNllPQkNreVBJ?=
 =?utf-8?B?OW1ZbnRsRmVGWjRpTk1XTmh4eC9CeHg1d2xVTTlJMHZVcFcvZDZLWFIvTG5L?=
 =?utf-8?B?L2o3S1FUL0U2VUlOMmQrZTRsNkhrQnVrS3VIRW80dmU1czJTTDZ2eXBMaytG?=
 =?utf-8?B?WjZ4bHhOR2xZQkJZY2x2Ny8zd08vZG9KWU5mRDZwOHBnNDQrRFdFUmR2aUJI?=
 =?utf-8?B?QkJnSFhwcEFtaEVZTjI1cnRmYVR4VEJxM0xrK3cxa2I3ejZVSmtGb2xINEJL?=
 =?utf-8?B?TGhoT3BSSmV4NHA0SCtjT2RoSXJQRzUwRVVKa3RmcS9EYmgzZmd1bUFGa3hZ?=
 =?utf-8?B?TGdlMFNud05hdWZBRnNTZ2NHWjdKNHFNaFJnUEplZld4ZHVuVnh2Yk9nUjBH?=
 =?utf-8?B?Y2lOcEF6OFNiM0Iycy8zY2pNc2Z0d2lTQVgrbHRSV0NUbFYxaXZUdlNWenJE?=
 =?utf-8?B?UTNlcXV6WkdyTkxOd2E2Z1BZanVnNWkvOHkvYnFHaXF6YkQ0T3JibUtaOXJP?=
 =?utf-8?B?T1JieFUxNys5UGJhenpwYk1mUG8zZ0ZDcFduaSthdjR3UXR4cnVVaGpVOTEv?=
 =?utf-8?B?YUtsV04ySFBHQTlsK3R1K2JXb2lCR0NTL2tML3NjaGxHL3FTYk1NQ1F1eklm?=
 =?utf-8?B?WnQrZmN1Uklxb2VHSnYvamE4TWpjaWI3ZXl4SVVhdmRGSzFLRldzVGkvRFJZ?=
 =?utf-8?B?dnc4eWV2M2FYTlNZd0pTc1RJNUowWEhDVGhTLzdPY1dXM0QrZ2pQZlA1RWhv?=
 =?utf-8?B?U08wYWgxWEp6Wng0SEZvWmx2WU1MYldITUo2MndqNnNVaEZ3cEduTnZBU2ti?=
 =?utf-8?Q?6CFvKiqW1fgN/qWA=3D?=
X-Exchange-RoutingPolicyChecked: cJD+irUSVnvafR65gIGyNUYrEEhXN61D2A1hFRIIqO35m84QT2Uy+PDboDJ9vH1pDTi31mEoTrl/RfEmiHN8W99s0MIwp8VKU/P43PlHrT8kkN7I94tcbavE6WWor0fWGZGcmrZ2g3wBk+6YJPMeNHGXAnpQWmwh13TdfuXvPMN4YAsVFKNN7KsKXRpD6upVaC8UjADX9jdMAshzJDgmFVIAAyeinm2ly8ijjWGn48XHZXX5iMKAPaOB0sdk0F2J4dkYcUUWKE3Elvb8O8C/RLMKF1NMtkt5FNf9Go+OXwM3ctseztEwOd9qsEfGpndiCAi6rFvmnL3KV5m+/QYaEA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 62233415-3499-4774-6814-08dec6fa8d6f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 14:14:15.2951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPH6p9I8hn0V3u3tBQBh3GJjhfHyp5hNpz/4L/OHx8TZynJ7JKJHGyFaoIV3xckbiXCOm6Haqdh5T17EC6iUpSJ6F9h++5TU2CEVFlb3R58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7560
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297702-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5AA7D66A2F4

From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 10 Jun 2026 15:25:13 +0200

> airoha_register_gdm_devices() iterates eth->ports[] in order, so GDM2's
> netdev is always registered before GDM3/GDM4. This means the explicit
> check for eth->ports[1] && eth->ports[1]->devs[0] is a redundant
> special-case of what airoha_get_wan_gdm_dev() already covers, since
> GDM2 is always marked as WAN during its own ndo_init.
> Remove the redundant check and rely solely on airoha_get_wan_gdm_dev()
> which handles both the GDM2-present and GDM2-absent cases.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks,
Olek

