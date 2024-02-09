Return-Path: <netdev+bounces-70605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D5284FC1C
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 19:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C4441C20F08
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 18:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D667A7EF01;
	Fri,  9 Feb 2024 18:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A8e0LOEh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D00D12BF08
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 18:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707503898; cv=fail; b=rWqd/AiXnwEUl4qq2VtD6zXMyCL2kQb8cjiV8qYNdcnpZR3nfjP/llF6kcmzslErdTc8ckRit1B+MDrW6zdrFyRaJj6+76L3L3ylY4wsFg4N8LiXelPjEyud9jZAy8FgojzKWaY0lOzONIoVEnyE8eOrY8dMJymBflTFbKb2MTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707503898; c=relaxed/simple;
	bh=ueae+je+AvHEG6BADMMvpTJpDkknJA5E+RhEs3Z/YvA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CxuKZClIZAFxgXEhLP+fwRgX6ZS8eVWf9wSjbnxbAPBpvcUs7oF5gap9mU8XCFLrE3lVQjE20EY+Sn9u7G6qgPzKUyY0Qa25YR1dxBofWawc5c8bFeY/2vibN0fgjSerVZCv0fR5Z9wugnTH1/Pq2a3M6m36oVqesxPMn/wBayM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A8e0LOEh; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707503896; x=1739039896;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ueae+je+AvHEG6BADMMvpTJpDkknJA5E+RhEs3Z/YvA=;
  b=A8e0LOEhBY8N4OxyHvUKBYNprwxYAR4FmWe4IaxiUblAQ/yZSvJZPuYN
   FZ38K1kOOcnU+00HdNk7RL/Vc53bh4xyEmzY05d3xaRsbBkVsWgD+tAM/
   JBAPB1osxracy67v5GLcNS/xNLsBBj5MwCK+nIDouEf2t1POdq8tg1OwK
   NHrDCs3NLG5SRFoJ/yQa2uJp3t5CNia51J4O/f3PO5ZCKE+vk1z5N4lkv
   bhuSIqBsFKMifIKcFrO9TGpV7Mzdm5w5a1r1XkOzJEA9eawX7zo4xPTGD
   UlbTJhtqLgDr0f/HRdLptHB8z6jHcgEfSY8Ed6+pUEkezvGau0B+40zfB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1377300"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1377300"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 10:38:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="6649155"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Feb 2024 10:38:15 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 10:38:15 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 10:38:14 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 10:38:14 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 10:38:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCcr+mEs0iKeP6UGg+N9Ht5dW/vrDbFmWc1dt2Sf5P5pUnFMMYAdyJ59k7eYxISShQVrmBc9HXRhDszYlkWG5e9M87JgKDRJ0C7QbWdtaF39Yz78oiQa6Og8xLWumCa2XP1AySiFxHqC69gDKs+taagBfTQ/m5DIm3Deyh/mqstXlWxY+KGYiDEzwniWynXoXhcOFO/Bt3RM2XRRd7K+ib4XyNmpSggOqY3TQQ8DpyhqVcbGWPRsuglMbKxzIHUyV4kTemrxSodp4fg+t/X0H3ENXVEA7JV+HO3wizqdwiVASm1YW9qAnGIOp81H+JnaG/Cjqw8+lyL2dDAjMaRlBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtAUDnak89OZBX9SPbRHRCrQaukl8S5bgoiT+FLkjD4=;
 b=c+8c7Ov1w3bftA5ph279nkapdHHBArJpKncsnPzOpwChliDqqiJAjoTEtHzGr0jDsJFqU91SSMAStFXGT62zoNc2RisY/miFcof8aaC+u3f+FPtaOdcX7SzvhP9iUe4RyOhaL8RoUZoN60n6CXQKnBaG70BcvAlY8PGXFZNC2RoP57YaKPrbiknGTIrKJliGtRvQqG9eR47c00ezs6bNlQy7Z1687nSZxLKT/NlnbkosjA84fLS/Bom+HYhxpoAG27UuoIpiZ8OZ1ZfWh/ga4GEJy/rlUpfDc6hArYz/fT3VsGwIU29RbzYB+M5907iL7bKmVI8D7ZE7QZm4bhhD6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Fri, 9 Feb
 2024 18:38:06 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47%6]) with mapi id 15.20.7249.035; Fri, 9 Feb 2024
 18:38:06 +0000
