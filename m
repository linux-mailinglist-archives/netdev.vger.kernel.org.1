Return-Path: <netdev+bounces-298297-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N4kIIGoEK2pX1QMAu9opvQ
	(envelope-from <netdev+bounces-298297-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:54:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C82E3674995
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:54:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=LJKpjMI7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298297-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298297-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CD8F30262C7
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8140146AF36;
	Thu, 11 Jun 2026 18:53:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51EF449ED6
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 18:53:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781204004; cv=fail; b=NqbT89LEMN/oCp7/cGagzgRK2esTyPZ3jyNIt1+3E5ilgh1XG6PlFHckqjlrnTnYB+FRXm/pRbs6q1VIKxy2ico8FAV0h78JIiWYBEaP4T6l2yjwlLyPfTbIVrjA24aDzjO1lcA05JWrFaV5w3Fas08cN3XX8Xe+iB1pfCfS1Ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781204004; c=relaxed/simple;
	bh=LH4WMbzZe61zFiPjsFJXjGov2LQYuwZQ4UUNtpJAkWc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oh/QDNwUDNRUORuD6PRTxzOYmsfTXKNnONJFO6Er6tHTWe3KhnqVfSAvEd1mbjvVuxkRAKZwwZbGOU/ucW3P4M50+YLOSYiFg2pn3Dt74iOK+zLGrvjLBiyJZQf31HOOInPmx32ylP6DzYkJ1f1ykk1XYJzlMiq9SWHLjJ6fups=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LJKpjMI7; arc=fail smtp.client-ip=198.175.65.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781204002; x=1812740002;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LH4WMbzZe61zFiPjsFJXjGov2LQYuwZQ4UUNtpJAkWc=;
  b=LJKpjMI7ZHvA22BsfPk/xMtQw9VZLNQaKFNpEPG69qlOBnRxptFjD3t4
   VchM8FaCLrdzm87HI+X4XL50m1A3iQbP50p/K1AMeBwcCTTBzFICC4BRy
   7ZhrRrmg3X58YTgmRjxoH2IrjIDk4BEl+y/67Wkg1PFKepelRlHhgPsC7
   JQrefHvclkKq0fhkeL07PvQV1Ajvf5ue37iFp79bG8pYc/8fSt60/wRm2
   lmigURSfEBzlMyH6ekbCOxboNE64/48F4SaSDvf4uLbGOfRzf9GlumatZ
   i+x2dR391+GZa5LkMo6Kk8ixNq6V/McPAQHbxlOuuMipk3j3b9wXSHN+Z
   g==;
X-CSE-ConnectionGUID: L32+X9QwQ1SQDm7N01yBkA==
X-CSE-MsgGUID: aT8XH3wgRk+4EHOxoP1wzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82034575"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="82034575"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 11:53:22 -0700
X-CSE-ConnectionGUID: j8VNnRcwTIKdGFe9pMjrcQ==
X-CSE-MsgGUID: 7dSl6V2dTsC36n0+BOMGJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="250513552"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 11:53:21 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 11:53:20 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 11:53:20 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.54) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 11:53:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQNPT9cBalHPoJX+30m7Ij+sOWocXNaony7pgrJT7g/WC3ZdRz10CCi7MYxLDo2WeA0ClHSyGKqI1wEVkfLFx2eB5sRpLhvC4GyQ2h+QvuHm/Q2P5BwNbqsHULWiQ+xwXoSNy1hMJqFRtsO/TiwTWKL17GOtaz9wPcsFvLSie/I9BooqcSlB5wOTH0Def8WNdAkLeZFQ8hw+PSh9Pivz3qSTIr4b0VpepyZ4W8IrY92I4iMbeLRX1Spajgv6ybXPyomIgKFebbwzUuGtu/P+rbQjMIksunBVmG2cilzZIB9TkE93T2Ei/feJ7a5N01CQesET+UtYp01GkyxaY4MeKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbaWLg+ih2QhFE9KMcrglANhgH4LnxrxENRMupJYBIU=;
 b=DG0YamRiq8yfiWipFB5EwgZf5+/TQLWct1TU4i94F4UplVyYcQCAYYPssFSj9UYvczpP8q1uiOQ3hW6xGuT2QTEviYhhRl3zRPw9u9+dO2uZo6/EcM1JNa9tevcEJEX4HrFUbZBTihNdTeVmvvLGTwiHp5zvd4fbtFCPuuaqJCL9Kk3WbrUPDxW4ps0ZPDbZjeMZowR26rPgL7fgk9QQ+7QnbuVJZJu2hrUxfsyK/0UAhnY9Xi/ZaIF2wPp2Afccu29EFI8yHjvjrgSFhu0/T/nfpanPBLLcYMw+779TnRuRIGy+adE4yAFgZdzoxwqOnzu60r1rroAhtAvpSB3d2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by CY8PR11MB7876.namprd11.prod.outlook.com (2603:10b6:930:7d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Thu, 11 Jun
 2026 18:53:17 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0092.016; Thu, 11 Jun 2026
 18:53:16 +0000
Message-ID: <1264de6d-a669-4afa-ad08-594d956e101a@intel.com>
Date: Thu, 11 Jun 2026 11:53:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/6] pds_core: Add PLDM firmware update and
 host backed memory support
