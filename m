Return-Path: <netdev+bounces-148624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79E49E2A1C
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 18:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 887A128586A
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 17:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DCC1FAC5C;
	Tue,  3 Dec 2024 17:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gMuzkqbi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF3A1E500C
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 17:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733248645; cv=fail; b=MD/1uHs9rKb0CF9YqBHkzhp9ujk5kwSGPMmp226/kftXfoZ7UeuG/RZlPieB2fpygUTo3zT4MDc6JaDsD6KuFmNhZlcYx1iO24hzISQBq7lURKPruFok2UzjSbjhgNJT/shSIWpTYSlD7C7aPqpUpgQlfSdKb6okqbTcKSeMfok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733248645; c=relaxed/simple;
	bh=KUPyxxwrBDdxlMIBv0ObrZqRe7DeQpun3f29nlfbyyQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NzfIjESRB/bRTlhZg1+v//n9SNP6mgBHR6U3UbM9qV+a2oXaVyie6v6DpJwdEHORMic+j52OAfeBGXgiwycRpATDWwVPpxumkSZ7K4t3cH6iV7rblZRlfMCEPLBrTBJhvXDl8OE1iFWU1bVOr3zDSxVNYJJPcZ0NYpPg11w6gRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gMuzkqbi; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733248644; x=1764784644;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KUPyxxwrBDdxlMIBv0ObrZqRe7DeQpun3f29nlfbyyQ=;
  b=gMuzkqbi8uzU7Sy8ZUOuhw+JNtW8OGCEQGLm73HuIs9FaMS9u0pKrpxl
   9IjTB97PiF7uPsi41wCZfaa5/2z1eejIiHhdWJ9Z2vgzL3eYvjyRPLtv/
   BYF6Q7qY2mWFdhkXLCVTN28LjIL4/tPH1cTBmhFO7L/PXWAt/R8k3pgpj
   pPQBrtk+wwwI28i3OV7U7IwEFuME+aPFwyUvLixUuFqNnvBzWBHuatldD
   3Df6JjX2Id9IqH0FidT3WpPuweVv3o38VMts/yRT7hjYFnuo2qGhqv1X+
   RRu1V9ayJ1L0X0aF4hZdkFNl8JIJXMyihj0JpJRHqLHx9qStpIqPhXbV/
   g==;
X-CSE-ConnectionGUID: Q5n2wTasSF6SiytgjsdLzA==
X-CSE-MsgGUID: ckX67FRvRLylkYC8sJ8ZbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="33401253"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="33401253"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 09:57:23 -0800
X-CSE-ConnectionGUID: 4OtdgI45SS2aT+Ytq1nkig==
X-CSE-MsgGUID: AINc5iIdRUe7WN2DF1nOoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="130961443"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Dec 2024 09:57:23 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Dec 2024 09:57:22 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Dec 2024 09:57:22 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Dec 2024 09:57:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEaf5HHqJRXwT2iGSIzLdUIFZ1NTA7gb/tYoYrmcQKSqCOtWd9iCtKI9it4uOoR/MwFIFTBPA/BBODPFbKRfg3VCFBBU3DMIDj+yvQ/Zj4NksUvrHNE6O6MErroX+Qna5vTa/8sYiP66IXnVzBKuAwJqbR2iW8AXj4PsC9teS1bc5VyV6l0WO5ORz1rBdDSWjZ2FqoCAl8qcfztX0KOEORauf4SI8I9lzWLBLrcL6zTDden30lsjfgdROoZFmtUXz460rE0n5Sm2CPs2e9MFgl8AUIdjv2KLYgl30LeA6vzsN+YMLzOyBDE3e1F8jw85QVOUdoU2dCEqCzuzgYLvyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXrNAEjKl9DeKfEm2wfigKBvWiHq1gK4q150wMkUPY4=;
 b=BtCrowMCoKN7DZxO1c2V7R5lMY/wlWC50nvT3HoqYfKAlyvXVvP44RmeXneJTrTrCewyBCdduOSxHy3t9pwEuZkRb6oeviNS8SfMy2jBoP3gK6l92JxTGHPy2xExht8/znzU7ZgsUeijw5Ci/E6yi7SkaT8rvdBP1DxK0YVe1fIBEsL/FC+OI40wFPtomXEbfMLbtk44C5kL6wJQEdA68hKIHFrPSGchMD0qKsSWRw05XDjOsG4ajSi4IxUqkFKsMrrfgmyuTFUTFPPDkDivL4RYGXbsuu8yj9Lm4OTGqoXbXaXJkY95o2baADHBo3JQ4EpAfTX4qk+thZbF8LAi7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CYXPR11MB8710.namprd11.prod.outlook.com (2603:10b6:930:da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 17:57:20 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 17:57:20 +0000
Message-ID: <4341bd7e-7f32-4096-a14c-f84376625d5d@intel.com>
Date: Tue, 3 Dec 2024 09:57:18 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 3/9] lib: packing: add pack_fields() and
 unpack_fields()