Date: Fri, 9 Feb 2024 19:37:56 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Pavel Vazharov <pavel@x3me.net>
CC: Magnus Karlsson <magnus.karlsson@gmail.com>, Toke
 =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>
Subject: Re: Need of advice for XDP sockets on top of the interfaces behind a
 Linux bonding device
Message-ID: <ZcZxBK0b21uIw3k6@boxer>
References: <CAJEV1igHVsqmk0ctxb-9gM2+PLs_gvpE1fyZwoASgv+jYXOcmg@mail.gmail.com>
 <87wmrqzyc9.fsf@toke.dk>
 <CAJEV1ig2Gyqb2MPHU+qN_G7XDVNZffU5HDm5VkoGev_QOe7bXg@mail.gmail.com>
 <87r0hyzxbd.fsf@toke.dk>
 <CAJ8uoz0bZjeJKJbCOfaogJZg2o5zoWNf3XjAF-4ZubpxDoQhcg@mail.gmail.com>
 <CAJEV1ihnwDxkkeMtAkkkZpP5O-VMxVvJojLs6dMbeMYgsn7sGA@mail.gmail.com>
 <ZcPTNpzGyqQI+DXw@boxer>
 <CAJEV1ihMuP6Oq+=ubd05DReBXuLwmZLYFwO=ha2C995wBuWeLA@mail.gmail.com>
 <CAJEV1igugU1SjcWnjYgoG0x_stExm0MyxwdFN0xycSb9sadkXw@mail.gmail.com>
 <CAJEV1ijnUrJXOuGW5xnuCvMTtaC1VKhOXQ0_4iJnqR5Vco4yLg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJEV1ijnUrJXOuGW5xnuCvMTtaC1VKhOXQ0_4iJnqR5Vco4yLg@mail.gmail.com>
