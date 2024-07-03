Return-Path: <netdev+bounces-108821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B66925BEA
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 13:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8521F22A12
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 11:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E9C18EFD2;
	Wed,  3 Jul 2024 11:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nT+J72M9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1720E6E5ED;
	Wed,  3 Jul 2024 11:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720004410; cv=fail; b=Xt0wSa07yz2UXBPPnKZIE1tX3oAfDOAG+wCE/PHqgnqhwws75ik8w8aUPvSRrn2BSVWeRk9wfD1Kkzqw4Fl67rXIrT+FUK2BhG7QgotCSHNgn3RC3kQfjYXy/bTztj1iDkwNC+NdYvWptM7TGWFp7K8iaC4RNFEZQlErH4pQGDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720004410; c=relaxed/simple;
	bh=dD1gmdKnl6oFUxpLRUg2FJj25OBSchMHCISBZ+s5z6Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d2zuKGh3f4VlDpJbsdDGSIwwmPc/Z9b81DbIlhmQCW6+onE+DzxNWKJZ5Y45K0Y37lCaakJrYJsG5E9yyJz8KRMSdlKZOKFgxk0le6AvIj17ITxsl3nTuZxbhZ8t/lXUIgZO3JYRB6dgvDA7shGNCL5RJxF4qCpxH9gMphpoxLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nT+J72M9; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720004409; x=1751540409;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dD1gmdKnl6oFUxpLRUg2FJj25OBSchMHCISBZ+s5z6Y=;
  b=nT+J72M9J/dt58pufW2qaszNYZ51ntkJS1vmHctem8QTZhEsibHxMiTR
   0Be5scmgpuSfIZS4+XdPYiB7HbejsF6k6tPztutu8rrzsjinpzUO3TdJk
   E+sEO9HKjcuvHWXHzG5E2USFNMSBmp1RDlgeHM7fvHeaVZ/xyBe4uO5FH
   Cb1DJwhJZkzUeJu9MDaiubXsNydLtC5jTbcR7kl4x1bitUPaFT3tK+s0k
   Y7WC0Z3TgWLe+Jvy+2h5qk9WxdBA/10Ppv+7GSjZNwp7t8m9HkxTsMKro
   zVUatuusI3MKI+bjpEtzsddiPOS0cLuFK5JBZGf3h0Nx0xPLAaImEwEQF
   g==;
X-CSE-ConnectionGUID: YsjtJVu7SKGA4956CWF/EQ==
X-CSE-MsgGUID: 3s7PB7ZHT2mCxGV/p6OIXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17359629"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="17359629"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 04:00:07 -0700
X-CSE-ConnectionGUID: qMJU7a5ASje5uEXRP/bczw==
X-CSE-MsgGUID: KnI5ZEU4RNmEcBDchn65Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="46231082"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 04:00:05 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 04:00:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 04:00:05 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 04:00:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzaXXipQPoli7WECjWTAR6KUaNgM3ZklD0KL68IJrMEmsS/eyC5qShgs+acXQIYGsnuim6zjxHQB1u39VIYO+PxDNCIrK7N5Sh2Bqacw5gbbynwELSr581kyqsggpowRdCHW3LiHUxweTp/LjYMus2OQU6jWUUwKkT/EYgL3bsyXH8drKKHhUstE1REkMnHrUk/asKoBXqj7mLU9rNXjtqzf97Xf+GB3BkvE9pJdyICSorfmNVyAhk0NTLFNyTjW33sGvUCgbquwyWp2oPfhxvlieB75A28E3AuXVXbKq9WDS5LmRRqSquMd3lt0XWUUUxjbs5494in85zwSlMz7WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMUD1HgU1/X0JU2sq37z8fNytD7MpVJS1xdRGJTFzSw=;
 b=jxRhUp5AjVGgZjycsuQj0IIM0V8J3h/uJiGEw1qeyiRpt3sCFBUMJfjdPkvDDrEt6IwatKOSaREL+NxeYePp7puyWEBveuM6oDb+PjOo/fJIs27GWx56nKyfZ2TWpMKo2p/2GMn5RsaRHKYYTclQo7Ouoi6M4aqbwtWDZ1Yoyld5JBxakysJvwrhw3q1fJGkjyEblYIQC7zIGfczbjUVm3zpqvHggl+NxJnd/JFtY4dif+3OXLSTkTkxo5jqln8XKGSnK9wzbzARj6C+WGQ7UQL7gipoQvo+SmByHCfmoQl+Pd2KbJzmx4nEe1YLBFhv7MTXSYLMAccU9CbzkiDqkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CH3PR11MB8441.namprd11.prod.outlook.com (2603:10b6:610:1bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34; Wed, 3 Jul
 2024 11:00:02 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 11:00:02 +0000
Message-ID: <b501f628-695a-488e-8581-fa28f4c20923@intel.com>
Date: Wed, 3 Jul 2024 12:59:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/9] net/sched: flower: define new tunnel flags
To: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
CC: <netdev@vger.kernel.org>, Davide Caratti <dcaratti@redhat.com>, "Ilya
 Maximets" <i.maximets@ovn.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong
 Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern
	<dsahern@kernel.org>, Simon Horman <horms@kernel.org>, Ratheesh Kannoth
	<rkannoth@marvell.com>, Florian Westphal <fw@strlen.de>,
	<linux-kernel@vger.kernel.org>