To: Vladimir Oltean <olteanv@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Masahiro Yamada
	<masahiroy@kernel.org>, netdev <netdev@vger.kernel.org>, Vladimir Oltean
	<vladimir.oltean@nxp.com>
References: <20241202-packing-pack-fields-and-ice-implementation-v7-0-ed22e38e6c65@intel.com>
 <20241202-packing-pack-fields-and-ice-implementation-v7-3-ed22e38e6c65@intel.com>
 <20241203133628.lcefexgtwvbgasav@skbuf>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241203133628.lcefexgtwvbgasav@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0103.namprd03.prod.outlook.com
 (2603:10b6:a03:333::18) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CYXPR11MB8710:EE_
X-MS-Office365-Filtering-Correlation-Id: 818d46c4-054d-4fce-4990-08dd13c3ee95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHJZeHIvVVRxenFzODNZUkNGSTdVK09UZUxYUjlqd29pNDF2ejZaa2lWOGdy?=
 =?utf-8?B?a0gyVkxkaGFiWEhPRTVQUWhISEdoaEY1RTJmNURjOU05a2ZaRjRTTHI5cmx4?=
 =?utf-8?B?dEF0dy9BZEppOEhsc3c5VGYwZ0E2Q00vQjFvK1VFc1NNWXRqS25uN3pIQit3?=
 =?utf-8?B?MWc5NFRnNDd5cEdwemo2aTV0NndkcU9SSHJ1VHNEWEhwQjdiV080WTdNUzlO?=
 =?utf-8?B?ekFmRmdYSE9NaE8xZTJNb25pbEhheDRKTnVJVXF1ZnZPaG85ZVFFd3BHS1hn?=
 =?utf-8?B?WVA2TjZSTm56VHRoNHdhNFVsTGZueVBQM1MyYmFDTWVxaTdjckx5aGRMUURv?=
 =?utf-8?B?ZFdjODhBUnFMZEd6ZkgrRGNYbEM2VXplM2lOZ1BNMHI1b1lXZ0xzL2lEL2FE?=
 =?utf-8?B?U3o2VktmM0pheFhUM3F6Tnh2V3FCZ0ZOMTROK3RQMTBBWVBwanE0NXFLY3Z3?=
 =?utf-8?B?K0tkU2Rjbm9sQzZZcnA5bUN3cVhRcTNndUkwRXFtZmFoT3hLb2liNG5FMEtw?=
 =?utf-8?B?TUpzNlFvV0dFa3pRNkNOVmcrYTNHb25lamdNNnorektHR3ZPQ3RUVVg3ZjF5?=
 =?utf-8?B?eXYrNkRhWWZhT3NjVGZtdXhzRlJZdnY3NEVwQk40OStPMTJXWEJFZmxDbnNV?=
 =?utf-8?B?RC9qdkRURndoTGw1bWZtZS9vQ2ZBUWpaVk9DTXdkYTYwWUFoZnVCTFpVV0NM?=
 =?utf-8?B?T28yN09WV0J4T2NkTkY1cGdOS0p4NWowVWRxeERQZWF6aVZVWUpscE9rVC9U?=
 =?utf-8?B?bHoxZW1CWjV3SjdpQlRtb2xLOWFFMThsazczZU1PZGxmenFMMjBtN1Jsemdz?=
 =?utf-8?B?eUpJS1RlM2dJMU84cFlHQU9hS1BrY3ZyM2h0azgrQ21QZHg2QncxNGpvYjRv?=
 =?utf-8?B?SzI0bjVUMEVpa1g2c0FqRTB6bW0wenlPNnFHYmtOWm1YRkNYRGxRcDcvR1Ar?=
 =?utf-8?B?OXZCbUUyWTIwaTFKTlhkeEVVUDJQeGxkRmVkbzZ1K01IcEFjU3VpZC9NTXNZ?=
 =?utf-8?B?RXdXYWUrelVvdVlDR1BwQnhWbTRCaXJjWmxmWGlRejBvWnZrU0tranMrNXpP?=
 =?utf-8?B?WmNWOTlGM25IZ0tZSXZKNk9pU3FWR3AyQWQwcGxmRlI3NGx2YXlvUXgzU2NG?=
 =?utf-8?B?OE9YYU5iR1ZHWEhsRW53T24vSVNBaFQ0VG1EQmFmU2xMQ2pCYmgybmIzeGtr?=
 =?utf-8?B?dFdYTXlxekZTb09mWlFpUitNRlFkRG9XcXhhRXpJK3duNlpIODhvZjIweTdI?=
 =?utf-8?B?d2d3OElNZnloVzdoN29IaHBIc21nVmh4TnFyUTBMaVVJank5UEdRZ0hjWEtX?=
 =?utf-8?B?aWY2WGJHcnN1UWU5Zm1TVWRYeDhrMjJpcHl3YUdraGdPMUQ5aUwyM0dkaHNE?=
 =?utf-8?B?TzNoZlVPQ2htZEJRNnZMOXhZZlRGZExLWGZZRVF5VlR6cnIzWUU0R2UyMzZj?=
 =?utf-8?B?dzdPcGx6amt1Qy9Jc0llYmh4aVlLdFZTWHBrSkRGZk1kR0ZWQ0JoNWFEMkNI?=
 =?utf-8?B?bm9RdDIvd1JzaEZxVDhGRnFSK09pV0E5NzNmaDNPWUxNOElqR01PVlhGS2FS?=
 =?utf-8?B?aUFXOElLcTdJMXo0RTNRZVl1MEQvOVVFMzIrYVVXaExLa3RYRVJ1YnlDQmM2?=
 =?utf-8?B?RDViVWwrMmNuSGV4SC9vSklBSkxvYU5JRjhLTTN6dU9MTEVTQzVMcGZ2YS9s?=
 =?utf-8?B?YThPamppYlRLd1VsZklBT2RObkFRRTByKzJkM2dRTVp2Mi9UNXVEcUU0ZUNo?=
 =?utf-8?B?WkNieEhGN21kdHNMN3Eyd2VXY3p0dkgvdkc5bSs0REJLZXNSZDRhY0hXRThN?=
 =?utf-8?B?T0FCa2FRaTR0cmJMZ2hEZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVh0TmZLMGJtS2RERStGWDRhbmZSVkN1UkUwMDhEN2laNGhxMVJGVDkwSVlO?=
 =?utf-8?B?M1ZYbmtvQkc2NkNGRUFwVjhSYTY1Q1JaS2dKNVNEaXV5YmFIbnZFOW5UcU1N?=
 =?utf-8?B?WWgxRkhSVHBIUWQwMEREQXFHWktzWlEzVTI0akx4alU3Q05md2l4emtBM0pq?=
 =?utf-8?B?TGZCd1BkZ0phaXF2cGNZWVMydzJiaGlDN0pGWm90NFpGbVhJU3FZdWdyMzYx?=
 =?utf-8?B?bkFGalZCeVR2ZUZLU2hKUVAyWTdsR1RHM3FjQW14ZGJnYlAyTmxzSGJJVmEz?=
 =?utf-8?B?N1pPWnNDTmFZOVBFWDVjdU5Ud3dhS2VOeVRUcnZyRXNtTFRlcDFldDRTSWhN?=
 =?utf-8?B?d2NyamlIWjVWL1hRcXUyY0puc2lKYms2azkzakVoQS83a2VDUUF2Y1dFdDJ4?=
 =?utf-8?B?QXpwVGsyWHNmbUVrQkM1bWhjNXRlcVR5NGFhK3pxQUd6TUo4V2puUlZTZUIx?=
 =?utf-8?B?MkFjUHhYZ3d6QmYwQ1c0WmZMTmZvUzYwU1RkZVBNdUhPNzZNTllwM3UwVWsz?=
 =?utf-8?B?THZhTXdMK1JlS2JzaFNxc3JyWThkL08yMzJSdVV0WVc1VGlhLzgyT3hDYmdY?=
 =?utf-8?B?ditPLzlKNjdBWGsrbldrc2RLdVE4bEE3K3NpdmVuN2I3aDJLd3QveGlPL0Qv?=
 =?utf-8?B?MDNkWHFXTWJSWSthMmV5UmhkTFBETzdKY2JIK1ByZXN0OG9KSTh2UVREUURH?=
 =?utf-8?B?NG1Zek1tbzR0eEZ3MXc0SUgrSFdMUmErRE1tbFo5MmJMZzQvNFphR1JDWjFN?=
 =?utf-8?B?RExWekFKUnlkbk1MUGxaRjBMaHFueHRGL2kzZmpsSjFqT0Z0c0ZoL1pnVVlZ?=
 =?utf-8?B?cjllTDJndkJiQklZWXRtOWticzJCV2lDZnpMYnNRNk1pOG5Fb2FaZTljY0FK?=
 =?utf-8?B?RC93ZHJwRUp4eEhBek56cmxadllLUVg0RGtGQkorY0hSdW5RLzZsbk9hOTNO?=
 =?utf-8?B?Y2xZRWtON2ozb01ZZ0V5SEpQK3V2K281SEVaUmhtcVhRa3pjVjc5UW9qSWo2?=
 =?utf-8?B?Y1dOcHh0eXVUdy9yS3p6TWFSWWJ0YXExRHArMWJ5R0UyQzU2bEFsRkJGVFhk?=
 =?utf-8?B?YjlLWGJ0SmVKdzg1T3Vtczd5TmRHdzJPUEFPemlqbGVnYWRuZGhaTEh2b29I?=
 =?utf-8?B?a0FJSE9OSHhtUEMrVVp5MTA5ZUNaQ21MZmNweVZsSzMrNlB1L3Q4elhUMGlM?=
 =?utf-8?B?MnBzQ0V1aFRIcU1Md1FoSlAzWnFGM0JPam5rN3ZGcldwWkR5dnJDbzc2d1VI?=
 =?utf-8?B?OU5STmdjNHpjVTVJeXpPM3hQMlR1U2RnYkp6RE9rY1JWcFdIVVlaNHF6aUZu?=
 =?utf-8?B?UDZWa0d2YTRMTjdyQjR2V1gzSDB5NUhpeENiTmdFUXI1T2xMWkRieEFUdzRn?=
 =?utf-8?B?K2Q3M1FZT0d1L0tsK2VGaE9meFZRbzdEMlhyS2tJUmFzbzAwT1BjU001TmFB?=
 =?utf-8?B?QVNpcTJ2dVdYKzZxK1I0TytLakJ1eTdlK001b21RQk1HNjZYK3I5Q294Ty9p?=
 =?utf-8?B?UTdwVlBYT2hVWCtyQUlmaE9xdVFUakd2VkFxSmczUG1kdGdRa0JidndMczBE?=
 =?utf-8?B?TlV1VHh2RDU1azd1RzJkUVhOUmk5UERodmF5S0JNVDhDK1krcGF6b0RyQ3ZM?=
 =?utf-8?B?ck83OGFaSVFMQmlaS3ZjTC9yamsrRXpIRWl5ZDhHam04TlYwUm1sdDFMMC9p?=
 =?utf-8?B?SG1oQ0RqYnBvR0paWWhqQURpb3RDdmYwU0Z5ZGFiaTRkTURWQzlqdGsrNVNn?=
 =?utf-8?B?Z1Jmbm44NHlwNHRJczFKLy8raVRpb2VUdms1UGpROStvcHZMYmo4WTRyM1VU?=
 =?utf-8?B?SThTN0FmYjFXQkZDWk5CdHU2SEcyeFQxNDlWSUtGV0Q5SmhVSnBBNUNSZHZw?=
 =?utf-8?B?bVdDRkZxOHRLRkdHV09ndHMwcUZ6TE8xM2QwZlJYazZJUlhsNjB1SzVsZmV6?=
 =?utf-8?B?MWRab0M5dnZxUElyM2MyVWFiMHlRZFVFTXRQOU9nTU5PaE8vSVZGMmJzekZC?=
 =?utf-8?B?OFlvOWl6UUNkMUZpa3FCUm5yMTI2a3M0d1A5eFNMK25MeXRPeUttSDlJVDVi?=
 =?utf-8?B?UlpGVWFIOE1jWENtMEtrTEtOalNleVc5TWI4L2duTCtRS2ZJQXdmeUdJaC9a?=
 =?utf-8?Q?IpHZC3SAAaDPhDXFS7WMpVVbL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 818d46c4-054d-4fce-4990-08dd13c3ee95
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 17:57:20.1188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHHWhOq3u6nw+xqWMJjUaKRq7EfzUYxUiArNOlAHOtWYb95LHfG/f1IIspLWl5KmsNE+YtFezqOk9oPw38CGqUmpVswy0LZ10ni/gTBFymU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8710
X-OriginatorOrg: intel.com