X-ClientProxiedBy: DU2PR04CA0155.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::10) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|BL1PR11MB5271:EE_
X-MS-Office365-Filtering-Correlation-Id: 74987309-f408-4535-4aa5-08dc299e41cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vv5ReM7Jxl6MlIVgZUISt6uwLEO12B3MD4Cr936aKuS6gGs3Xr58EYEdiBs2QsIcL8DckXL/e/nd//5ttKPtezujge4UZsFXH5IXVccbZ0OgLMPb1VTno7YmupV3FE5ORoiFNDP4SnWEXVASsZgT0vjx1F7Q4DuMC96arDP1plVKJl7iJYvPCGKVe+c0Twym0cfV2uc53OsDnNi7fnQbJn+BduN2kQrNVXOdqz5gSr/FJ9Isiy00KmQbTOrd7CT6pUp0cGvAuT9J/hG81GeuC0to7g/uir0UVbjLiGjqCoTmdRyMCmMmPG8kEoBxFZi1kmL+kkpUvACz2Usdsauw2cK98dVrWcPL67YjBTmD9CoLcHV2lGa2aMgDg6kyU9tMzrS7mlm1XuAJXZP37e/ReSOb1qNx4Y0s6fARa21hKtJjKyz3B2mr5lt/VqoYAzRO4h1LMxzEE2V9wNfIAiYSPJlIj+PPK9GDLByKjlNxEDJKCoQln+16V1teuX57auhl4uBcmMgOPohU0PLhg3iTGkaPkv7JermOYa4il2qW8mbq6ik3ulGafwITUZXh/D7K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(136003)(39860400002)(366004)(396003)(230922051799003)(230273577357003)(64100799003)(186009)(1800799012)(451199024)(6666004)(33716001)(2906002)(19627235002)(54906003)(44832011)(30864003)(5660300002)(316002)(41300700001)(66946007)(66556008)(66476007)(6486002)(478600001)(6512007)(6506007)(8676002)(53546011)(4326008)(8936002)(6916009)(9686003)(66574015)(38100700002)(82960400001)(86362001)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzNiVXYzcElVZHo5S3lJSWhQR09Fcnd0cHIzTDBQZzNWd0QvMGRBSHU1dmVE?=
 =?utf-8?B?TnRub3dWVjdpc2l2OXhCTHJQVzlqOUx2V3pBeExpdzk0WXRrblRjeG9sL3BQ?=
 =?utf-8?B?aHBIN0tTSm9qMHFSbTBxTWFYelRmOG9CUUhzVThWbXBpN1NNd0d2QnI1aE9z?=
 =?utf-8?B?WU9kelZrU3RsMjdJM2xDVE40alo5WEtqV2tKQk5mL2ZpaUh5TWdza1EreXpW?=
 =?utf-8?B?RUdiZ3JEMmZBaWJCRWRSaS9CbzJnOGlvaWJTQXFobkZjU2FUWk1kSmprbWtj?=
 =?utf-8?B?TmxWVC9yYW03UHEvbm1adkNPbFVQVi9nRlVpKytpaWdUS0R6MGxOZ0NNSjBW?=
 =?utf-8?B?OXhRTVJKNlBNUzR3SVRJa2NpeFgvUTlnNHNJVitOYXI2bnBIclhzWE1XellM?=
 =?utf-8?B?RlpsaTVJMDViQll1Q09ZUDNncm9DMUpRNGVrbGkvL1dDWDV0Z2Q3bU15OUJS?=
 =?utf-8?B?TExHeEtYL2FPUHBNTFBPYzliM3dFTGVobTJFSVpPZExzUnk5RXNpTmthbEdJ?=
 =?utf-8?B?ZmU0YS80U1VFQUNlZCtUR2NHd3h2S05wbnhjUndLVzNRQ2lMTFlnQnhMd1ZC?=
 =?utf-8?B?RVg2U0RxU1JOejFzK2VEdHBKOG9RZUxOaFZ4b0RzbWZjSVdVdWVtOURqTklQ?=
 =?utf-8?B?TlBoSGhNWmZuWVVqZE9tMktBY2FWL3NnRGtyczVoNmpnbFVGWHRGdHhRTnh5?=
 =?utf-8?B?Qm9UT001bFZwcGhtZC96QXZwaExWUDRrZ1dhaHUwUHlrVGF4RTRKNWIvNWNE?=
 =?utf-8?B?cC82clVrWjVwdFJxMVlFN293emYzNVNBcFkwQlo1RzFWeDBSS0VGb1pZcmhO?=
 =?utf-8?B?VE9JbWRDM01weXNIdmo2UTFBb3JjTENNQUZZaWNkUDhjekprM0pjUWljYS9u?=
 =?utf-8?B?ZUdtSm9xZHRxcFlDTzI3WkxFTlp3a0E0eHRvU1BrNVNFV2ppQ25CYjIwZm9F?=
 =?utf-8?B?YnN6Qi8ydlpOM1dZRklNcmFOOU5SaVdhWUNYY3B6ZXF4VGlzamNFUHd0YURv?=
 =?utf-8?B?YmxtalF5OWwzSGRQS0ZpNkRkUXdZYVBDNFVFS0hpUU5iSHlPMzlkaGlEbE5p?=
 =?utf-8?B?WUl6THZ6RUVoc2txcSt2UnJScnJLYlZmYUwyQ3BVdVpDd3B3S0dkQ1VkUWNC?=
 =?utf-8?B?MmtCajVZZTFDWkkrd0hGREY5V3FmOStXZjlsMlA1ampvNlFZOHQ1R1poK21x?=
 =?utf-8?B?TCt0Yms5ci95dkEwdUZKcnhDOEVTR0ZBQzNhczdxUmJGTmpHUDFHYWhnOEM1?=
 =?utf-8?B?T08wRVhzM1dRdHZ4bU5zZFJiY2xwOEh2dkYzOFcvQmxreUNaQjkxZUY3bmk4?=
 =?utf-8?B?cmhPOEc1OTk5WG1oQ0d5MHloMFRMYTh6Rlk0am9obXBsZkxxVmtSekpodTlk?=
 =?utf-8?B?S0hlaU1aamg5OUYxNWI3MTlBZ3FqbGIzc0ZnL0EyRzhMSG9YZWsvSzBLd01F?=
 =?utf-8?B?V0tGL2QzOXlaRlEwRWhFSXpUeWdMREV2OU4zWTRicEhoc1BKQTJ0dnc5ZCtJ?=
 =?utf-8?B?VlZnT2ozQm1GNmJVNDl1R1NCclk0aDgvVUN2bGVVRGJlWEQ3bDVrRExSUFo1?=
 =?utf-8?B?Zkp6QWNZd1ZBUWlqVWtGNE1ESzRtbm81U05kNEZydExoaHZTQURWYXlaMDYr?=
 =?utf-8?B?U0JDZWdpR01WVjErWm5kYUdEYUFkVFBLRndVSmhoTXVCYXk0K3Y2Z0xUdWN5?=
 =?utf-8?B?L3RuOE1FbVVIN013RmEweUVIUVpOWnBIOHVQdmxCNTFSa2pRY1B0QTg5RHN1?=
 =?utf-8?B?aVltYzZLNHFjK2h3Tkp2M0c1RmZqR2J6TDdKdVlQYUd4SHZ6VEZ5RjBlb0to?=
 =?utf-8?B?cVdCYW9wMmJud3BwZUFRamJnbFpUV1pOQkxKRXlkeFkvdm14eXlGZGlYVVpL?=
 =?utf-8?B?UHF6emg3TTBNRVk4NFYvNkRJLzUycGp4b3NadDJFYWV4Q0E3NllvZUVwQ3Zh?=
 =?utf-8?B?b2l5NFJCYXJ3RC9rM3hkZzdEeS92ZW12OHd1UHYwVXNVS1MxN1VTT2hlWHhY?=
 =?utf-8?B?bzBQQmRFaFRpY2g3aGdhVUtFSTZxOThsQXRRZTNmK3IrcDJEZHE2TmxtdHE3?=
 =?utf-8?B?cUxtVGpvMUN3S0ZrdzFQR0pKeDEwRm5BT29JbTZSK0JzVXRvWTB2bllwZkp6?=
 =?utf-8?B?SktKbkVDbmhRUzREbXM1TFBGa0pGUHF6amcrR2plaERJaUY2MUpwVndXRkVj?=
 =?utf-8?B?Qmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74987309-f408-4535-4aa5-08dc299e41cf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 18:38:06.7749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h58IS4CPQ1cX0WAq8Qdklm6e+u/LXR//UaiqsPQeJngMvyuR/twoO48g45FFmaO5Tk/qJcG5BQn3JtUIT9zNVbKnbFNvNcLsrNV0F7G5Qhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5271