References: <20240703104600.455125-1-ast@fiberby.net>
 <20240703104600.455125-2-ast@fiberby.net>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240703104600.455125-2-ast@fiberby.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0105.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::20) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CH3PR11MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: 9be7002f-9321-4874-90ef-08dc9b4f49e9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEhUL1Y1V1NYbVVaR2tRV29ObWRXZ1dGcDkyNlZ6SGlDVjVST0tuYVVrOE5v?=
 =?utf-8?B?SHBvNjhNbGNiSk5KbVROejUyMFNsekhoOVk5SERBQ2tzajZYMGRvOHZJMjlT?=
 =?utf-8?B?SGNwclV3ZXB3bjEvajUvVTNzK0ZqZnRkb3cxZUpnOEhtRVM4NU9xZ2w4NTc5?=
 =?utf-8?B?cmpVbyt2N2pDa0JmZ1gzMEIrNWY2TUV6dENHSWUyRU95RjFSMjAyd2FlMVEv?=
 =?utf-8?B?WE1leUdxd0lDUUJBNEpzNTJOMmV0MFFjcnVPZ1BwWXhpMkRwTnlabnFLNVlU?=
 =?utf-8?B?U00zSmtrU3kxZzJMaWU2QlFKb3ZGL2ROUG1VKzlDSEdIOGpXVmRkdDgzODdr?=
 =?utf-8?B?dkZ3VWtZSUZNSmJaSkxscis4Q1dWQWJvaDBpclIrK0ZNTEVJRmQyYVowSDZP?=
 =?utf-8?B?OFMzN1pDWXplRFIrTmdaQUx1YXZITWZqVm5pbWlaaDRVL29yWGhnbTE2U1VE?=
 =?utf-8?B?aXhNYXJndmdmMWdmdXl5NlBnVVo4U3o4SUgrTVcramU0eWR3QVNtVm1iRnRY?=
 =?utf-8?B?enM3ZkFia09ENzRrSHBHcldseW56NGFiS3Bld0NmYUNSaFlmMVBkQmY0d1ZH?=
 =?utf-8?B?cUlDbFg2a0c4MUIwMTlsRHF0WlAzLzRiM21DUzhXa0g2VkFMR3IwOC9zUml1?=
 =?utf-8?B?N2pudHdEVFVrVVNsVThFa3pQbzE4VUVFU0RpTzczUmtZY2N0UkpxTElxRDhp?=
 =?utf-8?B?MDZWeVg2WHVLM3dlMkpNbnZvMDdDZExQRjAvbGg4a1dGUytWR3dzaVNydUth?=
 =?utf-8?B?eFAwODJHNGdOSmxyWVVNZU5XNW5YUGlwT3ptNHlGNEtmZ3EvWXNPRFVFRVpE?=
 =?utf-8?B?aWZHZGw0cFE1V1RjWUlYNGJxZlcwOGpjMnN0Mm1VSW45dFZBUyszb0twTkVF?=
 =?utf-8?B?clJpcENhMHBJVHdSbGU2TjFGVUJRbVo3bHNTdVY3U01pbHlVK09JUGVIeG95?=
 =?utf-8?B?Nm5CNjdRNnc3V3N1d29ndjlJNjVMS3laQTRmbUlzMVNLaHRNSEZjRkFJSk4x?=
 =?utf-8?B?dGZVTCtYQmc3ejFtTElDVXA3Z3cvTy9rOHBhRzRRZ0dFZ2UyaXYxbEp2VjJK?=
 =?utf-8?B?eG92ckNQTDZLdTNwcUVyQzlQUFNIM1BRZlpTMkFINU5JRFVWVVVwVVpKL3FQ?=
 =?utf-8?B?YVVQenB3YzJXQk4vRGhUNGNFRHE4TEhXcEJuNmFTRHh0UUtVcjNSc0d5SGdv?=
 =?utf-8?B?MlFwZlUvaWJuUCswaVI1SFQyYXV6cUVhRTJIa0EvbVFLWWF4M3REN3JtN1Vk?=
 =?utf-8?B?Tnh1Y3RpVTJBWDRWdnFzSkg4d0laRHBJZzBBZThpNStZQmZWd0xWbGlMWWJJ?=
 =?utf-8?B?WE1kSElMN0x5eHl0Nk04ZGFET2NibTM3SE5iTnoram1lL1pDUWxsUGJyY1dD?=
 =?utf-8?B?T2loYXZUTjFrYWlNamdqVS9BUTBiQ05PRCtwTEg1WTQzSHZlN0J3UnNHNEJt?=
 =?utf-8?B?U1hSZ1ZWNVdEeXJPcEFFMWJDcDJZR1M0ak5nZmswVTRqMGZNb2t1VFhnelF3?=
 =?utf-8?B?Zk9ha0w1eFRmcjdncVZEbXMvSTJWSGQzajc2YlF4L3FNL01RMjJiYnI0RTNJ?=
 =?utf-8?B?L1lmMmRVZnU2a0dTaDlhZi85NGtLU05XdEJyNUlOamkrN09aYTRvckFacnRB?=
 =?utf-8?B?dXZDczZnRTRqMHk1dlBUN0VNL0dJazFUOFQvNE1YaUkxU0ZQekpWZ3dCckJa?=
 =?utf-8?B?L2x6RkFheEs4RkcvYU5PVy90aFpHbS9YZS9uRTJ5c21LZnNDYUpUdndmaWRh?=
 =?utf-8?B?ekNDd1RmUEZNR0l0cVpIOUt0eGlaL2tKcFhXYlJLRGxrb1VvSFRNU0ZMUUdZ?=
 =?utf-8?B?eEdRaEZuNmMzWEZSMGtSQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzhxeS9UYVpLcThRRFM0eHowWnMxOTdNOW1QY0hqQkVyYjQwR1NWV3NzdHp6?=
 =?utf-8?B?Ync4cVRocE9XMlgybFRCaWFnNldpbUVEN3VLQnEzckg3M0IwZCtGc2xhQ2ZS?=
 =?utf-8?B?R3hrNmtOVC9FYzN1TUFoaUJ0ZWxRQXpPWXluSFFyVFVsS3FBa0Z4K0hpUng2?=
 =?utf-8?B?NzhTbjRSTE1DUWVYOWYwZ3ZobXJmZ2FDc3hIbFA4SlNWL3pHSkFObFA0Z0tS?=
 =?utf-8?B?MGw4ZWphdmxpU3dZZHdKUFVmVDY5TDl5Vyt4TThoc09tRm9nTElUcUpNdEQ2?=
 =?utf-8?B?OThaWmJoNy95eDBib3VIZEMwYm5RRktzb244QmxybWxsQWtCbzNLQkltTXdr?=
 =?utf-8?B?RWFQb0tUWFZYbEN3dEZyYVhHQ2hpSWxSOGVQVlcyekJRZkp2OWpxN1kyeU1M?=
 =?utf-8?B?bVJGZ0lweTJUNmhNaU45UEhvbEh1NGxqN09MTld1OTlsYlVQN2xUcFFRWkkr?=
 =?utf-8?B?OXdYRmVHWDVUNkNhVUQ4bnJHbHRkQTdubWxUNjBqUi8wZmxSclpJaStkeHd3?=
 =?utf-8?B?N1JFY2pHNEVLSE9uMElPMGIwVmdaOXpEMWFBRTVoUThGNmdRTW1LMFBWL0hp?=
 =?utf-8?B?QnRKZkcwanFNSUkzVFc1Yk5oTE1OQldpbndrUTFaNDR6ejBNRDVqaFl1WUhp?=
 =?utf-8?B?R25SQXZmK0xMb0Zhek1aWnFBWmFGK1JYeCtDVVJGTFdKZm82bEJsM1lTRXU1?=
 =?utf-8?B?bmlnd3pBQmVpZGhMOXo5bEpLN2xrOWltYVQ0d2tRK1RFQXdURnArMjBaQlpz?=
 =?utf-8?B?TlhmU1lEWWpsaEoraUxXZ3BLUUFSYUxtVVgvcUNONjg4V3NYT1UxYS9QTG5u?=
 =?utf-8?B?KzFjc0k0V1cyRFBMY2ZtdW1nV2dwZS8zeDhVZ1N4cFN3Uzd3eVJaODQzeHoz?=
 =?utf-8?B?TUliMVVtQlZnOXY2Y2dyN01rUDE1NlJQNjA1NFM1WWI4YmhYMTJpOVJrZi9N?=
 =?utf-8?B?am00aDVialVXSi9Va2dWckxITnJqUUFua0llVFQ0b3NadlppTk5PajRCVlFL?=
 =?utf-8?B?aUYwbkUvZExEemFueTBIK0MrR3k0V0ZUM3RQQWlrUEhPSytZQmtmbzZaMkFB?=
 =?utf-8?B?YUhlNUxnMTRUaENvQTliMEdkVE5NYkFmUE0zVWNHbFNEdmFQSGVrVG1SR3Nq?=
 =?utf-8?B?blNzSjBmYVFlQndhODkzTTc1Tlo0UE5WVkI0ZkdUVFlrTjdvQk11RnluMDRw?=
 =?utf-8?B?cUx5M1pQMzJMOUFQeUhicFBTcjBtT1RhU3NPOW0zYTRzY0tZWUtKTGl5Q1p1?=
 =?utf-8?B?MUxPYWlGTFZ5K0xUbWFOWS9rVFg3TjJHV2RpYkVxK0VXZ2Fhc0xmb3Jvajla?=
 =?utf-8?B?VWcyQ0VTeXZwOWg1TUVOYmp3Q09JT1d5RzdzdHVCd2x6MnoxNzRZREg1bDlW?=
 =?utf-8?B?ZGRJdWt5dXFRU1hRZFN0RkVHMkptdHE5Ky9GVkhHd29pWkZ0MEtrM1kzUm1k?=
 =?utf-8?B?VXBWOXBwaGVaZ2w0WmlOeXRvWjVkMmtRMFZwKzdYOVVhVkduUFBvejI3Q0Vi?=
 =?utf-8?B?cmVzRlZIODVUU052WXlFZmpGRmRJTytYcWJYMk1SWkxSR2lpb3NjSEVMaU1V?=
 =?utf-8?B?ckZKSERIVkpjNnVEa2ZwRUhsaXB6a3d4ZkNsRFNaSi9zT1RNMWhGUzJhOTYv?=
 =?utf-8?B?YlBkcnI0TkM3R00xK2szOGYwaVMzM1ZQblgrYkJDaGIwMUpqSlUvM0wvWGZi?=
 =?utf-8?B?ZURkTUxzd2FaMUE4R2ZwMjVqdDNGZ0NCSzJrQ1BuanV0eVpMSWxmMGtLZEVS?=
 =?utf-8?B?eCtVK0tZL0JyMlQ0MVpJWm01dXMyM21MajZZT2hYMlAzcnpyNitVd2Y5bk5u?=
 =?utf-8?B?N1MxcjdnVS9hRWxhNXZFRERIN2Via1dSak5TNlBzUEI3cG5aeGNMRWRvR3kw?=
 =?utf-8?B?QWxPbzlqUGthaThUd1ZQK0VzelFQTWxZQUJxemYxWFp3dUxIalNpeFhTek14?=
 =?utf-8?B?VDFvc055eXBaNGV1RmhWQ04zUTBTdXZVdDR6bjhvRFZWNzl4ZHBBcFV1MTd0?=
 =?utf-8?B?MkQ5ejdrMEZYenV1ZlFBUytGaEtlNEhBVWZaWk9YRVQyT3J5Qnd6a0dFV3lD?=
 =?utf-8?B?SUlqTzY2OHF1bkloQXA2QzdPQUJBamg0Zi8yT2NFd0JpL1kveS8ySkNVWWpT?=
 =?utf-8?B?VG5WUGQxbUkrMlkybUlLNUdESlkzSm5VUDVwZTBOT3Z5a3ZFMVU5ZTRoa0dO?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be7002f-9321-4874-90ef-08dc9b4f49e9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 11:00:02.5439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JbjsmGnYpCxm8oYeIDtgx0RjO8JL+gkAqr04ra6LHXWw3CueDszqLUii7KO04E4lj8zza/xptSlGiNfp71IcZa0HgNDca/ZzrLoZND573pM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8441