On 12/3/2024 5:36 AM, Vladimir Oltean wrote:
> On Mon, Dec 02, 2024 at 04:26:26PM -0800, Jacob Keller wrote:
>> diff --git a/include/linux/packing.h b/include/linux/packing.h
>> index 5d36dcd06f60420325473dae3a0e9ac37d03da4b..f9bfb20060300e33a455b46d3266ea5083a62102 100644
>> --- a/include/linux/packing.h
>> +++ b/include/linux/packing.h
>> @@ -7,6 +7,7 @@
>>  
>>  #include <linux/types.h>
>>  #include <linux/bitops.h>
>> +#include <linux/packing_types.h>
> 
> I'm unsure of the benefit of splitting the headers in this way, if
> packing_types.h is not going to contain purely auto-generated code and
> is tracked fully by git.
> 

I can put this back into one file. I had kept it split from when we
needed things separated to work with modpost.

I can move it back to a single file.

>> diff --git a/Documentation/core-api/packing.rst b/Documentation/core-api/packing.rst
>> index 821691f23c541cee27995bb1d77e23ff04f82433..5f729a9d4e87b438b67ec6b46626403c8f1655c3 100644
>> --- a/Documentation/core-api/packing.rst
>> +++ b/Documentation/core-api/packing.rst
>> @@ -235,3 +235,61 @@ programmer against incorrect API use.  The errors are not expected to occur
>>  during runtime, therefore it is reasonable for xxx_packing() to return void
>>  and simply swallow those errors. Optionally it can dump stack or print the
>>  error description.
>> +
>> +The pack_fields() and unpack_fields() macros automatically select the
>> +appropriate function at compile time based on the type of the fields array
>> +passed in.
> 
> This paragraph is out of context (select the appropriate function among
> which options? what fields array?).
> 