X-OriginatorOrg: intel.com

On Fri, Feb 09, 2024 at 11:03:51AM +0200, Pavel Vazharov wrote:
> On Thu, Feb 8, 2024 at 5:47 PM Pavel Vazharov <pavel@x3me.net> wrote:
> >
> > On Thu, Feb 8, 2024 at 12:59 PM Pavel Vazharov <pavel@x3me.net> wrote:
> > >
> > > On Wed, Feb 7, 2024 at 9:00 PM Maciej Fijalkowski
> > > <maciej.fijalkowski@intel.com> wrote:
> > > >
> > > > On Wed, Feb 07, 2024 at 05:49:47PM +0200, Pavel Vazharov wrote:
> > > > > On Mon, Feb 5, 2024 at 9:07 AM Magnus Karlsson
> > > > > <magnus.karlsson@gmail.com> wrote:
> > > > > >
> > > > > > On Tue, 30 Jan 2024 at 15:54, Toke Høiland-Jørgensen <toke@kernel.org> wrote:
> > > > > > >
> > > > > > > Pavel Vazharov <pavel@x3me.net> writes:
> > > > > > >
> > > > > > > > On Tue, Jan 30, 2024 at 4:32 PM Toke Høiland-Jørgensen <toke@kernel.org> wrote:
> > > > > > > >>
> > > > > > > >> Pavel Vazharov <pavel@x3me.net> writes:
> > > > > > > >>
> > > > > > > >> >> On Sat, Jan 27, 2024 at 7:08 AM Pavel Vazharov <pavel@x3me.net> wrote:
> > > > > > > >> >>>
> > > > > > > >> >>> On Sat, Jan 27, 2024 at 6:39 AM Jakub Kicinski <kuba@kernel.org> wrote:
> > > > > > > >> >>> >
> > > > > > > >> >>> > On Sat, 27 Jan 2024 05:58:55 +0200 Pavel Vazharov wrote:
> > > > > > > >> >>> > > > Well, it will be up to your application to ensure that it is not. The
> > > > > > > >> >>> > > > XDP program will run before the stack sees the LACP management traffic,
> > > > > > > >> >>> > > > so you will have to take some measure to ensure that any such management
> > > > > > > >> >>> > > > traffic gets routed to the stack instead of to the DPDK application. My
> > > > > > > >> >>> > > > immediate guess would be that this is the cause of those warnings?
> > > > > > > >> >>> > >
> > > > > > > >> >>> > > Thank you for the response.
> > > > > > > >> >>> > > I already checked the XDP program.
> > > > > > > >> >>> > > It redirects particular pools of IPv4 (TCP or UDP) traffic to the application.
> > > > > > > >> >>> > > Everything else is passed to the Linux kernel.
> > > > > > > >> >>> > > However, I'll check it again. Just to be sure.
> > > > > > > >> >>> >
> > > > > > > >> >>> > What device driver are you using, if you don't mind sharing?
> > > > > > > >> >>> > The pass thru code path may be much less well tested in AF_XDP
> > > > > > > >> >>> > drivers.
> > > > > > > >> >>> These are the kernel version and the drivers for the 3 ports in the
> > > > > > > >> >>> above bonding.
> > > > > > > >> >>> ~# uname -a
> > > > > > > >> >>> Linux 6.3.2 #1 SMP Wed May 17 08:17:50 UTC 2023 x86_64 GNU/Linux
> > > > > > > >> >>> ~# lspci -v | grep -A 16 -e 1b:00.0 -e 3b:00.0 -e 5e:00.0
> > > > > > > >> >>> 1b:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit
> > > > > > > >> >>> SFI/SFP+ Network Connection (rev 01)
> > > > > > > >> >>>        ...
> > > > > > > >> >>>         Kernel driver in use: ixgbe
> > > > > > > >> >>> --
> > > > > > > >> >>> 3b:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit
> > > > > > > >> >>> SFI/SFP+ Network Connection (rev 01)
> > > > > > > >> >>>         ...
> > > > > > > >> >>>         Kernel driver in use: ixgbe
> > > > > > > >> >>> --
> > > > > > > >> >>> 5e:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit
> > > > > > > >> >>> SFI/SFP+ Network Connection (rev 01)
> > > > > > > >> >>>         ...
> > > > > > > >> >>>         Kernel driver in use: ixgbe
> > > > > > > >> >>>
> > > > > > > >> >>> I think they should be well supported, right?
> > > > > > > >> >>> So far, it seems that the present usage scenario should work and the
> > > > > > > >> >>> problem is somewhere in my code.
> > > > > > > >> >>> I'll double check it again and try to simplify everything in order to
> > > > > > > >> >>> pinpoint the problem.
> > > > > > > >> > I've managed to pinpoint that forcing the copying of the packets
> > > > > > > >> > between the kernel and the user space
> > > > > > > >> > (XDP_COPY) fixes the issue with the malformed LACPDUs and the not
> > > > > > > >> > working bonding.
> > > > > > > >>
> > > > > > > >> (+Magnus)
> > > > > > > >>
> > > > > > > >> Right, okay, that seems to suggest a bug in the internal kernel copying
> > > > > > > >> that happens on XDP_PASS in zero-copy mode. Which would be a driver bug;
> > > > > > > >> any chance you could test with a different driver and see if the same
> > > > > > > >> issue appears there?
> > > > > > > >>
> > > > > > > >> -Toke
> > > > > > > > No, sorry.
> > > > > > > > We have only servers with Intel 82599ES with ixgbe drivers.
> > > > > > > > And one lab machine with Intel 82540EM with igb driver but we can't
> > > > > > > > set up bonding there
> > > > > > > > and the problem is not reproducible there.
> > > > > > >
> > > > > > > Right, okay. Another thing that may be of some use is to try to capture
> > > > > > > the packets on the physical devices using tcpdump. That should (I think)
> > > > > > > show you the LACDPU packets as they come in, before they hit the bonding
> > > > > > > device, but after they are copied from the XDP frame. If it's a packet
> > > > > > > corruption issue, that should be visible in the captured packet; you can
> > > > > > > compare with an xdpdump capture to see if there are any differences...
> > > > > >
> > > > > > Pavel,
> > > > > >
> > > > > > Sounds like an issue with the driver in zero-copy mode as it works
> > > > > > fine in copy mode. Maciej and I will take a look at it.
> > > > > >
> > > > > > > -Toke
> > > > > > >
> > > > >
> > > > > First I want to apologize for not responding for such a long time.
> > > > > I had different tasks the previous week and this week went back to this issue.
> > > > > I had to modify the code of the af_xdp driver inside the DPDK so that it loads
> > > > > the XDP program in a way which is compatible with the xdp-dispatcher.
> > > > > Finally, I was able to run our application with the XDP sockets and the xdpdump
> > > > > at the same time.
> > > > >
> > > > > Back to the issue.
> > > > > I just want to say again that we are not binding the XDP sockets to
> > > > > the bonding device.
> > > > > We are binding the sockets to the queues of the physical interfaces
> > > > > "below" the bonding device.
> > > > > My further observation this time is that when the issue happens and
> > > > > the remote device reports
> > > > > the LACP error there is no incoming LACP traffic on the corresponding
> > > > > local port,
> > > > > as seen by the xdump.
> > > > > The tcpdump at the same time sees only outgoing LACP packets and
> > > > > nothing incoming.
> > > > > For example:
> > > > > Remote device
> > > > >                           Local Server
> > > > > TrunkName=Eth-Trunk20, PortName=XGigabitEthernet0/0/12 <---> eth0
> > > > > TrunkName=Eth-Trunk20, PortName=XGigabitEthernet0/0/13 <---> eth2
> > > > > TrunkName=Eth-Trunk20, PortName=XGigabitEthernet0/0/14 <---> eth4
> > > > > And when the remote device reports "received an abnormal LACPDU"
> > > > > for PortName=XGigabitEthernet0/0/14 I can see via xdpdump that there
> > > > > is no incoming LACP traffic
> > > >
> > > > Hey Pavel,
> > > >
> > > > can you also look at /proc/interrupts at eth4 and what ethtool -S shows
> > > > there?
> > > I reproduced the problem but this time the interface with the weird
> > > state was eth0.
> > > It's different every time and sometimes even two of the interfaces are
> > > in such a state.
> > > Here are the requested info while being in this state:
> > > ~# ethtool -S eth0 > /tmp/stats0.txt ; sleep 10 ; ethtool -S eth0 >
> > > /tmp/stats1.txt ; diff /tmp/stats0.txt /tmp/stats1.txt
> > > 6c6
> > > <      rx_pkts_nic: 81426
> > > ---
> > > >      rx_pkts_nic: 81436
> > > 8c8
> > > <      rx_bytes_nic: 10286521
> > > ---
> > > >      rx_bytes_nic: 10287801
> > > 17c17
> > > <      multicast: 72216
> > > ---
> > > >      multicast: 72226
> > > 48c48
> > > <      rx_no_dma_resources: 1109
> > > ---
> > > >      rx_no_dma_resources: 1119
> > >
> > > ~# cat /proc/interrupts | grep eth0 > /tmp/interrupts0.txt ; sleep 10
> > > ; cat /proc/interrupts | grep eth0 > /tmp/interrupts1.txt
> > > interrupts0: 430 3098 64 108199 108199 108199 108199 108199 108199
> > > 108199 108201 63 64 1865 108199  61
> > > interrupts1: 435 3103 69 117967 117967  117967 117967 117967  117967
> > > 117967 117969 68 69 1870  117967 66
> > >
> > > So, it seems that packets are coming on the interface but they don't
> > > reach to the XDP layer and deeper.
> > > rx_no_dma_resources - this counter seems to give clues about a possible issue?
> > >
> > > >
> > > > > on eth4 but there is incoming LACP traffic on eth0 and eth2.
> > > > > At the same time, according to the dmesg the kernel sees all of the
> > > > > interfaces as
> > > > > "link status definitely up, 10000 Mbps full duplex".
> > > > > The issue goes aways if I stop the application even without removing
> > > > > the XDP programs
> > > > > from the interfaces - the running xdpdump starts showing the incoming
> > > > > LACP traffic immediately.
> > > > > The issue also goes away if I do "ip link set down eth4 && ip link set up eth4".
> > > >
> > > > and the setup is what when doing the link flap? XDP progs are loaded to
> > > > each of the 3 interfaces of bond?
> > > Yes, the same XDP program is loaded on application startup on each one
> > > of the interfaces which are part of bond0 (eth0, eth2, eth4):
> > > # xdp-loader status
> > > CURRENT XDP PROGRAM STATUS:
> > >
> > > Interface        Prio  Program name      Mode     ID   Tag
> > >   Chain actions
> > > --------------------------------------------------------------------------------------
> > > lo                     <No XDP program loaded!>
> > > eth0                   xdp_dispatcher    native   1320 90f686eb86991928
> > >  =>              50     x3sp_splitter_func          1329
> > > 3b185187f1855c4c  XDP_PASS
> > > eth1                   <No XDP program loaded!>
> > > eth2                   xdp_dispatcher    native   1334 90f686eb86991928
> > >  =>              50     x3sp_splitter_func          1337
> > > 3b185187f1855c4c  XDP_PASS
> > > eth3                   <No XDP program loaded!>
> > > eth4                   xdp_dispatcher    native   1342 90f686eb86991928
> > >  =>              50     x3sp_splitter_func          1345
> > > 3b185187f1855c4c  XDP_PASS
> > > eth5                   <No XDP program loaded!>
> > > eth6                   <No XDP program loaded!>
> > > eth7                   <No XDP program loaded!>
> > > bond0                  <No XDP program loaded!>
> > > Each of these interfaces is setup to have 16 queues i.e. the application,
> > > through the DPDK machinery, opens 3x16 XSK sockets each bound to the
> > > corresponding queue of the corresponding interface.
> > > ~# ethtool -l eth0 # It's same for the other 2 devices
> > > Channel parameters for eth0:
> > > Pre-set maximums:
> > > RX:             n/a
> > > TX:             n/a
> > > Other:          1
> > > Combined:       48
> > > Current hardware settings:
> > > RX:             n/a
> > > TX:             n/a
> > > Other:          1
> > > Combined:       16
> > >
> > > >
> > > > > However, I'm not sure what happens with the bound XDP sockets in this case
> > > > > because I haven't tested further.
> > > >
> > > > can you also try to bind xsk sockets before attaching XDP progs?
> > > I looked into the DPDK code again.
> > > The DPDK framework provides callback hooks like eth_rx_queue_setup
> > > and each "driver" implements it as needed. Each Rx/Tx queue of the device is
> > > set up separately. The af_xdp driver currently does this for each Rx
> > > queue separately:
> > > 1. configures the umem for the queue
> > > 2. loads the XDP program on the corresponding interface, if not already loaded
> > >    (i.e. this happens only once per interface when its first queue is set up).
> > > 3. does xsk_socket__create which as far as I looked also internally binds the
> > > socket to the given queue
> > > 4. places the socket in the XSKS map of the XDP program via bpf_map_update_elem
> > >
> > > So, it seems to me that the change needed will be a bit more involved.
> > > I'm not sure if it'll be possible to hardcode, just for the test, the
> > > program loading and
> > > the placing of all XSK sockets in the map to happen when the setup of the last
> > > "queue" for the given interface is done. I need to think a bit more about this.
> > Changed the code of the DPDK af_xdp "driver" to create and bind all of
> > the XSK sockets
> > to the queues of the corresponding interface and after that, after the
> > initialization of the
> > last XSK socket, I added the logic for the attachment of the XDP
> > program to the interface
> > and the population of the XSK map with the created sockets.
> > The issue was still there but it was kind of harder to reproduce - it
> > happened once for 5
> > starts of the application.
> >
> > >
> > > >
> > > > >
> > > > > It seems to me that something racy happens when the interfaces go down
> > > > > and back up
> > > > > (visible in the dmesg) when the XDP sockets are bound to their queues.
> > > > > I mean, I'm not sure why the interfaces go down and up but setting
> > > > > only the XDP programs
> > > > > on the interfaces doesn't cause this behavior. So, I assume it's
> > > > > caused by the binding of the XDP sockets.
> > > >
> > > > hmm i'm lost here, above you said you got no incoming traffic on eth4 even
> > > > without xsk sockets being bound?
> > > Probably I've phrased something in a wrong way.
> > > The issue is not observed if I load the XDP program on all interfaces
> > > (eth0, eth2, eth4)
> > > with the xdp-loader:
> > > xdp-loader load --mode native <iface> <path-to-the-xdp-program>
> > > It's not observed probably because there are no interface down/up actions.
> > > I also modified the DPDK "driver" to not remove the XDP program on exit and thus
> > > when the application stops only the XSK sockets are closed but the
> > > program remains
> > > loaded at the interfaces. When I stop this version of the application
> > > while running the
> > > xdpdump at the same time I see that the traffic immediately appears in
> > > the xdpdump.
> > > Also, note that I basically trimmed the XDP program to simply contain
> > > the XSK map
> > > (BPF_MAP_TYPE_XSKMAP) and the function just does "return XDP_PASS;".
> > > I wanted to exclude every possibility for the XDP program to do something wrong.
> > > So, from the above it seems to me that the issue is triggered somehow by the XSK
> > > sockets usage.
> > >
> > > >
> > > > > It could be that the issue is not related to the XDP sockets but just
> > > > > to the down/up actions of the interfaces.
> > > > > On the other hand, I'm not sure why the issue is easily reproducible
> > > > > when the zero copy mode is enabled
> > > > > (4 out of 5 tests reproduced the issue).
> > > > > However, when the zero copy is disabled this issue doesn't happen
> > > > > (I tried 10 times in a row and it doesn't happen).
> > > >
> > > > any chances that you could rule out the bond of the picture of this issue?
> > > I'll need to talk to the network support guys because they manage the network
> > > devices and they'll need to change the LACP/Trunk setup of the above
> > > "remote device".
> > > I can't promise that they'll agree though.
> We changed the setup and I did the tests with a single port, no
> bonding involved.
> The port was configured with 16 queues (and 16 XSK sockets bound to them).
> I tested with about 100 Mbps of traffic to not break lots of users.
> During the tests I observed the traffic on the real time graph on the
> remote device port
> connected to the server machine where the application was running in
> L3 forward mode:
> - with zero copy enabled the traffic to the server was about 100 Mbps
> but the traffic
> coming out of the server was about 50 Mbps (i.e. half of it).
> - with no zero copy the traffic in both directions was the same - the
> two graphs matched perfectly
> Nothing else was changed during the both tests, only the ZC option.
> Can I check some stats or something else for this testing scenario
> which could be
> used to reveal more info about the issue?

Hard to say, that might be yet another issue. Ixgbe needs some care in ZC
support, I even spotted some other issue where device got into endless
reset loop when I was working on 3 XSK sockets and I issued link flap.

I'll be looking into those problems next week and I'll keep you informed.

> 
> > >
> > > > on my side i'll try to play with multiple xsk sockets within same netdev
> > > > served by ixgbe and see if i observe something broken. I recently fixed
> > > > i40e Tx disable timeout issue, so maybe ixgbe has something off in down/up
> > > > actions as you state as well.