X-OriginatorOrg: intel.com

From: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Date: Wed,  3 Jul 2024 10:45:50 +0000

> Define new TCA_FLOWER_KEY_FLAGS_* flags for use in struct
> flow_dissector_key_control, covering the same flags
> as currently exposed through TCA_FLOWER_KEY_ENC_FLAGS,
> but assign them new bit positions in so that they don't
> conflict with existing TCA_FLOWER_KEY_FLAGS_* flags.
> 
> Synchronize FLOW_DIS_* flags, but put the new flags
> under FLOW_DIS_F_*. The idea is that we can later, move
> the existing flags under FLOW_DIS_F_* as well.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> ---
>  include/net/flow_dissector.h | 17 +++++++++++++----
>  include/uapi/linux/pkt_cls.h |  5 +++++
>  2 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
> index 3e47e123934d..f560e2c8d0e7 100644
> --- a/include/net/flow_dissector.h
> +++ b/include/net/flow_dissector.h
> @@ -16,7 +16,8 @@ struct sk_buff;
>   * struct flow_dissector_key_control:
>   * @thoff:     Transport header offset
>   * @addr_type: Type of key. One of FLOW_DISSECTOR_KEY_*
> - * @flags:     Key flags. Any of FLOW_DIS_(IS_FRAGMENT|FIRST_FRAGENCAPSULATION)
> + * @flags:     Key flags.
> + *             Any of FLOW_DIS_(IS_FRAGMENT|FIRST_FRAG|ENCAPSULATION|F_*)
>   */
>  struct flow_dissector_key_control {
>  	u16	thoff;
> @@ -24,9 +25,17 @@ struct flow_dissector_key_control {
>  	u32	flags;
>  };
>  
> -#define FLOW_DIS_IS_FRAGMENT	BIT(0)
> -#define FLOW_DIS_FIRST_FRAG	BIT(1)
> -#define FLOW_DIS_ENCAPSULATION	BIT(2)
> +/* Please keep these flags in sync with TCA_FLOWER_KEY_FLAGS_*
> + * in include/uapi/linux/pkt_cls.h, as these bit flags are exposed
> + * to userspace in some error paths, ie. unsupported flags.
> + */
> +#define FLOW_DIS_IS_FRAGMENT		BIT(0)
> +#define FLOW_DIS_FIRST_FRAG		BIT(1)
> +#define FLOW_DIS_ENCAPSULATION		BIT(2)
> +#define FLOW_DIS_F_TUNNEL_CSUM		BIT(3)
> +#define FLOW_DIS_F_TUNNEL_DONT_FRAGMENT	BIT(4)
> +#define FLOW_DIS_F_TUNNEL_OAM		BIT(5)
> +#define FLOW_DIS_F_TUNNEL_CRIT_OPT	BIT(6)

1. enum? Then they will be included in BTF info, maybe they might come
   handy later in BPF...
2. Maybe "sync" them automatically?

	FLOW_DIS_FIRST_FRAG	= TCA_FLOWER_KEY_FLAGS_FRAG_IS_FIRST,
	...

(with the only exception for BIT(2))

>  
>  enum flow_dissect_ret {
>  	FLOW_DISSECT_RET_OUT_GOOD,
> diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
> index b6d38f5fd7c0..24795aad7651 100644
> --- a/include/uapi/linux/pkt_cls.h
> +++ b/include/uapi/linux/pkt_cls.h
> @@ -677,6 +677,11 @@ enum {
>  enum {
>  	TCA_FLOWER_KEY_FLAGS_IS_FRAGMENT = (1 << 0),
>  	TCA_FLOWER_KEY_FLAGS_FRAG_IS_FIRST = (1 << 1),
> +	/* FLOW_DIS_ENCAPSULATION (1 << 2) is not exposed to userspace */

Should uAPI header contain this comment? FLOW_DIS_ENCAPSULATION is an
internal kernel definition, so I believe its name shouldn't leak to the
userspace header.

> +	TCA_FLOWER_KEY_FLAGS_TUNNEL_CSUM = (1 << 3),
> +	TCA_FLOWER_KEY_FLAGS_TUNNEL_DONT_FRAGMENT = (1 << 4),
> +	TCA_FLOWER_KEY_FLAGS_TUNNEL_OAM = (1 << 5),
> +	TCA_FLOWER_KEY_FLAGS_TUNNEL_CRIT_OPT = (1 << 6),
>  };
>  
>  enum {

Thanks,
Olek

