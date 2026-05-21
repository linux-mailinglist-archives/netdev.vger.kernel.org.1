Return-Path: <netdev+bounces-290419-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPHPGI4KD2omEgYAu9opvQ
	(envelope-from <netdev+bounces-290419-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:37:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4245A6063
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3DAA32429B7
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0583D9DD6;
	Thu, 21 May 2026 13:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oG/Tzukm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A61242D7F;
	Thu, 21 May 2026 13:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368434; cv=fail; b=jQ7AiBfSggjybcERI5pxn6PjP36dFKqhX6v1St6P2g0K5xDRTfmhphZn4uy7Nw+ooIZrcRyX0Z0nbsxuJ3pMWo0qht+ENQNLmaDsvGTe6OFjX/A3etvhg3vdOsnr3r0NhnySaq2FEfa9fpqSiDtzQQRT4eMfWszQwumIZeGLF2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368434; c=relaxed/simple;
	bh=BJJ6tdjEncD0wVvFGj0znP8+sdT1lS3md6s9B0P8ts4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k+KnP7z/baIpjNlm7Xxn6q/3Us5V7HWgOvA0nkskcBdcKlJP5ltnGD6DKCtqPsFcR8Thj3IfVARDrG8ymJyaJ73wOmQb2lAfTEkA50RcfZsz3z9lryHkPlQcpda5d1HSvEu9VrGhx11l1nLpSC7XxnjRsx8jkTCjPVxq/UAd+gY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oG/Tzukm; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779368433; x=1810904433;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=BJJ6tdjEncD0wVvFGj0znP8+sdT1lS3md6s9B0P8ts4=;
  b=oG/Tzukm34jp0+hDm9wo1qOXZYF+d9YG7QX2S0BdvRoFa3ZCRb6xl4tP
   OrASk2s5DVY6Xnde4afTo3xrRWzY0JN9rAGdtK7omAnYCb5DrMA/FttVW
   Yi7R5msmv2eMAAQepuROp4/bGbmWG4LnRsqB9YKp70+1o3jNyNCyN1dlA
   3BYI15hp21UpiIAkt2E5I0CHusXAKBXeiVLYrEBr4vpVd+nd8GTYkzm8p
   0306G9xviO74yWAWKUkNK81fgQY6mg+czhEm34mfOX5iux6HGOQsEZo1R
   LyT/aJCh89wPV1/+hzH8tsOoekFZ35WSryBQOhE4nT7t4uP2BthJK0Mmu
   Q==;
X-CSE-ConnectionGUID: SfO+Z3ioTbqi8sp85VlpXg==
X-CSE-MsgGUID: VioiYp8PRmuanIlOT/GRZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="83904580"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="83904580"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 06:00:32 -0700
X-CSE-ConnectionGUID: ce1jhq7HSzCyll/TaP103Q==
X-CSE-MsgGUID: uSHHPXqNS1qLcoeF6u2V9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="245552998"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 06:00:31 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 06:00:30 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 06:00:30 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.62) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 06:00:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctgnKhIzUPS/TU2reoZ1dqDNpwyVeaIDPuVKyu5zlhYucBtqSe3CqCugrGrrDqxG90TJyF7+XtPYg/iQQ75UTh4ryYAe7W2S5UmhYsyU2ummHqrUJ8FX9xcGGYPuF2kl6UVUPnEXLLF16g5rIWE5c5S/R4oofCF4KHESvQSJWkk6xX1boXpS6s/eTYDFVLj6DIp+S/ZkUVzYpUb2jF1WBM6PQaKwXn5tNXvyJb93pUS7T6K4rwKIDF1dRoo8tEzLWGV0nHUXc/9Lt5WHcF0n26Oug/Bn231KctpPcEnuiT5WbOunKneEuSCqmV1XCPo8a6ZctyGfwb8j/gJ/YYXHFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPoh9rY4IMraIqEWEcr7MLN+Smf1aDQ5jrMMraUCogg=;
 b=PPHpxRTeV2JsOZIO5DwCV4z4MMFuj7wv5z40ijIMVJBVK88cHL5HHWK5ueieCTehSDI3b4LKgSXqxoOM3XtrnPFDU2oKe3Nw+88Ngbw2zpc04YYMOxThUhNJ/sJQ22OXznWZkIPg48cNAXtK9qbidWlnrs+1JWLaOV8fbqiWDhr/rbmVSKM+goxYNBgeDK/HJoodP/3h1JUDfZbJWaQ99sY3oCh1RwHRFwkVO9i6MB42pzgnNv2RAsII0kDfdfNeHcpv6XusoJNvcYtPDGc1s+wHWLbXobDwEGvQPgzYA3gYahdngwK9ZWGeq36mYM//Z32m4zC9ZxUqE+4HYh33Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 LVXPR11MB9755.namprd11.prod.outlook.com (2603:10b6:408:389::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Thu, 21 May
 2026 13:00:08 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 13:00:08 +0000