To: "Rao, Nikhil" <nikhirao@amd.com>, <netdev@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
References: <20260608223256.12357-1-nikhil.rao@amd.com>
 <75c74b95-097a-47c9-9a55-a4150394abf8@amd.com>
 <41d3815e-f060-4003-9974-42530addc641@intel.com>
 <9e0a17e1-006d-473a-adff-ab76bf91d0ab@amd.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <9e0a17e1-006d-473a-adff-ab76bf91d0ab@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0084.namprd03.prod.outlook.com
 (2603:10b6:303:b6::29) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|CY8PR11MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: 9250eecc-45ab-4ce4-1a96-08dec7eab249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|18002099003|22082099003|4143699003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: Oo6CWlJ4otLVqd8hOCSPCZMYFgwAIanr1Gh3NxUM8tALUNEP7TB+kue7HGLWfJVewpDEmA//vsdyPVwldYr0kVsEhGw7WQq2hrS0FbmI4OzIeHqvzjC2cTsD9fRdda0zIWvhGy6WN91sC/etTNEupgEtQ2bG+y2WsET2IeBHvNOlUVUsngbAJipNQY4JH2L0KRa0MIZ/f1ZfAT3ntHzsREM3rL8HRx91XjyEahW6lC3ZlCyFRMJOzFdQBxmbWcS8Sv2TeL+Qe7uZDSbD6aXndZGPklZvSIbzgGqjTho8pWZT6j7MsYIocLVlqErX44wJYy6jypXL6FlWFfNUIZ1hCdYxuDVmDpzkHxqVh5vlC+xveREt+0Uy/Ti0mwPOYeuXNjxERtIcmhutgUGrT9EKCQeOqlblqra5OU+nuPo0ZhMSrhpI1JKUDQkhrrLjki2AnUayZFRsXopstIXb7DZVMwyWiJ3zIV3S0+fz3QbZua7NoI+7ZbSyB8dLuHfEj2GLW18V/rK+7S6BaNfhI+4hMzfU4i7WhDK6dDmdgpmkPOvikVsxJe4nHual3rJeVkA6nunKk4UC7ogMEFL692hEurfJiDz8pn9fA5VW7m0sD/RnSzbFeiDAOgsFVVcU50S1xzuTITP3zsC2io98OoGpAxD4/2a197RMp/d13fM6Z4/bQHa8lB3/AAFDKLC4C8Zr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(22082099003)(4143699003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bG5WcHlDMGpZMG1YZTY1TitBa1pvd1g4cERYK0IyejdydFVlMEJzOW1qTEZx?=
 =?utf-8?B?V2ZJbXpEN1FXT2Q4VUtGUWx6MUFHdlBTMjZlMlhnY0tFM3lkWHRNQ2p0aXE2?=
 =?utf-8?B?VzVqOE5tdk12cU1iRElKRkJQK1gxWm92VXJGK3NBNEE5V0xaUE1lNFdUd0VJ?=
 =?utf-8?B?Z05ReUxjVGNNRmtyWUtmbnRHRFZqVk1mUHJ3NUw5ZlZsTURyMGNHN0Zwb3Ji?=
 =?utf-8?B?VjlkLytFSktzY3E1TmdJLzl6bmZSUk14NUM3eVBTUDFRNWtLbzZ1STdTaUV1?=
 =?utf-8?B?dlNUQU16bU5LMTJYck12M0ZTajc3MXFYYXpseEc1aU5KQU1KRFRPaXZOZmgr?=
 =?utf-8?B?VGxRV1RoTXk2UDNPR1hDSENsNkhXWmNKd3VUUkljMFp2djNldXpmdlVOeFNw?=
 =?utf-8?B?dEZGZG5KWGtqMHl1ajhHT3FqWXk2L0wwck0yUlJFQ1ZxRzlLTkpNQm5wQmNZ?=
 =?utf-8?B?RTdaMmJrSDU4bytmSWI0WFdEVW81Y0JWNG1yRzJkZnVlNE9STFMvMVBkSHBV?=
 =?utf-8?B?NFBxRXBZWWhaWlBVazJSUXhRY2NzZmNQYUpFT3VSS0hyeW5HbGxmN0svb3Na?=
 =?utf-8?B?Mlk2b1VoTDdaUkxsbjNVQXRtaVZhVUhNQm5qUG9wZ3dGdVhhTFZ6ektTcnJR?=
 =?utf-8?B?NlFob1VtMFBCcDZnWm1GZWhpeG9QOHpoazI3d2lBaGR1RnQyVVUrTGtBdG1H?=
 =?utf-8?B?ODlFM1dzengwMjJkU1dodVdHVHpZZlRNRUM4N21ZS1NOQWtTa1ZYbFdZamMv?=
 =?utf-8?B?eTFzelFGNnNGK3Z2UFBQMm5iMU5JSkU2TlluS3NUWDRBVlh4aWtvVUhUaWY3?=
 =?utf-8?B?OVRreHJ0SHhkRXdxNHdWODYxMjhnTGFKdCtPS1dudmZZWDRJR0NrUnJuT0hj?=
 =?utf-8?B?SzAydmlpNUs2V3dyTmFBT1h3d0JySFltK1JuYzY3NWQ0dy9pMElOUmljT3JC?=
 =?utf-8?B?RXdja1hTei9mK09sNVd5aUNrQVB4ZWx5eFpEM1ZIVW9ONWhhS3pPRC9OUDIr?=
 =?utf-8?B?VStpV2J1alNXV29OQk1ya1gzU2svVnBmVjFpaXhHd0d1anpZSENiOWs5QXFM?=
 =?utf-8?B?Z1o1K0FaMHhmaVI5YlhiZ0Ywd1lrd3pYS2hpQlUxelZrWHkxZ00xdWQ2cWlQ?=
 =?utf-8?B?VmhpQUl0aTYwd1p6dXBza0Y2RVBoaVZ2cWd5OExUU3BOM3JuT2pEeGJpRjRF?=
 =?utf-8?B?TGpiRzE5d205UDhtWGF1UmFVNi9XMjlkcnIzczJzNm5LSU1FZGFIZEZwOE13?=
 =?utf-8?B?RHFXN2FjU2tlV0VMRUlYRUIwUmdIbEphQ0xRSWZJRGViVE9MeXFhQmw5WHp2?=
 =?utf-8?B?cjlPZE9oVlFuUXNKd3NBM1kzK0ZPQVJacHBrYmdzUVZ4WUJPbElyQk9aYnRG?=
 =?utf-8?B?bWI4cFZGdG8wSmJqWXhyNFErcFYzT0dJVVhYY3l0a2o4SVlNMXhZNXM3Y2NR?=
 =?utf-8?B?Rk5sdXQ1Y292bURaMzlTZTRrOUh4dEt2V0Rhanp4TUpESHlRSEVsZlUxNUlE?=
 =?utf-8?B?RmlEdGxvVDFqOUZJZnlrRnpoV1NpNElFVDhWcHFhUyt3QWVxM0FFSm1VMlBs?=
 =?utf-8?B?QXdNZ1BTR1lnKy9rbisrM2VzRUZzQzNYRkZISmlwMEFlOUpoSjViQ29QQU9H?=
 =?utf-8?B?YXI0WHVxeDl6cy9ySkhDMnZFc2dCZXo1SnQvQU9NenRSRTRFSnRyYjIwREE2?=
 =?utf-8?B?dHRiU0FmRjUzUHZYR05hYjc1bUpWZVFBNXN2b1AzOVorZ2hxcnZaKzd1ZitF?=
 =?utf-8?B?ZE9DTGdVeFZ5R3pvR1B4bVVGMUNuWlBhYmE4WTRCQVh4YW9Pck9pQXh5aVJy?=
 =?utf-8?B?ZG80RWpaVTRxSTVrNXRHY0Vhc1MzcEdNcUxIK1ppRVVZZmFSdUthWEFIR3JY?=
 =?utf-8?B?QVd6TlQyVEVtLzlLOXZ6MjVBbzkzWVIrcXVQeXJiMllxWWdhcnhNNXNyMHV5?=
 =?utf-8?B?R0RmRGw4dSt6MVZ4VUd2bWN3ZkdxaGh3ZmRwdG5RbTRqMFB4TkxMS3JjNFR1?=
 =?utf-8?B?cUZNMWl0cUMzTUNZUWFPSExnVnZqbFBkVHpIN28vRTZiVHplekg5THBFb0pm?=
 =?utf-8?B?QzJSWUQ5QlA4b09XdFFRNEFYcy9nR2Z5WlY2UlFhZEZOa25sNWlrdFk2VlNh?=
 =?utf-8?B?dlovRTdzSWRSeUJvTno1RHNPM1NPa05vZ24zUXUwekxiUWh6bE1pWVpQRmwy?=
 =?utf-8?B?dU83SWRibHlORS9UMXpHbERFdnVGUHRkQnB3cHIvaTBVdGUzWnpDNEhxZ1Ju?=
 =?utf-8?B?ME1EYTZMN0RQZ1c1UEQ4dmwxZjl2U3N5ZGRadmltMFAwNUlzeG1GR1RkUUFF?=
 =?utf-8?B?NnVCTmpLbVA0ZVUxN0RGSVJoSm1SamNpenpmM3VzMVZ2WEVVUTlMRTB6SC9Y?=
 =?utf-8?Q?QnX8bCla3qb+BHIA=3D?=
