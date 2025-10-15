Return-Path: <netdev+bounces-229584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34634BDE8D4
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 14:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 163A14ED922
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 12:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3C91DDC08;
	Wed, 15 Oct 2025 12:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FmXFnVsS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C186318E1F
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 12:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760532866; cv=fail; b=o3XKUK7DVBq4q6j/4GTl/JXEu4bye0RxLGEfm6HhgxIQtGqk6dELUyWKjL8DTVobPrY/x++qEk2MkVpO7VDGnoluEVLgWO/OfSzl69Z4iXXLFEnGdUd1B+hsnUI1RBnM01kwEFObgnbTgM1nKQJtE76DCmQt8FSQ2ukipgrffQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760532866; c=relaxed/simple;
	bh=DeUT4Jx5/xvb6+etl7h5yfPxAC7zuELX7qoCgWrGiOQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E79pHChPtEwx6okSmg7NOviEvbBfRlfvf4m2Ndeun7ft+kNDbq8bozUZjFyS7fFxrO26xJlyocreJqi5MPg938QkC34xbhExfzuwK5l5kSHgUdE8YzW55kWVjX7dBKs7KshYWqtetg6vjW2Pwnm9fXzvW7jJAz4FvBs/I8ffkEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FmXFnVsS; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760532864; x=1792068864;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DeUT4Jx5/xvb6+etl7h5yfPxAC7zuELX7qoCgWrGiOQ=;
  b=FmXFnVsSlCsYxLIRi5FQ6mQ8QBcULu3Q7AlAKCSbq2NpVteDwd9dZ53u
   nYy0jF/RCIBiJsMUtObvtkt44qaGlzIuurzdVLz7ISQUWV5RL1/JTyuc3
   TbaYDW+bPgpj6QvBGk7PVeKdD2L9gYK+9QM+5qeI4X/dk/0Lwi/e9xl+N
   FC2atisAr+4FwFYh83Uug0SZmR/Ny/wutaFPkIu1dn/bzNzEqK/nlw8RT
   MTDJXdDziZqfavxfoOVqdygFFHuyr5Wd3PRxDPMas2u0dWDxKI1+85C/g
   tgZUlOFNP/Bq0dbPA7AuQt2JweRT0ukUMsa8VmtNrha3fLrszeNu7uFS/
   g==;
X-CSE-ConnectionGUID: z/iomtXORO2LGuxzempmyA==
X-CSE-MsgGUID: Koyz/XZeSxW9AtFAVgRLKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="61736804"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="61736804"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 05:54:24 -0700
X-CSE-ConnectionGUID: Y03hJO/uRtuJ4NJFjSnB6Q==
X-CSE-MsgGUID: 2w5A54dPRDqb8c20kmsCHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="181843107"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 05:54:23 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 05:54:23 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 05:54:23 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.12) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 05:54:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1ht365bN7vvuP9KTE97OqSCU1Lx/NHKGti7CfsNNOFfbJvQoNcaqLHqtbKREWPhu4de2Pq6s7emr+aFAUAB6yRCdy4QO9klhek5gkvmLLOBkfsPPPiJRPz8G/ADpc53KhRED6cHG8X+dLvHDOChyiMB3KlA5krd3mWUdiPHS9b7GVV9v9/WXBm7YS4bTs1uQM+vWpUTTI/6kImwjEj8Ug2NKi/cXWVc81wJnViSmgabzetSETFeAacbDTG60ct/r8Sq/9uqa2IdW2+8wiG/8ctBmyMvBx7lRzywXMCwxxSmdCy/qLumQ1oTYHKsoTN8n0BBxfhJe5zn0RPDvEbNKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISnPP5UiGuYlk1JfSSDQfh9HllCXBM6kqMbtQtR5Fjo=;
 b=GWGNE+CpjOxrGjDgkebPsKDAaz1r5UkQW7fgh1XfzQoNO4FcMWFRvQdsMThWaTM4Y8fjMv23yGfkALvTD4Fq+Fz4DLeonarfF1VW7sWJQj+dI6YFUTqHCz5irudsJ/PNU8oQ/ToqNj8cE/biA8SYNZ1kenYK77JHOjpG+4KLyAMT2JSTjOhFBPauoFUesxDSMN9NHcvkMPWRoD4NV5z99aGgWEsVvUmNrYdC+1O4noLJ+8C+KMTYG68X6lRT9yciS1zMy9KuhwGxnz4Hd74OYX65NUVdo2/ON+wEPPG1C6mEzogWA5GezqlD0LL9onjqUxlMukvei3wDIaZ0m1M1Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by BY1PR11MB8007.namprd11.prod.outlook.com (2603:10b6:a03:525::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 12:54:18 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9228.012; Wed, 15 Oct 2025
 12:54:18 +0000
Message-ID: <9539f480-380b-4a29-afc5-025c3bf0973d@intel.com>
Date: Wed, 15 Oct 2025 14:54:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 2/6] net: add add indirect call wrapper in
 skb_release_head_state()