Date: Thu, 21 May 2026 14:59:54 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<horms@kernel.org>, <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net v4 0/5] xsk: fix meta and publish of cq issues
Message-ID: <ag8ByhbrNNJaESYi@boxer>
References: <20260520004244.55663-1-kerneljasonxing@gmail.com>
 <ag75Xicuk6JwkTkC@boxer>
 <CAL+tcoAJ3i-WGnVx-9ASF29gPNAaP2ucw76x3ftLog-b1TPf_w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoAJ3i-WGnVx-9ASF29gPNAaP2ucw76x3ftLog-b1TPf_w@mail.gmail.com>
X-ClientProxiedBy: VI1P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::32) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|LVXPR11MB9755:EE_
X-MS-Office365-Filtering-Correlation-Id: 362f9030-9ff0-4c7f-e873-08deb738e2d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|56012099003|22082099003|4143699003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: VfP9plMEQIZDD6NNXoWM5ZbofnKTu58thxargqOWqUeUUVroFjVgRVftgRtAp5SRifl0FeZgR/uUqeLAEU+dKcJO/1yzJzb9Nnjj+CxAF0vPhk5YTCunFN2AE7sX01sWjq2juSNSA6OPi8RQSk0hDMSS4LsnkRIAb++HzwHFrUvpuG+LHwbdn0Id6jEnH+MuHmUzb67/O8f4Aw5FKBCzUsYj8ET5a1l3jey9sJhMV3yCRdIloLrIamuZkQNN8cGO+SdsHqO8T/3RWlq7ivOUAcNe+ENlyGCq+IMfMFgZZaZAGlnvPyKHPAUc9yWKHWdpxxIgyuPeIggS+6lmKMnC5xc44qCWQMKVnnVQu4W7Gmyf4HvFnJOlz587Dn/w1/+wgvQZ94GCiHZk6ZtRJR1NILudxTjHKF6pNqHbuXEBtkMzU80oic8elcwj05FtAKseaUFr1InkwrzNTrfnl65GlkCWb4rIXSzRsHwQWVjhR3gcfKN+HcsfT6/axByTqY/Hu+kUDvSPqF7u04zYYGb/P9yURYeHm2igRAho7w9XYkww8xfTO7sS0mmsJvT498EJR6pfVHxnMsdGsPwSJflYgnmGB/KDWD7gvFcGv2q5b7Vm/wFRwNyKgfpivn2/jB3/PPdpbR/WddqKqxMX/gh0cxTb82+KUyl/fhh7FjO9lYef2RnM5KW4Rx7Xlrf4/q4H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(56012099003)(22082099003)(4143699003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yi8yYmkxMUZhY2tnQy9MVTMwdGtwZVJzZTlpaTllMHM1QloraTY2RHcvcDhl?=
 =?utf-8?B?UTF5WEpQOWRXa0lTMXpBYWlaMUFSNndXMWlPblhudE1wZENoZXhMNnlucjNZ?=
 =?utf-8?B?ekcrT0t5OGI0VGRmRXRkRzRVaVA1L2VVWlpoV0w2TzNHKzVCWlJIWUNUOUpP?=
 =?utf-8?B?bUlxTmtNLzRnWnUrZkgzdzhadHQrbitRQXQzMEZOcjRvZmJxZ1F0OUlNdzY5?=
 =?utf-8?B?elVDWUpnb0s1SlYyNnBMaXFRMHBqNVVKTTRUbmZWU3FQcjdUU0dYY3FlWWVh?=
 =?utf-8?B?cStOK2tTTC9ZR3ZuaWpzZHdZeVVXbUtnQjAzTGtiWk1naXFkeTJPamc1amN3?=
 =?utf-8?B?VSs4N3ZNbllIVzkwaW5EQWZTbHRQMlVqQzFoM1ZkWHloa3pxVHAxSlpucG5z?=
 =?utf-8?B?MDRNWGVvMWptQm4wWGs4UVNRZVQxdGptb0M4SHk3RGtyZC9SUW0rbTdheG53?=
 =?utf-8?B?bzBNbjdWa3VRZUNoekhibDRISW5MWWtIU05oV1pPV0lqS1FQd1M1Q2QvNm1l?=
 =?utf-8?B?a04rZ2gwUllzcEdsdm52NGthUjQ2Q01OeUhxdmVOOS9pQjNEYmcrem5acUF6?=
 =?utf-8?B?cGtnWWIvbnM1M2JXMVNFNG5zc3VHWUVodkYrWEJSQXpWbUJkSWFRVnZXV0Y4?=
 =?utf-8?B?MTZtc3lBSGlaNmg4ankwL2YybXVsQkZSUWJBUk1lUW9PaTVENllsOUY4dFVJ?=
 =?utf-8?B?TUQ2SGpZTkh2aXp5dzcrSnkrQXRFK2IvTUtVYU84ZkFFREk2c3dua0NPUEhG?=
 =?utf-8?B?NVJDRE1XSnRGU3NOWXVzM3RwUUJVN3N0ZzhtQUwza1dUY2xWK1RJY3UzM3Zh?=
 =?utf-8?B?OW45b3hyRlh6STQvam0vdHh4bnFqRFZOR3poS3U3WlRVOTBCa0svL3ZmeGFw?=
 =?utf-8?B?WFB2YTZpQkNaeEhuVkg0aXdaaGxmeFRURXlxSFNlWVNsYWtGazg0SERVWUtT?=
 =?utf-8?B?aWJIMUlYMTdiT2s4N1RZcUhsQ3RNK2plWjVoMGtlSXhLQ0tPaDdTZDZPNTBJ?=
 =?utf-8?B?UUJzN01BSDJYa043MDBaZkgxR1l0aFhqTmVzNGlwNjFhRkpRUWlsbGxiTGc4?=
 =?utf-8?B?aVVVRnVZNTFIRERVaDZDSHQ1THFRTHRDUnd5cGJ6OEtUUUlPSElrRldwUkV1?=
 =?utf-8?B?SnJ2Y1N3cW00L3Q2Mmt3YnJBcmVDT3pDam9ZbDNsS0JSSWdnVnZLWXRndU56?=
 =?utf-8?B?UHVLMmFzMkhncDBvUURxcnFCeThaYWlUM0NCY3ZmN1pqVFYvSTNiTkdQWFRo?=
 =?utf-8?B?T2hMVExxWmQyczBUZVVreVVkc1N6UGNSUVI5VllCc1lIZDF5dm05YXowVjI3?=
 =?utf-8?B?cFVwWUhaYjFyL3cwWGgvYU82UGpYcHQ0V2xiRTZUMEMzS0NGa3MwbWovZXJi?=
 =?utf-8?B?SzRlZk1IV3ZoRnpSdnYzMHE5L1FBeUh1RDJSaEpITC9jTTZpRkEreW92QXpM?=
 =?utf-8?B?a0tSSWlabWc4UnlOQUdOV3RvYVRqeHdBMXFFaVlrSUNSYTV5dlpLdk84ZGpt?=
 =?utf-8?B?Z213SjdNa3VvMEJKKzQ0NlhZSTk5RllvUXVRZ2pCNGpxOHo1T2NKZXpYdG5t?=
 =?utf-8?B?OWJJa2VTRmdWN3BiVjQveVo2eW84dkI3dWkwZ0c2L3pnTTdFc1hsc2s5S2JW?=
 =?utf-8?B?V1R2cWlqOEhYTzNUVEdaclZxVUJnVk5jbHJKVmtuTVArMHIrZGxVbVZIa216?=
 =?utf-8?B?akZ0QWExRjVkRzBFNVhLZVI0U1hxdGxPNHBhRm1wWndDVXFGOVh0ZEpudnpQ?=
 =?utf-8?B?QjNVa3VWcm9LeTdkMG13cUZ2SnBxa2hVOVRGRFpBVnNLRUdTRmtKZ2NpTVdM?=
 =?utf-8?B?cU1PWlFVbDJxcGQ3dHZkSkw5c2VMR1ZsMmZqNE9GZ21BNEt3ZGprMEM2bGtk?=
 =?utf-8?B?MFM0cGZrd3dZanUwcTVYMzR6aEtxUzk3WjNGZnB4R2hURVJGWk15RTlkSU4w?=
 =?utf-8?B?RlFTTzU4Q0FhS3owd3hGM1cvQ0JVa2E5WWFBZlQ3bVlyZTgxWEkzUnFIejhC?=
 =?utf-8?B?eHQzaVcraEJya1ZybXBZb1dnL1JvTEhTblBzY0NseWxvSWFrbjltV283WjlS?=
 =?utf-8?B?L3NXSndybkkxWGhBVFNOMzZRSDBteDE3Nk9IMHh0TEd6MWxuSjlNTGpoOWFO?=
 =?utf-8?B?bEx4aWJkQ1hvQkx4a3c0S1BYMXYzWnR0czBUcUFjU1V6TEFqWVhNU0RWYjF2?=
 =?utf-8?B?S1lqM0hoSVg2YVBqV1NhVFpCYlplSmUyMWFkWlgrSWNRY3hvTHJ0MEZtRzNr?=
 =?utf-8?B?dGxuOGJqWjE2Sml4anE3cXpCYTFZZ3JEVlBUc09DR1ZsZWFMOUlra2MrUWpZ?=
 =?utf-8?B?ZjB1d00wMVNXOVpUYU5obWV1RXRudWtzVHlTU2hKZGZvVEZNaG5tUW5IYjcz?=
 =?utf-8?Q?unMjJlIGsuohp97E=3D?=
X-Exchange-RoutingPolicyChecked: yexXea6rVEL/1yb70inxbsiODkmRPbM5/9D7gzbN9PEm+XqCp8Wh3s2jL4m5j03BmWJIdpnHp4XNRawR8XZP6bPopaxdiFzwRk+bkFVqEvbG7X7ZsvLFCbAmMvCkiA8wIaR7YWOUaFpFcFpw39UqPTaBmY/MDHUGjnqZQ+XSEovF0E9UUBu24DG6/260voOoJo9Ng9pzvNRodqvIokcxSDvHD78LxeG2YS2ilwd33qtwSUuSOUORDBnU3d/Twome4mLhQVd+0n/jbCcyBhVEBKROKPCmMEAIuVuEMHxlfB6NWn6BuAAre2FWddo2Hfapuhka3InM6ryOUzw8RgUhww==
X-MS-Exchange-CrossTenant-Network-Message-Id: 362f9030-9ff0-4c7f-e873-08deb738e2d0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 13:00:08.6913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: siefCvlJnJZIGeF1bKLI+u8tYsk/ZCVpSNNoKA+7sJXlyqNAhr6hTjkmpi/fiyh5Ab/xvOPxV+5J2u+NWQXoU6Um/osZd766NeL2SkF2Vn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR11MB9755
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290419-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,tencent.com:email,intel.com:email,intel.com:dkim];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 5B4245A6063
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 08:41:08PM +0800, Jason Xing wrote:
> On Thu, May 21, 2026 at 8:24 PM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Wed, May 20, 2026 at 08:42:39AM +0800, Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > The series is the product of previous review from sashiko[1].
> > >
> > > 1) META
> > > patch 1: address TOCTOU around metadata.
> > >
> > > 2) PUBLISH of CQ
> > > patch 2: make sure xsk_addr->addrs[] can be published to cq when
> > >          overflow occurs.
> > > patch 3: keep cleaning up the continuation descs (more than 17) and
> > >          publish its address when overflow occurs.
> > > patch 4: like patch 3, but only handles the invalid descs cases.
> > >
> > > [1]: https://lore.kernel.org/all/20260502200722.53960-1-kerneljasonxing@gmail.com/
> > >
> > > ---
> > > V4
> > > Link: https://lore.kernel.org/all/20260517063311.28921-1-kerneljasonxing@gmail.com/
> > > 1. correct the description of xmit path in patch 3 (sashiko)
> > > 2. move set logic into xmit path in patch 3 (Stan)
> > >
> > > V3
> > > Link: https://lore.kernel.org/all/20260515123018.80147-1-kerneljasonxing@gmail.com/
> > > 1. avoid breaking previous usage of sendto, and siliently handle
> > > overflow case (Stan, sashiko)
> > > 2. add one particular exception process in patch 4 (sashiko)
> > > 3. adjust the selftest to make sure it passes in either virutal or
> > > physical machines, which includes add usleep to support physical machine.
> > >
> > > V2
> > > Link: https://lore.kernel.org/all/20260510012310.88570-1-kerneljasonxing@gmail.com/
> > > 1. adjust selftests (Jakub)
> > > 2. add READ_ONCE in patch 1 (Stan)
> >
> > FWIW I still get test failures (yes with patch 5 applied). PTAL.
> 
> Thanks for the test. But I've tried with ixgbe driver...
> 
> I noticed there are some flaky tests which have nothing to do with the
> series. Can you confirm that it's not caused because of the series?

That explains the different results as i am using i40e/ice which have
multi-buffer support whereas ixgbe does not even support mbuf at XDP.
Broken tests are from mbuf cases.

> 
> Thanks,
> Jason
> 
> 
> >
> > >
> > >
> > > Jason Xing (5):
> > >   xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metadata()
> > >   xsk: fix buffer leak in xsk_drop_skb() for AF_XDP multi-buffer Tx
> > >   xsk: drain continuation descs after overflow in xsk_build_skb()
> > >   xsk: drain continuation descs on invalid descriptor in
> > >     __xsk_generic_xmit()
> > >   selftests/xsk: drain CQ to wait for TX completion
> > >
> > >  include/net/xdp_sock.h                        |  1 +
> > >  net/xdp/xsk.c                                 | 44 +++++++++++++----
> > >  .../selftests/bpf/prog_tests/test_xsk.c       | 48 +++++++++++--------
> > >  3 files changed, 63 insertions(+), 30 deletions(-)
> > >
> > > --
> > > 2.43.7
> > >