X-Exchange-RoutingPolicyChecked: LmnDaLFv+o+tsGN2wFMIDG61fuZztnnoCQMaGAPIBMw3X0BctfFydEpi4GkVyRBfDUyprugcXwwPBgGeAeJ8a1AeaH9Cs6oV0OVr4fjhkumm7B/XbzW93MSY3ceH+hwoMUb7A0CK0ob50NwlwC3Dib3Hj2kddtXuKm6sMin6usGShu8iqMIN8+B+NC7yMdzl70fPI6ptXv1uAXLCAp65iWoCoHvflQrhbaiw3GLVxh8tJoH8NgTA3u6/1iPb6V2Uz8pHpeKVG0zF40vqWQpAQOgg6pglfOuwhhB0I+Fy0D3cuF1RRnGNw4DRP3GAlI4sWiwVbj1WEpT+YHa7gk5cZg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9250eecc-45ab-4ce4-1a96-08dec7eab249
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 18:53:16.1810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMfNAoTDTYKp2RI/HsmXex5bsrAwTzwYKHhx2Ip2IWt4eD25CES+y3oOM7v6bGa5O72DOfuwr3DaYECOVGSWpiwZO0FbPaD3WMIcXRh49mI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7876
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298297-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nikhirao@amd.com,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:eric.joyner@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp,fw.app:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C82E3674995

On 6/11/2026 10:15 AM, Rao, Nikhil wrote:
>>>> Vendor-specific component names
>>>
>>> Compliant with devlink-info.rst. Driver-specific component names are
>>> allowed when documented. These are documented in
>>> Documentation/networking/devlink/pds_core.rst.
>>>
>>
>> The preference is to use generic names when possible/feasible. I think
>> at least some of your name choices could align with the generic ones.
>>
>> Could you explain why fw.mainfw was selected and fw.mgmt was deemed not
>> suitable?
> 
> This component handles both control and data path, so fw.mgmt didn't
> feel right since devlink-info.rst explicitly excludes data path from
> that definition. We went with fw.mainfw to indicate it's the primary
> firmware component
> 
> Nikhil

It might make sense to extend or add a new definition in this case.
Technically you could also report both fw.mgmt and fw.app together, but
I think that would be more confusing.

Perhaps Jakub has a suggestion on the name or policy here. The
maintainer preference has generally been to use or extend standardized
names first unless the name or component is clearly unique to the device.