To: Eric Dumazet <edumazet@google.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
	<xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Kuniyuki Iwashima
	<kuniyu@google.com>, Willem de Bruijn <willemb@google.com>,
	<netdev@vger.kernel.org>, <eric.dumazet@gmail.com>
References: <20251014171907.3554413-1-edumazet@google.com>
 <20251014171907.3554413-3-edumazet@google.com>
 <a87bc4d0-9c9c-4437-a1ba-acd9fe5968b2@intel.com>
 <CANn89i+PnwtgiM4G9Kbrj7kjjpJ5rU07rCyRTpPJpdYHUGhBvg@mail.gmail.com>
 <f51acd3e-dc76-450d-a036-01852fab6aaf@intel.com>
 <CANn89iLH4VrGyorzPzQU66USsv1UP3XJWQ+MWMTzrceHfUNYVQ@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <CANn89iLH4VrGyorzPzQU66USsv1UP3XJWQ+MWMTzrceHfUNYVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU6P191CA0015.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::16) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|BY1PR11MB8007:EE_
X-MS-Office365-Filtering-Correlation-Id: 68c596a3-0e3c-4f53-b8ee-08de0be9f430
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGF0eHRKYk9vV1FMa2tMWkhmK2VyMVRGczVHNTArRzZUTEhmSi9kb2Z1aTdl?=
 =?utf-8?B?dzhrWkRYeE0yY3NCQjg3Sk5FeFhJQTRRL1dLNjJYd1NiWE1hdW1TRnhQck1W?=
 =?utf-8?B?ckxYUUxraS96VnJWaVVZYU4wTjhVYmFZNlVrTkhkRzZOa0VtQTBPdVEyOXky?=
 =?utf-8?B?a1huT1FXL05RdHJ2YkZhRUl1MkZvTjNOREl0YnBFMXo5SFJVZ2w5bVdsYlM5?=
 =?utf-8?B?aVplWC9mcWljUlBqQkYrdDRBenpZc1Y3aXBRU21CQld6L1g3RHVoTWRyQVh4?=
 =?utf-8?B?QjZEc2Rmb3dNNi9WNm5SdGVFeHVDN0VrdVhWNkxLNUVDSjZzbHJ2UTJRY0RJ?=
 =?utf-8?B?N1NOcUhjTjI1N2xJMUlBcWtBdlh2OS9HK1ozdFlySVZuRDJXSERrUnNSdisv?=
 =?utf-8?B?cVhjUjU0bHNzTlpMVEhDREMySEgrSm1Xb1RHNnp1QTRBZGJwZ1pwL0FvSGdp?=
 =?utf-8?B?cWtTUm5RWHIvK3hwMXUxWFNKQzFLZ1BZczJwUHA5bk5sUmVrUjVDRGp3UHFP?=
 =?utf-8?B?S1UvdUxGaVIxa3dZdjI2ci8rZFZ4YVlTNm50dk1lN3BWWCtBc3ZmVzlHQ05q?=
 =?utf-8?B?dXFjZnBFU3VMaWc2NmxScnIrY201U1VZaXRiNDhaRWYxazRCcko1MWRHcUpD?=
 =?utf-8?B?TmR1Y2tzYnd2VjN6Ky9WNUZSWDdHaVBsSTRjc1pRTzgvaDB0ckV0RXNSKzZB?=
 =?utf-8?B?MWQ2V2ZsSmIxUTZsaFdvbVI4RlQrRVBxRVB0UzYwSGlKY2ZFb2FHUzlmSmVX?=
 =?utf-8?B?VnBXQzQxamxTQ09WK2V1a2k2M1FvQXN3QnptZWJ3MlBrR0dYcGdLWmZ1S2xs?=
 =?utf-8?B?aE5qZFVhNzJXQVBIQmVEanBtNVVZRzlkUzh2cXBjdzRTY1hQcS9MOFU0VlBt?=
 =?utf-8?B?V3MySUxsbm9hNnhIWHBMOS9TNHIyQmRNdGZZRlBxOEFVVDcrVzZqV0hPd21o?=
 =?utf-8?B?ODJ3TlYrQmh4Y1NKVC9jdEZmQlNTbjZOcFl0dTBUUi82aUdHTVZTT0NkajRj?=
 =?utf-8?B?eEVsUUU4dU91QUs0V3FxalhvSC8zWXVwdFBUeHRFZFBxVTJUa2FTQ2JyYlFE?=
 =?utf-8?B?WUgwTllKcitieXdEWmZaK0NrS2ROWThsV1ExaVdzK2gzSHFKVnZtQU5IaTVn?=
 =?utf-8?B?cVdVM0RTUndrN3BTbTVkMDhIdERZM2ZiYXhNY0hLVHNQcldpQkhUdGEveXRz?=
 =?utf-8?B?YTMrRVZrY04xS1FBWWRsb0pGRHlRa3NMalNaUUZyVzl6VE5LRVcwemRuWmd2?=
 =?utf-8?B?S1pyUWJlUUhiVHh3N2JSd2p3aDQ5WVF6c3ljNTZDdDNSZlZ1K1BkUGVCMUlR?=
 =?utf-8?B?SzJYb1NLZ05OVTZzemhraUIwWjRXd3FYN0FnSHkraUJQMDRDS0RSRHJYMHlm?=
 =?utf-8?B?WVVHV0NRcXMxRVhWZmNicjlpRThoRWRkTTlRQkYrWWtFYTRzbk10Mkc2Q3JP?=
 =?utf-8?B?Q3h2Tm8yRk5JWFRsWkJNTkpoN2dVZWNnSU05RmZNU3RRakE1Vi94STgxVXJy?=
 =?utf-8?B?NVNXcnVUQWNueU9zQ2JLa0RJaFRyc05HZm5aY3RSVzgzcHRscmE4am9tZ0dl?=
 =?utf-8?B?SloyRCthbVpscTBUY0JuWlQrUEM3UTdySlZZTStoRDFtdEdudmo4bVc0NTZD?=
 =?utf-8?B?SUJ2K2UyTkg0OTNMZ3RSK0NvQXl2NVZjSTcwNy9wVUZJVVRpbEhoelh4cHdk?=
 =?utf-8?B?K1ByZGVyTVMwOFo3aVBrc2NWekYrcDd2QTNpMlhXajdZUkFXdmN5bWI3SUFw?=
 =?utf-8?B?M05Vd2ZXMEhVZUQzMG0xOXYvdmVFVkx6TlloVXh4bWFOZm9WY01paDI5d1hF?=
 =?utf-8?B?bVlUdG5QZFJ2MGZNV29TZ25uUDFUeVRPODdzUlFTMXRQQnlQUVpFTlY5amlr?=
 =?utf-8?B?ZlNiR1BIYkoyTXZYWjVCZWlGSHdhUXFrYXN6Q25uOTF4T0N6SzZjUDQycndL?=
 =?utf-8?Q?iliTUFvEk6bDfl5RdANeR+cOmxU1EDWy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTEwYWc4b1E2NFQ1dXI4SnU4OHVIbFVYOVh2dURBTzU1ZFhLWWI4Ky9wWXNT?=
 =?utf-8?B?bStSRWJXVmVzclZBVzJ5YWlHWjVxQUtGV25BRjB5NzlCdllqRWk5b1MrWGMx?=
 =?utf-8?B?eDRGS0h4M0Z6RUJpdmtOOUI3aEtVS05VdWN3aVdBS2g1SnRuYXhQMVFSRE5m?=
 =?utf-8?B?S2xNMGhkc3Z5Mml2Zm5LS1FiWjJZMXQxNDJ4c3JKM0VKRkpUZGswZWEyZEFF?=
 =?utf-8?B?eWphazJLUmQ3UHdyNHY3VjlBWDFXNUR1OXBPcGM4OU5TdlJ4dS9DRzdtaUtG?=
 =?utf-8?B?ZXErRjlUSDM3MjB1eWxDblBMQjNTbzcvTWx6OUhRTDQrLzVmM0dGd0Z2aHgr?=
 =?utf-8?B?SkFKbnB2TldKOTBGejIxMSt4TGJ1dmN3eFhTQkdUTDdWVTEySU55Y09oeU1O?=
 =?utf-8?B?bWVoNmJwVzh2WExhSkNBTmlvanpOREtwY3hyOWI0aStpa25idFM5OVNrc1Mz?=
 =?utf-8?B?SFE2T1FNUHRJRWVmcHlQZG5VaHZOcHRhazhrSE1NODlISjhqMmg2dzMrMGZB?=
 =?utf-8?B?a3VCUnRXMnBMczg3a0VjcFd4SWliK0d1MnNOZkMxd0taMlJzOXRJZ09qMU0r?=
 =?utf-8?B?MVpTbXdkOFlQYmlRc3pWNUVnTkgvNHRQVG9FQkZBbDNQa3pvK0pjQkY4dGQy?=
 =?utf-8?B?RWRiKy9nUERWOVpBYlV2TFV2TXlMeVc2NHBuRE5BSmFDNXpCS0s0TXhidGRz?=
 =?utf-8?B?ZnBTQTRCYk1ENjFRRFU0aGYrUUtjMUZXRTZkSEVzY3BQcEhhTWVRY0V1YU1r?=
 =?utf-8?B?QlhtWU5xaCszNWhEeXNkcmQ1Vkd4ajJiVjNQWW02K1lTaVU0T2wwMCsxUnUv?=
 =?utf-8?B?ZENzU0FkM3B4ZTN5QlNTYlFWanIwY1BTWFh4bDA0Zkg4UGVtd21hYitFWkFi?=
 =?utf-8?B?ck10Qk9ZWlUrN2lUQnFPbSthaW9JOXZJSXVVamJDVkpIcEYrUjE1NWtaREVY?=
 =?utf-8?B?c1Npb3RBQWhnbkRBTzcyMmxwK2VrZktpQ1lpOGkxWDJ6c3Zoc3FpQWkrblc2?=
 =?utf-8?B?Mjh0R3lPYUJFUENUS1MyR1JPY1dVTkQ3ZXd0THdzdytzU0M3ODhpWUQvLytN?=
 =?utf-8?B?RE5mZDgwWEVUMm1iaURsZ2Q1RXV6bVhpT20wMEhERVQ1dHUzMDRWZk1FaUtj?=
 =?utf-8?B?UEo0RGFGazEwMXBqNGtqWlkxWXZpcXVVbE1XcEg3L2krdUc1a1pkcnY5SGoz?=
 =?utf-8?B?UUhjNkFZdi85T1h0VG9IWUg1aXdlSGxOcTdMOXpnSmNhMjZOckdmOEZ6cnhz?=
 =?utf-8?B?bUYxeElnK3lsS0dGMGt1S0liYnJZM3p6YmNkenRiYnRvaC9NWHRUTzJ2MWIv?=
 =?utf-8?B?RFRBYi82RVhpQld6K0FnRWJhSmVTeVF5c2xYdGJCRHhTNytjNmZIeWlxcTdm?=
 =?utf-8?B?aE1pQkNkaERLV0VjdTlJeXpNMUpBYXFDT1QwSWFjb3pUakszeVVoa25XMGla?=
 =?utf-8?B?TXhITmNvWEFPTW1BRGV0ZHhTbldzK0RORDNtVndldFpaNExTdE9DaUhzYUdB?=
 =?utf-8?B?TU1ZWXpKNkFZYkJYaXc5TGIvS3A0V1V4SW1JNWhzL29adU84a2xwN1hGYXN1?=
 =?utf-8?B?K1l5QXByK054VWwzMEQ1ck9mQ2ZKVXBJeXRyTCtpalpBMktWWndZWHdERlRK?=
 =?utf-8?B?eC96dUUwWlhDSlphUk1ZUzRXVFhGUm8xa0NIdkJLMmhMMjNFNHhubVVGVTBG?=
 =?utf-8?B?ZG4xMHk4OVNGclc0TVlhQ0hMU2lXYm9JczNFMy9pQit2MkE1b2ZsemdFTWlq?=
 =?utf-8?B?bU9LT3BpaG5jUTNkYzRSOENFcWlrSDA0OXY1WHJtRjlTSFF5cjR2OFhKRDI4?=
 =?utf-8?B?endtTU9qbE9MSUdVRlZKVmcrcDdOOERWOGhaNXJkV1hldURldUxnaFMrZ25Q?=
 =?utf-8?B?RTRJNi96bmFjOWpsWXRlOTVsaURqRmN6akd1bG5EQmIxM1c0MmpEZ1VqZ2FG?=
 =?utf-8?B?MDVlWVczcVdDK3BQenZnT0IvSmpyT1RTcHJhUmlpdXlPTWtnaElOWHNPVTFP?=
 =?utf-8?B?SlZqU2E1N09SeGVNVXBSQlNNSGVNYTNZWXl6NldRSGVoWjRaU0FKcTJINGxM?=
 =?utf-8?B?d3RHN2tORUZjY1J0RzRRSHhFTXJsaGhJRFVtWTBDTExRK3BOR3V4VW1YbmtQ?=
 =?utf-8?B?QU1zT0IzSVlURldOTVhuQllZRjEwamN6UWo1c3RMZjRyV240Y3h3dlByM1JF?=
 =?utf-8?B?bkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c596a3-0e3c-4f53-b8ee-08de0be9f430
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 12:54:18.7111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XpVlJLzlOIx/oHT/vZnrJeZfjZi9EWkZSDeXJ7q/lyQRt6YOVV/pM89rlSzuhhGaSNHGg9zDtaIVlj1/uzrvimMA42TG8u3NGsKA+aus9iI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8007
X-OriginatorOrg: intel.com

