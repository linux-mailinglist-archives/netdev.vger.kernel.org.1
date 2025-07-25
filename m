Return-Path: <netdev+bounces-210230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A73FB12711
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 01:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BF931CC0433
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 23:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD1F22F767;
	Fri, 25 Jul 2025 23:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pb85XSd8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6664B1D555;
	Fri, 25 Jul 2025 23:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753484733; cv=fail; b=Fru0qliJXF1mSgGfZavcRoRDqjG5XrGDhqRblH1I9hoSbauNFcWWDFJeahbbsTsqWt2uMFYcGW2WTgOa2fCAVzP5oeMGEu2YAButMjo2CMMTTIZJ8FUIX97ULUOhnGh4REELB/Nzs01gZCkhJlaXHW6vq4MgKfCxADJSewyl0R4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753484733; c=relaxed/simple;
	bh=yfgEFT9qQXsj+gJia7wbhg4Rouo0BEOFpuPIzZm4MDs=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=ndBOHFRp8NBCiIIx3Am6nR9S44sz8yfQcsEoUxq9T/JsuY6aLQ1QRmeGRSGgndyHD+MW1mftl8mWuIBWSuOWNgWxqPmbVi/1cxeVPDreeP2crl32Pve4kM0KsZaDfqCG3pYsHzfZPnSGcQA01MSRrG0eggJT9ERbKt3T0hPaESs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pb85XSd8; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753484732; x=1785020732;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=yfgEFT9qQXsj+gJia7wbhg4Rouo0BEOFpuPIzZm4MDs=;
  b=Pb85XSd8n3lFI/ssvWTWpirKqqTmobH+nYHc0GpsVcslCezMF4FTPIA7
   cipGvlHMj7t5lk4fXNBkgDjaImjIRS2LxNguBMf7w/KlI84BJ16VoBd84
   zOnz1noL3H6yzxMVvYhtNYKOgB0t+YVDJ4pEKdMlAaA9ZX1UkMpNCKYIE
   cUJfGbXV0ZsZX7Gy7ZmpXlefG8V1Ot4+DSfDoPeY7fowrWG4vvXZLSLMS
   X2hTg+cVagfn1SFzRCTeo7SQ9ndjAZ0/hZO4oAmwYoL9Rj6PlTaIAXh0c
   fLXcv/w8dvdx9tuMABxoBBSeyE9539V3XP/F7HRhCfN38rM09C9AUmfud
   A==;
