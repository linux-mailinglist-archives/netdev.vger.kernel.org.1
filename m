Return-Path: <netdev+bounces-278234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oG1qHEWA3WldfAkAu9opvQ
	(envelope-from <netdev+bounces-278234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 01:46:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7ADB3F44BB
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 01:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D66FA3050A17
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 23:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA9035E949;
	Mon, 13 Apr 2026 23:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SByZV4FI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6C92F363E;
	Mon, 13 Apr 2026 23:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776123849; cv=fail; b=UueJsf6jUroEI/3W3mTTxLnnzObz2Uuupnz5+TWHKc1/jXamjQiQ/2SYPMuIg8bSY5q+mKhdfHdqLh3NznL7qBt2eZWxDWj0cSBtoWsy2NOhJTa5P0EkeVhGuw9RcJWqjHA91BNI58nuinSI2rm1SkOnZcMvR8qOiMviUU0bfqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776123849; c=relaxed/simple;
	bh=gyidXkzJ5HtA7gaANWL2odA04ZqLTZ8+0+CqBa5hL7I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J/5gm0BIqA+UyxAAOZYkPcmmY3S8tw3chcPPd/hFnpr7/Q/IaoUU/NqejHV5oarIaTdjp2egibD5fFSW3zhHAIwIiHFDWrjCBN42Hw/Y1dR5jVVZ9DiI1hwvKM3SbxowqTfeyGo0LCQRURksPnb7uSgVDslou6q9bGjhTma5L+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SByZV4FI; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776123848; x=1807659848;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gyidXkzJ5HtA7gaANWL2odA04ZqLTZ8+0+CqBa5hL7I=;
  b=SByZV4FI0oqOzlRQldJs0aTA9jmXtDoE7uXPzPirTbtz+mKYzJXjQ/f5
   Oprzwso0hnJxQAdh04LmkW487cqLqng3SEY0tHZYBJtUcdOhSLCRFVt6i
   3lmoxUj4ITgUF0gOJQKxIDq+WaUQzIK/Dy5MhUKB9n5T5e8jDLd9lhn3Y
   9NhuNlWIINJw2CEKGJTlEYg5W7e+U1AldI2+Hy3EGYFw+SibZTBKMvZMp
   Or0ahtHHPeNFc3Uj0W/AxwfMYc0UJSWVwyc/QTH/hGj9AA7S7sErBqslX
   zAeAkLxce0/jX3xapPCHhQ+f44pvXlKkkCWoil8jj4EjLKZ2XFYSZHF8m
   w==;
X-CSE-ConnectionGUID: FzIxxGnpSwGgjDyjpiGQlA==
X-CSE-MsgGUID: ZuxVBRCsRO20iURXlPpwRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="80956644"
X-IronPort-AV: E=Sophos;i="6.23,178,1770624000"; 
   d="scan'208";a="80956644"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 16:44:07 -0700
X-CSE-ConnectionGUID: WNDrxVQJTvSZG8Dk3KaCxQ==
X-CSE-MsgGUID: TlhfwWG0QEuUUCbBznDY/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,178,1770624000"; 
   d="scan'208";a="225620473"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 16:44:07 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 16:44:06 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 13 Apr 2026 16:44:06 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.19) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 16:44:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7EyuHYdQ4fTbdpnsx3dTluqeHkrb1RztTnBAP7Gzxq7NbLLdqzYRMbrDm0hKQPsAmY39kQHY1Pvh/JblVKvzvNBJdWR9d5Krb2w/3Iwd0ZouGCCO/Ba7ouB43T+594sC3FviVO247WaE3dj4XuaIzVpfyEeeducCvVqO6XNfzm71gDy3+7ghKld2dnCBMpVsy+wSoSNomJdAjEkAs4Am2pk9xwhPhSt3IMRDwy2AHJxd6m97/dpmA4+ru9vP3bcSaxS4IflrB1ZAZOyDOatiRvOGP9hGSqwbMWmp9Fcb4zLN1L/1WaF/JN0lBCneptAdx8ijq0cjMLKSIITvNgq5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dDB3ec9f6DtKJDn1LvAtaeidcnATxYbgWyEYrGgv4A=;
 b=eSHKwsh7ttPgv0qr9PFsgLdZU1FgumttgmiBOYUeiY5yCIfLHHvA3vmK6wmtgig4jdyXJDklIDLWHjCruhdE6cHv75OeJyDoOBU4s9WahBJbmD3xfNfD5NcdxTPJmPUoeoCj0wcKjd76zdrND0SgqYqbuWTSL4uSnWbZiYlim+UvkdJRltfyTbJOTa9GwsZ6fYN+x+mYnBeqxh8rSZpFlrM2t8P8vq2H+w/L1SuhfgjgIbDjyBsNzSoGmAJoEJ3mroMbq6KF7Irzao57UR42pMi5jaajGHx62aO5/BoFiJd1CLjTgv/Tp3vpnUxqLw3SEDt8DF4SQOFkZuwfVfu3FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 SA3PR11MB7980.namprd11.prod.outlook.com (2603:10b6:806:2fc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.33; Mon, 13 Apr
 2026 23:44:02 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9818.014; Mon, 13 Apr 2026
 23:44:02 +0000
Message-ID: <356d6a30-fced-4b64-b54d-b69aeb169758@intel.com>
Date: Mon, 13 Apr 2026 16:43:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] ice: fix infinite recursion in ice_cfg_tx_topo
 via ice_init_dev_hw