From: Eric Dumazet <edumazet@google.com>
Date: Wed, 15 Oct 2025 05:46:27 -0700

> On Wed, Oct 15, 2025 at 5:30 AM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> From: Eric Dumazet <edumazet@google.com>
>> Date: Wed, 15 Oct 2025 05:16:05 -0700
>>
>>> On Wed, Oct 15, 2025 at 5:02 AM Alexander Lobakin
>>> <aleksander.lobakin@intel.com> wrote:
>>>>
>>>> From: Eric Dumazet <edumazet@google.com>
>>>> Date: Tue, 14 Oct 2025 17:19:03 +0000
>>>>
>>>>> While stress testing UDP senders on a host with expensive indirect
>>>>> calls, I found cpus processing TX completions where showing
>>>>> a very high cost (20%) in sock_wfree() due to
>>>>> CONFIG_MITIGATION_RETPOLINE=y.
>>>>>
>>>>> Take care of TCP and UDP TX destructors and use INDIRECT_CALL_3() macro.
>>>>>
>>>>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>>>>> ---
>>>>>  net/core/skbuff.c | 11 ++++++++++-
>>>>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>>>>> index bc12790017b0..692e3a70e75e 100644
>>>>> --- a/net/core/skbuff.c
>>>>> +++ b/net/core/skbuff.c
>>>>> @@ -1136,7 +1136,16 @@ void skb_release_head_state(struct sk_buff *skb)
>>>>>       skb_dst_drop(skb);
>>>>>       if (skb->destructor) {
>>>>>               DEBUG_NET_WARN_ON_ONCE(in_hardirq());
>>>>> -             skb->destructor(skb);
>>>>> +#ifdef CONFIG_INET
>>>>> +             INDIRECT_CALL_3(skb->destructor,
>>>>> +                             tcp_wfree, __sock_wfree, sock_wfree,
>>>>> +                             skb);
>>>>> +#else
>>>>> +             INDIRECT_CALL_1(skb->destructor,
>>>>> +                             sock_wfree,
>>>>> +                             skb);
>>>>> +
>>>>> +#endif
>>>>
>>>> Is it just me or seems like you ignored the suggestion/discussion under
>>>> v1 of this patch...
>>>>
>>>
>>> I did not. Please send a patch when you can demonstrate the difference.
>>
>> You "did not", but you didn't reply there, only sent v2 w/o any mention.
>>
>>>
>>> We are not going to add all the possible destructors unless there is evidence.
>>
>> There are numbers in the original discussion, you'd have noticed if you
>> did read.
>>
>> We only ask to add one more destructor which will help certain
>> perf-critical workloads. Add it to the end of the list, so that it won't
>> hurt your optimization.
>>
>> "Send a patch" means you're now changing these lines now and then they
>> would be changed once again, why...
> 
> I can not test what you propose.

You asked *me* to show the difference, in the orig discussion there's a
patch, there are tests and there is difference... :D

> 
> I can drop this patch instead, and keep it in Google kernels, (we had
> TCP support for years)

Ok, enough, leave this one as it is, we'll send the XSk bit ourselves.

> 
> Or... you can send a patch on top of it later.

Re "my Signed-off-by means I have strong confidence" -- sometimes we
also have Tested-by from other folks and it's never been a problem,
hey we're the community.

Thanks,
Olek