I'll use your suggested documentation.

> Also, I think this patch could use some de-cluttering by making the
> documentation update separate. We need to document 2 new APIs anyway,
> not just pack_fields() but also pack().
> 

I can split the documentation out.

>> diff --git a/scripts/Makefile b/scripts/Makefile
>> index 6bcda4b9d054021b185488841cd36c6e0fb86d0c..546e8175e1c4c8209e67a7f92f7d1e795a030988 100644
>> --- a/scripts/Makefile
>> +++ b/scripts/Makefile
>> @@ -47,7 +47,7 @@ HOSTCFLAGS_sorttable.o += -DMCOUNT_SORT_ENABLED
>>  endif
>>  
>>  # The following programs are only built on demand
>> -hostprogs += unifdef
>> +hostprogs += unifdef gen_packed_field_checks
> 
> I will let those who have been more vocal in their complaints about
> the compile-time checks comment on whether this approach of running
> gen_packed_field_checks on demand rather than during any build is
> acceptable.
> 

We had a lot of issues with getting the generated file to work properly,
and I even *still* had some minor issues where the files just didn't get
generated properly. If others agree to go back to generating on demand I
can try to resolve all of those.. but I'd prefer to not touch the top
level Kbuild :(

I think the overhead of committing these lines when its no longer 20K+
is acceptable for the simplicity of just having it made on-demand. I
also prefer keeping the script as an actual script you can run vs trying
to embed the script in the header.