To: Petr Oros <poros@redhat.com>, <netdev@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Aleksandr
 Loktionov" <aleksandr.loktionov@intel.com>, Nikolay Aleksandrov
	<razor@blackwall.org>, Daniel Zahka <daniel.zahka@gmail.com>, Paul Greenwalt
	<paul.greenwalt@intel.com>, Dave Ertman <david.m.ertman@intel.com>, "Michal
 Swiatkowski" <michal.swiatkowski@linux.intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>
References: <20260413191420.3524013-1-poros@redhat.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260413191420.3524013-1-poros@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0207.namprd03.prod.outlook.com
 (2603:10b6:303:b8::32) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|SA3PR11MB7980:EE_
X-MS-Office365-Filtering-Correlation-Id: bf808bda-1626-40de-addb-08de99b68a26
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: H4D2/lz5uiejBo8MxmXCO9XR97/4HAJYYrN/qYxzJoSvT5jTVXj2G2lbKqmYlLXpQFEJtOt6y7TygzK0L5TCrZHS5Af3XRaFDIMC8yDFUQHo2qQrr12nsQYiSMmikdoow389Gs7sfzpo1OGDl4suE57Gqzmm0d1E0fTDhk5w1TEKo1cAWlbXmg3zEGsosQo8UP+lYf7alLIIKZCeUZReSoc7SAJlPmzzcZXZIHNd4OwSrW1IYy3+Pakqs3H6udzrIHYVxW0qsoRfDpxQ2zMKt1yKww9/p45U9C2/tslPl+wmN/GMYu4ii17rwPGBaN+EixR48vOhWii6LfqDCIrxT7RFSVuySsI/n4Rctvylyw0ZNsn0morJfTWcR/eNsAwLwhUlPLtboCcm4w4gUyicFu9F4wmoE4wCucqkqkoCjbw5M/JYHmj9UXZ66jb55ZWMp7R9ovf7150lcef0zaq5ZNugkFeaoXOAYKaVet//Wan2IPQZ3W5+fAiAzjSk7Hy7I44oyjW9KxKdmI/moquDc9TAtTJcDbh5DLmbmEIT8YmbLCM9VlOXGi8IChxXqgXdvZ2R5fQICuBKR8Q6tRo841t+DlQWeVeMa+Zib69wNTiHXiqcAQfU1UeXBf/MyPPJ5VylrLW1jadkBI2FQh2v/8nQdqkAwc5JDnwfo3ai1k1lkBk8SEHz1OaXG9vCEf/QJpXfJh36K8aKA9tdIrSd6SYjAZZK/hOwZm0lV6ymDQI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlJZckU5SW9XS1NSRysyclJ6SzlXcWZvb2IvR3Fhdy9RQlhwQXdSeXQySjlF?=
 =?utf-8?B?R0l3eURRVUpyQmVsNTdndFM3MHBZcUptYUtML0dvbkUrZVRQNWJIcGNsYnEx?=
 =?utf-8?B?NW1weDhkaEo4dGlyUmttWUZpYURZV3N2aGpTaWcxKzNib3BiclRBT3VjYTEy?=
 =?utf-8?B?YWVwcCtERXNuWG1IWkk4cU1od2pIemRUVGQrRi90WUUxU0IvLy9tM0NtcnBY?=
 =?utf-8?B?TWYwNDlMZEFpTDkxRjkyV3c3eFZRZll5M1U2VEdkdmV5WHhIOWRVWHg2dmVh?=
 =?utf-8?B?eWo4bmZpdk1wTi9ycGdHNkVidHo1WE8yMGg4bENaWWYvTE02cHdXZ05uN2dG?=
 =?utf-8?B?ck5PUWNkUVVQZ2F0dEU5bmFZVDBrVkR2NUYwOC9LWmJYUG5xQkN1ZlBtMlpi?=
 =?utf-8?B?bjlsYUZEYjkyVEIxVXJEMGJSTlZyNG1yTXl2UEtYdXJnaVRtZllsWGRIVmYx?=
 =?utf-8?B?OFY4VUVRKzRQVS81SjVtWUVISUFvRjh2NS9FRFNIOVViWG5mS0wyWTBjaGdo?=
 =?utf-8?B?aFZIN2xDS0tHWTQybDBTWTAwUzd6aldOaEQ5dHUrYUllQVlHK2p4UEsvUHRp?=
 =?utf-8?B?NlY1QkJUWFdGVk1HdnpzZVp0Lzd0bU9WNDJpdE8wcnJ3UklEemplNW0vRnB6?=
 =?utf-8?B?MWlZRW9ReDdlSEphdzlQeXFWUkVuOTlDYWd5czdsQnh2Zi9md1VNMEJ5OG9T?=
 =?utf-8?B?V2FTREJwbk5nV0lualBqcTZBeGdURzI2b0ptUFBZVGh4b1ptK3VJd3BpSTBR?=
 =?utf-8?B?TDdxZGtxQXZ6NTRFd2dkbnpsek04TXhML1RXU1V0dVRndnZ0bDhWWE9SaUtP?=
 =?utf-8?B?Sk55WXhNdlBhd2MyUDZydWozYk9tVHhCR3RrZjhYek1WdGZpUi8wU1hvemlt?=
 =?utf-8?B?aGR4a1lnaDAvQTB2ZDhkdWFXeGZTbW9GYW9FOWdGckJ6elFzcE0vUnhlbElz?=
 =?utf-8?B?OWxqSWlCREo0UXBzbEE1VEpLVzJsK2VKaXRheS8reUdQV05WTlpVdjlFd0wx?=
 =?utf-8?B?TkxjZEE1K3k4TDVMZnQzZ0F3VnBGZVNBTk5KaXlxL0kxRkNhMFgzQkhaa2xY?=
 =?utf-8?B?ZkVkMjBYL2t6b0hKOVhkdWxFRC9icFZmTnpXNVhoZEpuN3BxNzhsYnRLSFN4?=
 =?utf-8?B?YjlCY0wwVVo4aCtaZmdEQUdTaGFET0lWd3JTZ1Bvc2pERkpKUTE3cW9oWS8v?=
 =?utf-8?B?MTBISEg0UVZ5eitXV0dOcFNkenUxM2Nva2JoMnp3eFViN3NrSzlhc29jZ3M0?=
 =?utf-8?B?Ums4RFlaT2sweElzWm5JR2RBcm5MdnYyUGphVG9UdElNMG1OL0EzVGc5MTJk?=
 =?utf-8?B?TzNucGRQcFBsOGtUdHpZRlZCWDhCeXFydjlsUkwzeXhJbHNCd1RzdFJwcnQv?=
 =?utf-8?B?N1dFcWVhMDlaTUV1VlFVNVRvKzA5dGpZRlptNXRIbElQdnE0T2RuWVRON3k4?=
 =?utf-8?B?TGlOWmd5OTUyVHpvWGdUWVhTTEZHZVBadUF4YU5xVXJMWUVvT3NuSjVPOUNB?=
 =?utf-8?B?c09vcE8zVzlKbFRvVUxrRHF6UXFwSTBSdXlqZTJtV2YxM010NXFkcW96K01j?=
 =?utf-8?B?Wk82enRwMzlkMHBMZGZCZCtFblRjOGhHdmVpdE5WN3dqRHlEdWRJWmRzNC9a?=
 =?utf-8?B?bnhrUVA0b0ZBMGNCeHNHRjdvL0FKZVZLTjc1TjRQZ2NDTkVsK1h0ZTBlcGFJ?=
 =?utf-8?B?VUQ2Y1haZkJoYk9BNzlPTGZaRFZNd3RvY1EvYjE0d3k3cE9helV0SHZGQllt?=
 =?utf-8?B?emRLMElrWGgzV3A2NVFTSVptbkQ5K1YxcVJDS2llNEVMeGpNdDRxOGhGaUJm?=
 =?utf-8?B?NmEycytqZ1hrSXI2MFA3MzZQZm5uM20zS05RbXhCWGFQZlpBUDRaM2pOKzBt?=
 =?utf-8?B?WU1tOXNtbS9IVytHQ01EcHZQaFVMMUhxWGVNMi9BdkdTTnJFN0lLU3lTbWNC?=
 =?utf-8?B?TlN3Ui9USWRNaDJXeCtwdm0zRHlTMW5seDY4ckRkZEhMazlPS3hnZWpsTWEy?=
 =?utf-8?B?V3YrdTZSTHRJLzZDaGNpcHBRTEc2Rm9BSkE0eTQyR3ZPekhQaXJQSUxnUStO?=
 =?utf-8?B?MXNGOXg5enZzYThuOVpWZXpoNnJEUWs5em5Gek4xQzY1QkgxbCtaM1gzMVRS?=
 =?utf-8?B?UVFQdUNmT2ZxR1p5eGtMTkRLa3BqU0M2SzNXcjV0Wm8wNEVFQlJTbHB1S2k0?=
 =?utf-8?B?V0dvTmVSL2F4cWxvVG5wWmNiMWp4Z2V6cEozbllwNUNsRzNFTmRxNjQ5N2Vi?=
 =?utf-8?B?NzIvSlZqSUZKajFYRG9UMFdYcVNiN3dPL0RlUUJYS2VEb1dZOU1mYU1ybE9V?=
 =?utf-8?B?bTZDdkIyYld3eDdqVHZWWWFUNXJYdzBpRndxYW12K0FobENuaGVtQT09?=