X-CSE-ConnectionGUID: cySacaZRRluROLMIdMKmsg==
X-CSE-MsgGUID: NEpntUQyQlKRW4hUlWbV5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="55038010"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="55038010"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 16:05:31 -0700
X-CSE-ConnectionGUID: aYYcqlpGQxKseEdK3LMNPQ==
X-CSE-MsgGUID: qfwbFlAZTFm2kmh7jR9XGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="192147661"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 16:05:30 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 16:05:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 25 Jul 2025 16:05:29 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.72) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 16:05:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=knxvHPidwqZygnfanv/s8y9sjactniug3bRJhBfczLtRDkMeDmt5NPl4dqMNeCArU0ggtbqHZZhgnSGXQ/gtU6opOLgVyMTXDfHZULvb2gcS1Wod7PXvRm5vopkRYGxw/L5ARVcLpVOc8dWxWhqbwj0lSkyeZ6buc0lRAD+lYZVBIvYZwQAVj0TeZXu2RdLRUUmF2sQuqr86lm8mqOPQ54pZYCWKimKtVAqZuQCDD5uGfDeyKkurdp8zwQmrZjMy/JwMQoXQk65QUB0kkU/X+a9vmy5x2dFnGOzUHFNwn6DuEaYepbmlvR/VT2vFDzLPZCh1vzxm++/WKCYEIRH1Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZr14GwbadrJhguhnzpErv92hrs0WekPYIV+mX0xorI=;
 b=llD/VMj1e5HLCqw6EJ269qYLwr6oosdld33M2vafip/goW5Nc/GGQsMpJaeHJUkkJGxUeweCg4nlK8nE50BkjRRNyz95BsT+7dPfQlk2q9Qd8oHwlrFhyGlmq8u87rb5CX9AaZipC1b0gKZIqJi0XS+lT2OXt0I4BCuzOpXmvmX82vIT80tDboZaEJF+Y3sk1/RkkGSuDc0UPZ8hu6OjiuQcM/6cSLOcbC3lsH7LJ6sw7WzPFGaJr/1qJanHolCmgpIZYDk02nUuNi9updmaIc5OZfPOjRUyRPVYPTUlKe9Ds5mwE9g5luT3dWP85l8iRvL4OsBybyXoafaL1YR8pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5192.namprd11.prod.outlook.com (2603:10b6:510:3b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Fri, 25 Jul
 2025 23:04:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8964.019; Fri, 25 Jul 2025
 23:04:47 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 25 Jul 2025 16:04:45 -0700
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Message-ID: <68840d8d6f5a4_134cc7100df@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250624141355.269056-6-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-6-alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH v17 05/22] sfc: setup cxl component regs and set media
 ready
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0012.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5192:EE_
X-MS-Office365-Filtering-Correlation-Id: d12af5ac-f6dc-404b-0903-08ddcbcfa6cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0lJZ1dlQno1L1F0S0JMYnFXTlA0Tjc5eXNTeWRQZEJrVlo3Ukt4aVh5Vlpu?=
 =?utf-8?B?eGx4Y1NnU01HVThHd0VKZCtPNEFxejB1ZzBWWWtKMGxVYWxUeGxxenZ1ZWNo?=
 =?utf-8?B?UTBpLy9JVUY5aVBnRHpEK3VOTUFFblRJdTh6dzltRGhpREE1WnhheTFXV0sy?=
 =?utf-8?B?MUhxcHc4Ry9kYW9ZS0JyYUkrZFgrYmVZTVl3a2lCWXVTb25jUzNibUplUFdU?=
 =?utf-8?B?U2MycDNGWXRyUG1VMG5NVVEyMTFGQ3k4bkxheE42cDljeVRxZmxoazVEMnZ5?=
 =?utf-8?B?eHN5U1I0VGdDa2FRNWtxODRwTWNzZ2Z3RWZDNFZPK3N1N3lwb3Yra1VuZk1D?=
 =?utf-8?B?enlIK1JhWmhMY0N2dFdVZzNHVDNqWnZmT0pNSzdrNldwck9DNnhud2Q5OWds?=
 =?utf-8?B?d3FiR3pvMGZGb3dLR0JETS9PZVNtMGxIa085bW9TQ3lhYmhaQlVuMEw3QkY0?=
 =?utf-8?B?UGtwSENXMnV2blFlN1FTNHM4Qm5NTTVuMmdhN3hiUzZBMGNFZVVzT1c1U2I0?=
 =?utf-8?B?Wm5ENHQwM0pXaStBMDdlOVhYT0lOdi9hcjB2QW1RcW4yWmpiaGZSQW1ldzAv?=
 =?utf-8?B?VGlsUmYrZlNxV0d6NlAxb09YMklRcFhKYzVEeWR3b05kMVVUNkJSanZFSloz?=
 =?utf-8?B?WWJhM2ROSS8xUWNUQkdQczZVY003ei9LL2xJVDQyWHlJMHhVLzE4aUdScmpF?=
 =?utf-8?B?S1NKTE9MMTJrVld2U2J0OHNZM21OYjRIZ0VUMlNjejViZWpaQklXNlhwb0Va?=
 =?utf-8?B?eEhOYS9udVNXcjlaU3NTRTk4Z3p2WEFTcTEvMkVrUHo4SnRXZlJwUlFQUFFD?=
 =?utf-8?B?OStFTzU0NkRBWkhwWDJxRXZiR2dzZ1FtNlBQaG01NDcwcTZXTm9JUlpZdkh3?=
 =?utf-8?B?ZWtmZzFuWVZoSU1aK1dYaUt2ejRsbWhscjB6WjZpMVZPUG5RaTJKVEdRM0VV?=
 =?utf-8?B?aTdCaTJwNGNYcG5aZmw5VTRYVmFjNnRzbjF5K3JGL1VkcmxUY0lKMWJDdVdZ?=
 =?utf-8?B?RFRhOWFJV0czU1JPMldhVERyU2luOVp0cEJGVjZ1QWhGNklHbWU1UjlRaHFK?=
 =?utf-8?B?Z1M3bVlETU5oMkFYZFBFWnhLaFJMbEphbnRlM3BhVCtUdlJGZ01EbzhweTZl?=
 =?utf-8?B?aHAydjZPbTUvMzFEcUxwVWZzTjhYWUVyQ25scTVFaVZ6akdsOUZUVE1oYXFv?=
 =?utf-8?B?VVJHRFI2VU5WN2R3N1UyaXE0WXZubXl6Q0ZmaXJPYkh0RTdvOGl5eHdIaWRw?=
 =?utf-8?B?UEpXN3MxMXVMcGZtYnJBTXRaV0ZBTGlvWDhaQ0NCVDhkRkV5NHNUeWpxYUFM?=
 =?utf-8?B?dTAzT0kyclcyR1p3RkRnYXpOQXJFWHBtNVNJNG4zRXg4eDV4Zmc5SDFlSkxl?=
 =?utf-8?B?MDVhVXptL2grZE4rdW8wMUhKZVNmbVdNRGlhNXdUdWFVLzVaYXA0OE5DWENP?=
 =?utf-8?B?aUZYZjY0KzFBY0VxSVpKR0ZWUkVHbzJibndLbG9ETkxRNkxuUzhDUjZ6RWVk?=
 =?utf-8?B?a3grMit0MG4waGpYbEpjM3lVaElUNWJCMytRUzE1SCtsZlZ5T2dsbnJFVFV5?=
 =?utf-8?B?TllxVERjTzBpUEl4SlE5UzFMNDN1N294K3Ryb2tLZ0FoQlhMdmhOTjk4Y2VW?=
 =?utf-8?B?YitxL05KWUNjWm1IMFYwMy85VEIxcks1YjlWdEQ3MzhtSTAxZW56cVE1WmZF?=
 =?utf-8?B?NlA3NHIvM0lvSkFnMmxtcXE2bzlvSmJGWXIwTklQdzJmSDhkUmpBY0k2cCtK?=
 =?utf-8?B?ZTBKdmkxSWx3L2xIV0lZd24xeGFXVXpDdFBpakttT0g0MFcwNENHb2lsWU1Y?=
 =?utf-8?B?ako1MllrZURqcUlNWVhTOXFjRmMwNTBmRklFOXh1TzJ5OGM2QWZZdmVkVThC?=
 =?utf-8?B?UjltY1pnVUtHUzdEdkRYc2FxZkdKRmQ1WGVibDJUQ0hmYzFzNTRDTlI4RnVB?=
 =?utf-8?B?SW1IcVFqcjRCekJyVS9GL29kMnFkTEV4WW1WbnJuOHllSkJaVHdBeThsWEhF?=
 =?utf-8?B?Vm9PSEdieU5BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3l0am05MVBCMTltMjNLRHYzNWhFclprUlBsVm5TU05uL21wT2tlZUVheHQy?=
 =?utf-8?B?bEI0MnRRSDZ6SUF4QjZkMWNFNTNXbU9MSEVPbzgwNk13ZTIwaU5BcmJkNGp3?=
 =?utf-8?B?T3RiZUhBZzVzRDRodUpEQVl2VHJUeUh6ZTBZRDFIcUYrYXMxbU92bVpQbVZW?=
 =?utf-8?B?bVlkUkVmYkp4bnZpU0g0VWpERFRlY3RjMS9MVjdic0JQcGRvK1BwQXRtZnRG?=
 =?utf-8?B?ZG1MbWI5R2RmOUFQY2c3d1hZdzNTbUZ5eHkrRWRWTXkxSFlJS3FXRjZiYnZH?=
 =?utf-8?B?dTg0MGlpY2lRRkVWaFYwbnVtY0Uzd3lFa3h2SVpaZHVvSldxcDdsbFJXMTBs?=
 =?utf-8?B?cVNsU21iUndLdFdTRWNveG41Q0xzUEhIT3Y1ZmkvS0x2M3VUenVhMlFwNXlU?=
 =?utf-8?B?c01EUjMwcGE1S3llL2dnSmtCZ25SdmNlSUxjOVM5bmtoVm5aSDRnK2xiSlRl?=
 =?utf-8?B?b3VOYXplRUZCcW8xZXRBZEZZdFIwS2NMTmtTV2YxbmdaUEEycTU1OE1UVnBx?=
 =?utf-8?B?NXFWc05MeGRrcnhJaDRZQ0NrOUlEV3FMc0ltRzZIMWt2dVV6RHhpRXpNNldk?=
 =?utf-8?B?Y05XaU11SlZqMmxmcWFlWUZwM3oxbk9VR3RGRXRaVkp0d0NjT3ZoeEZUdEJv?=
 =?utf-8?B?dDZLN3hvQWEvNDBIcjhzcm0wWG5UaHg2TGRDTmFOcXRwTnB2b3YvREdkajV1?=
 =?utf-8?B?TXIzMVh0Q1I3NzJQL2wwR3diSlJJUzJqUFd6OVpnZTdzQzJWV0FvSDZZYlFk?=
 =?utf-8?B?K09PR20yM2h4Q2hLOC9Kd3ZPOWhCalNJSWYxUUZxQktFdkh6eGZhZFBpSHZi?=
 =?utf-8?B?LzB1K0w4QmlqbEFoMjNYLzlCRFovV1V2Zys3Y1hEQjFSa0FPRWJjZXFuTzVo?=
 =?utf-8?B?Q2tzVldOeGttSnNXZUw3SnIzM01TMjJLRXFKY3NuYlFzNFlCVFNGbEEyYUNW?=
 =?utf-8?B?aVNLSzBlU2RKQmFvWnNPYTYzQkFFa1hEcDR1Tm5UdGtNQXpVdmcxMDZQekFm?=
 =?utf-8?B?Vks4Vmh3cEYzYlB0VHRVYTZzMWZCS2lFNGcxTU9DY2lmeGh0dFd5TEpXTmVK?=
 =?utf-8?B?U3hGQmZicDVBa3gydURrVkJKa0svNmN3MzRBMnovTXFPMWg5VDEyYU5HNWUr?=
 =?utf-8?B?ZkFiSEkxejJWc2t2LzBZZlNHK0xnQ1Bqb1FOREM4NGpnZjRQSUNZcFZMaDQz?=
 =?utf-8?B?VDdCcE04aXBRbnNqajNtUStPTXJWampCWkxFTUVjVVdHcEU2Z2g3R1c4NEFy?=
 =?utf-8?B?RDdpeTNFR0JNWFhYVmgxZHhwNERxeHJCMWJ1aktPZFBOZFMwWllqcHg2dDNN?=
 =?utf-8?B?MGlHTnNSMytkb052UVBGbTVwcmxoNzFSSUtOaTdWNjc3VTNLY2dRMlpndEgx?=
 =?utf-8?B?eDgyQnNJZXZZSVFtM1Y5cTB2dHdSRGJMV0pwWExnbkRVRlJIWkFSU1JIdzJt?=
 =?utf-8?B?ZS91R242aDdiWWNFdW1MRHkxUUpFcFNjbWY1NFBzRGZVZEt5TGVXU0wyd3VY?=
 =?utf-8?B?c1pxZGhVSTVoRFRRUFE0QmNvSjQwSDVSTTVFcEtPVnI5RmV3U1RQSTlYV0N4?=
 =?utf-8?B?UmtCbWZGNzd3dnJkSXNOS0MyUzkrQm5BWlUrK29peWFPNEFCdFRrenhKeGJt?=
 =?utf-8?B?S0dodE1qd3V5enJZWE9FMWx6elBVeklIQlpwREc3anl1YjlDYm95WXpNejhC?=
 =?utf-8?B?amMxcy9DZ2ZtTTAwVWEyY0lCeWNmMjgxN1JIb3ZRb012czFMV1FobHpPQ0Q3?=
 =?utf-8?B?dWZFdHRGQXYzbyt0WFNlWjhEQzA1SlYwTUN6REFTb0w4V1pRdjlIcDFIakVU?=
 =?utf-8?B?dWFReS9JbU1KMnNtUHJvejR5dDlibEwxY3c3dWhrWXZyQ0lTMzcwUVBpdTM4?=
 =?utf-8?B?OGo5SngzRDErYmQ1aHp1RVFTazgyYlB3TTdUUndBbFJnM2wzUmhtclR6NXlX?=
 =?utf-8?B?MVg4MDhCVmtOZ000dW5GZDc3VTkyS1hlRWw2cTUydUVOaXk5OUVFWW1kSUk3?=
 =?utf-8?B?RlBFM3BjQ0xRcWh6ZkNZeitLcGUrUGhoL0Nkd0NqQkFkSGQ5dFBQTTBiWGYv?=
 =?utf-8?B?aGJsUnd6N01RR0Q4SDMvMnhtTi9wZDUwcVFhWjdIeTVPOXdDTXlaLzBBYit6?=
 =?utf-8?B?YTlsZVVnTHh3RDYzVWlGTmI0M0N4MFNuTFFCOWVnbE50aDdYUHQ3OE5DdXEr?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d12af5ac-f6dc-404b-0903-08ddcbcfa6cb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 23:04:47.4598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jMghOlKNZTUCi/SBeNTUWxO0KHVTCW/ylqKvyQzzbBZEA8TBK7BVwLW4gR84wPuKVebFG4hmoxwdXBHBrpkU3oNqqDv5TyVaN/lsKcze3BM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5192
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl code for registers discovery and mapping regarding cxl component
> regs and validate registers found are as expected.
> 
> Set media ready explicitly as there is no means for doing so without
> a mailbox, and without the related cxl register, not mandatory for type2.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Looks good, thanks for the changes here to move all the validation to
sfc.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