X-Exchange-RoutingPolicyChecked: O/iGFFXh7Ox/TTUrqAxdKoPrWM3D/QkfKqs7KTeMbH1xEgVZ8fmeeHJiC5IPqLEb03s7JOmrTV2mSYxdR2D1oulshUf5AVfjS14lgT5oBRZsfMmmZPWvV0eUthjEOPmVzGysOcjgPZQs19BjgXJJc5nqA+CkZXwNSPk9y6Lc0yjrLv+aI18B2a0WgLuB2pTRvf188B4dzMSsKWGAprxVBV8C8yEGVS7VqFKWmwDzVEsP7KXol5TcZiFlA5363owywJUlqi9J411f92AA5YqXlA91oVrplV1OPnI003FtuXMdo9I8RHUiDXtbTxFLPATHTGszsD50gUT8+s8hmj1DLg==
X-MS-Exchange-CrossTenant-Network-Message-Id: bf808bda-1626-40de-addb-08de99b68a26
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 23:44:01.9936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wylWtinuGaPM3ENoK1j4nvJ4BtnOtyY/+HmNQtGoBJxX5F/EPLBRpW6FGbSZgKoDmnemmaNPsok6X/cJTjlK0fd+bOk2cHxBDhPEZrFRBq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7980
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278234-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,blackwall.org,gmail.com,linux.intel.com,lists.osuosl.org,vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C7ADB3F44BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/2026 12:14 PM, Petr Oros wrote:
> On certain E810 configurations where firmware supports Tx scheduler
> topology switching (tx_sched_topo_comp_mode_en), ice_cfg_tx_topo()
> may need to apply a new 5-layer or 9-layer topology from the DDP
> package. If the AQ command to set the topology fails (e.g. due to
> invalid DDP data or firmware limitations), the global configuration
> lock must still be cleared via a CORER reset.
> 
> Commit 86aae43f21cf ("ice: don't leave device non-functional if Tx
> scheduler config fails") correctly fixed this by refactoring
> ice_cfg_tx_topo() to always trigger CORER after acquiring the global
> lock and re-initialize hardware via ice_init_hw() afterwards.
> 
> However, commit 8a37f9e2ff40 ("ice: move ice_deinit_dev() to the end
> of deinit paths") later moved ice_init_dev_hw() into ice_init_hw(),
> breaking the reinit path introduced by 86aae43f21cf. This creates an
> infinite recursive call chain:
> 
>   ice_init_hw()
>     ice_init_dev_hw()
>       ice_cfg_tx_topo()         # topology change needed
>         ice_deinit_hw()
>         ice_init_hw()           # reinit after CORER
>           ice_init_dev_hw()     # recurse
>             ice_cfg_tx_topo()
>               ...               # stack overflow
> 

Oof, ya thats not good. I guess this only happens if the topology needs
to change, so it wouldn't affect many systems where we had already
changed the topology before hand on the old driver.

> Fix by moving ice_init_dev_hw() back out of ice_init_hw() and calling
> it explicitly from ice_probe() and ice_devlink_reinit_up(). The third
> caller, ice_cfg_tx_topo(), intentionally does not need ice_init_dev_hw()
> during its reinit, it only needs the core HW reinitialization. This
> breaks the recursion cleanly without adding flags or guards.
> 
> The deinit ordering changes from commit 8a37f9e2ff40 ("ice: move
> ice_deinit_dev() to the end of deinit paths") which fixed slow rmmod
> are preserved, only the init-side placement of ice_init_dev_hw() is
> reverted.
> 
> Fixes: 8a37f9e2ff40 ("ice: move ice_deinit_dev() to the end of deinit paths")
> Signed-off-by: Petr Oros <poros@redhat.com>

The fix looks correct to me, and definitely the most elegant.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

