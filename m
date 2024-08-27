Return-Path: <netdev+bounces-122415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B01479612B5
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 17:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 673A5281CC0
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FB91CDA3B;
	Tue, 27 Aug 2024 15:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I9WbFmIb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1249B54648
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 15:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772732; cv=fail; b=cHheos9gePOqTLmhuD/auAbPwWfaMquLrlYsp4gFmmb6C847FIfe3mgcU59qp+HTz4ykj3VNSPJhzWblSc5k7mGzRTn84Nzy6FH/GtQs+LIGj56TnV7RwZRV4iIWdIs/S6nfdTxOYutwUNYRmEm6LiKVGw/RBlarEMjUnig70IE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772732; c=relaxed/simple;
	bh=vSAWb9CKdDmGs/ACWuy6tkJ+lYgcAJgk6Bxn1ntvc/M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iDco5sV9lO3cxR+RD4DiOfohOd0auxLRIOpQeUbvl0NkVTVMiz2tbKSvxveQgTBCkKscl2DBbXOI3rJR0YVUR9BE/k2b++0WDQ/dZibdR3DrqCai7R9Apt3gygjUGtf0tJ/ceR4wh62P6MjmEDan2Qotj87kCo8IFLKleMMZkIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I9WbFmIb; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724772731; x=1756308731;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vSAWb9CKdDmGs/ACWuy6tkJ+lYgcAJgk6Bxn1ntvc/M=;
  b=I9WbFmIbBvtLmHwOr/YRiUMPUTRPWeaFhbo7XFB/ZOy3wNZ+tMATF950
   94EcA4fOhAc7gCgA3vfWRgkBIvuYcaZ73REev5wzDzN7aaPTpAVjMHL8A
   t0o4RERVgvoqyxQ3DEyrTWcUbsADbzmOPr4jZYkyUR41/RBLt7CmuMp7x
   Q9Sg4W3SSUX0Nhcvr77yQ03Paq7s5Vw/YPmg0rekdS1oHXvZkOXwFpIRt
   1Nz8Ukv5H2pN0s7cuFUbUvR3RnuveLnwmyuzFi5IdzGZC/ckUYxlHsC6Q
   SBYFlKRv1A0bCNm9NppT3XREs+gETZ71f2l9HUYtnEqOvrc2kpdAQ1arA
   Q==;
X-CSE-ConnectionGUID: DHxAdpPrThmD92Qw95t0ag==
X-CSE-MsgGUID: 0ilEqu0lRNqHj2LjmcFcoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="33883320"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="33883320"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 08:32:06 -0700
X-CSE-ConnectionGUID: r52mEdtRSlGeZ+Q9bFgRbg==
X-CSE-MsgGUID: FQJTDE5lQ82RZkJ9X8tJ8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="93627958"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 08:32:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 08:32:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 08:32:04 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 08:32:04 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 08:32:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSDtHn/q77cGPeFaWbbDstgk5wcFhO1AF02zYnIzGlerAqjdHv2I+3DWUKkcjJW5pnFgWb/2aS1DyKS1GwcTIgX3nkEe6vY1mI6ZMRk8vfNO+4PMSCib5vtM9UifoqG/7BcVkm7tB77M2g7fpv2gpx3DygJehgsKyhNRPpD4x4OzEIYWVyy3+RjCsh/AUCuVpX52yDglKiypxAo+7IFqWbO5zUO6EH777XWanbRqBOm7Xlyvuj6B8xqBtiZrhTg/UdkEqvydCs5InvynTFPDwZMoQwPqXsx/kzFxYwstj+DKsFYgoD/CbhDE4QqPUOuucBNMMQg6M/Y4j13PVHnEfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGkGZnVwglr+XDTm7cqUxKZxHEdC9oS82G6d1aK9ozk=;
 b=nZXzL/bj4fjtwiafvAZaITl4beDWQo4hs5BNFoZzN+kNmsLQvgubugSjEq8I96DFWR7nqdRzL6ZlLJQnT/LNxhEiLPh7dZgVXFpIb1elJ702OY925F6tmc2SrjPRaOS5xIpgpO7CvTF7uvCa9dE7lImlC+jCzAsZ9Wo/JfspnIZY8IbPjozhKp7d8DO0199hVztlC/dpPeJuFJRTUFohpxsFLNOzLMVS7nay8jsMrl/c2HA358/f9YOfwtygIpNnnXJrnNvxDc5XFsc+f8CY7ulHhzLYkBht16qPTqoH1QZzHlSG7YWQc9i4DP18W/ALY5Bkcv4iq0mRjdIMngjJ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA2PR11MB4777.namprd11.prod.outlook.com (2603:10b6:806:115::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 15:32:02 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Tue, 27 Aug 2024
 15:32:01 +0000
Message-ID: <ee5eca5f-d545-4836-8775-c5f425adf1ed@intel.com>
Date: Tue, 27 Aug 2024 17:31:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/9] libeth: add common queue stats
To: Jakub Kicinski <kuba@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
	<przemyslaw.kitszel@intel.com>, <joshua.a.hay@intel.com>,
	<michal.kubiak@intel.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>
References: <20240819223442.48013-1-anthony.l.nguyen@intel.com>
 <20240819223442.48013-3-anthony.l.nguyen@intel.com>
 <20240820181757.02d83f15@kernel.org>
 <613fb55f-b754-433a-9f27-7c66391116d9@intel.com>
 <20240822161718.22a1840e@kernel.org>
 <b5271512-f4bd-434c-858e-9f16fe707a5a@intel.com>
 <20240826180921.560e112d@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240826180921.560e112d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0159.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::8) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA2PR11MB4777:EE_
X-MS-Office365-Filtering-Correlation-Id: 6282cdff-2b5b-4100-e46f-08dcc6ad658c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnR0a0M1UEtJM3NRVzlJelBhUzNPUFJCb1Ivb2RvYmpxclNMQVlQU0ZHUENi?=
 =?utf-8?B?ZTY1NjlreWU4OUJMREtMVHoydDBCZDVzRHhiMWRIVk1uazFmWFpORHVMZXRo?=
 =?utf-8?B?TUtRejBWZVZaOEtFd3VZbmtQYzdFOXpXTU0rbm50VTJoUkh4Z05vb0M2M0RN?=
 =?utf-8?B?ZjFUZE9id1Z4ak4xVW5tTCttNm5ZeDNZdWNNZ3dHdVJWMFk0MnY3VWtGa1Nr?=
 =?utf-8?B?dGZkL3MzM1Ixa0IzWEpiM2pTcThTRUZRMGN3eWoxTnM2WjEzWW0xTk5GQ1Vo?=
 =?utf-8?B?K0w2MEt2NDM0bHlzWDFucHB6L21MWVdaSjhvUlhHWWpNcktSK096TFdVYWJl?=
 =?utf-8?B?a0RvQUp2dFRwdk5LZExaUTllVGlYQ2RlbjNwRktISmNRaTV3M0JHcDJhTzZK?=
 =?utf-8?B?VGlLVmpWNGEyM3M0VnNpbFBlVzdTa0lyRjNxOVRaZE9rT0p4NldsSHE2OVY5?=
 =?utf-8?B?SndFTGhaRE5JU1B3U3lwWTR4MGd4U0lEZU1WM3FrOXFVZS9YYmUzTGpYK3ds?=
 =?utf-8?B?YU1oYlMwVFZ2clNOeVFQOTlITzkwSlAwRVR1TENQTDAySmZ1Rm13L3NNOGRM?=
 =?utf-8?B?R01INXkrK2Ywa28vSytpOWc4ZUtoeWxwc284cVlpcjVTek1sKzhFMjRZbWdh?=
 =?utf-8?B?TlJWZEQrRWVpdUs3NnhpSjdTN3hlSFlhTkZ5UTVMbmszQWNSWlFBeDZSRkJ1?=
 =?utf-8?B?N0FVMURWRGRVcEt4TUMyTlVGL0hES2g5M0VPQXpnRVRCL25JS0l3N0JaNHln?=
 =?utf-8?B?YnhVS3FJRFJjWVZzOHI3ODBvU3J4VGZVWFd1MTFRRHJndEdxNUZucVVkajVa?=
 =?utf-8?B?bG5sQnZVRmtLY0lrQUQzemhmbVgvZDdVNlNNdExBbFNBN01OR3RINlJZYlAv?=
 =?utf-8?B?L3lvc2lnQ2U3c3VyTmdUbmdpU3ZYNWxtMm81VHVQUUQxSFQyK2NXWmszYVFn?=
 =?utf-8?B?bm9VZFRIOExuVlNtcEdvbm8vUE1uRUVDbHhZdDVlbWJXUE5NU2pIdmxVZmFO?=
 =?utf-8?B?d2V2QTdickVkaTY1TWNDVmZYTjdFQTlyZ3pXM0tTS21zZVUrQWczNkY2NDh6?=
 =?utf-8?B?WTl0UzV1eGJ6a1ZaL3MwL3FxRmhBbm9EUVA2bzBkQWlBdzVlWlByczFPSHQ5?=
 =?utf-8?B?cGk0bU91NGNQQjgwSUFKaHlmLzBSZXFmU0lYS3VoSkVveFFucVVJZTdJNWJ0?=
 =?utf-8?B?SEhWWk0vcEVDWHdONGJPeUJxOExLU3JHMHNqejUrTjNnWFlTTDluM0FUTCsz?=
 =?utf-8?B?em4yMmlNWEYwVU4zTDNueUdURjlwdmU3Um1GVld1ZDhtam1XS3pCaENHZVRD?=
 =?utf-8?B?NVQ2WkRxaDhKZkZ2RGVPMmZVbkVPUU9JV0dXL0tCVHlLYnRtdXBHdEpML3Fj?=
 =?utf-8?B?YjRSOHRIUjlWQXhBeEFqM0NwL3RQdTFURjg5blBrZ3oyU0dyQUVPckQ1NmNM?=
 =?utf-8?B?V24yTjJCd3BiWjRsNTRWcWJBSU1nNFdwcXJzdU02TUFMT0VMczJBQklGeDMw?=
 =?utf-8?B?bTlpT1RCMHhPMmZDN2NvQVdHZWxNek4wUW1uc1dGZGltREhGamZBZG5lY1lY?=
 =?utf-8?B?dVNDQmlibnBhdVBrMkprR1lZQS9mM1UrOVFDVW05a2xaWHpYK3dzc2toN003?=
 =?utf-8?B?VjhxSWEyb1RKSVhOeHVuUHpjelQvTkw4dDE5RFVlUndhUXJtN1dJWlY5akda?=
 =?utf-8?B?Um9pbW9mekhKeE9ZWTRsZ3JIUndHeDZjaFFDMm84dUE0R1M3RmlINWZNMm1K?=
 =?utf-8?B?NjB5UThwYlIxWE5pcU5kN1I0c2VVZlE0RDJnWXQ2TEtsVnZjNWlEMjRHeGJG?=
 =?utf-8?B?VHBiWGswSzg1bk5JbEpTQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3dJNnVpbWpWZVh5Y2QwYVFNNm9VN0NMZmFXRTBFN01yNlFsSXp1Vk9RRlEx?=
 =?utf-8?B?b0pvV1JBaFJBLys5MDB5eFJ4VE1NMStvNXhYYTYrald3VW9zNTFkRHVqSmg0?=
 =?utf-8?B?ZlZRY0ZoQlE3YnM4dG1HMXp1TmRUbWgyQUp3dElUTmJkNnZwa2QyK3hBaExI?=
 =?utf-8?B?WXluWi9ZWGgwaG8yN3IvYTdxZGl5b1d4MGhkSlJQc1cwc1U5d1J3azdRa3Vw?=
 =?utf-8?B?TmFQTDYvUjV5djlIejRhcEJ0VTd5OHF5N29qQ2ZhL09TbmlzVUNOQmNnTkJu?=
 =?utf-8?B?Wlc4ckNKVEpxYm9nMDhpK0RHcVc2clFMaFhwRzRPamNnWU1zYUxLMng3dG9z?=
 =?utf-8?B?YzVGeWFsZWNDZHdEZW1xejZVZ2w2SkgxTFRiVW1BT0dNdlFuS0JwdDI3eldi?=
 =?utf-8?B?QmlHTWRwd3RMVEtuSjVERlZqbzhySzh5VlZTQ04wTklkMkxsSUU3Z1ZKMnNY?=
 =?utf-8?B?N0Fud1BnMy9ReXdiandqMXBnd29lKzEwRDJNUm5jUmp6VlRjTVVldGJKY0dS?=
 =?utf-8?B?TE5McVJuUHhCanRMTDV5OVZrcjZJUVFnSk9rVFY5aEJ5RTVXUlA4d2J2ZEhp?=
 =?utf-8?B?L1c2dlJzaXExM3hmL09tcmxmMzdyOXZtVnVoSmZBd2VaWXk0RmZvaHJOSy96?=
 =?utf-8?B?Ni9GSGIwSmtYRldWV0YvVHNSN1l4azI1NmcwQzd0ZkZGblUzWS9pR1o2MEpC?=
 =?utf-8?B?bW1EbncyUzN4RXl1TzhQMitMQ2FDMEJuaUI3K0UxTVQ1ai9rL05ycUMvdzBR?=
 =?utf-8?B?TnEreDZUMG9nK1dvSE1ZSlJvWEJNZzRxWmh1ZVUvaUtPQlZ1TEJ0S0hnZkRm?=
 =?utf-8?B?VndBTmJTYVlaakFvYVA2QThsRWRlaGdzZEEyNEZDSTB0UzQzbFFHcldnTm0w?=
 =?utf-8?B?UEk0NFgxdFZKQlNzZFZrd052aStsVUZvY2FZaDJqN3VUU2lYcGlsU3puY1BW?=
 =?utf-8?B?QmZzTXJweU1ERjgxdmJxVzhVRGVaZlpXS3V5dzIyUlMzekRPUm42cHJOMHNR?=
 =?utf-8?B?elpETmxXYTNZS3NaWnlwK1VEZ1orbytFY09lV29iZjRrVzRrVStLcWRTQVJU?=
 =?utf-8?B?SDNKeDIwQ1NaNzdRNXBEd3dLaTA4RUsrY1hYa3VhWS9Rcm9HcXB6NW1VNHhm?=
 =?utf-8?B?TkF3ZEFFODhrWER6YTdJRUMyVmx4MHN0Lzg5cXdBT25kQWFnamxVanVLblp3?=
 =?utf-8?B?emtnOXBjUlNGVXg3UjFvcnllcm9NQVpVYmtTT0d1Nm1PVU9vSVFKZ3VQcmZz?=
 =?utf-8?B?SHNmUkhXOWJuK2dOUEN0Mk1SbzlIc00vWCtXd3FHaXpHV0JRT2dZV3VYV3FM?=
 =?utf-8?B?WG5oTkV1b29ndExOL05rS3ZYRHRLeHlJTno2Q254NWV5ckxYZ2ltZVExWldF?=
 =?utf-8?B?ekdtVFQ2QjRweitvZkg5VDZIbHJXVU1VRkFqck4rWWU3bzVLSE92aDRPcUor?=
 =?utf-8?B?ZjlVOGxwd2pZcVdmUE1mZFZMQTg1MU43UWtaM0NFSzIrcUI4ODBET0d6ZWtr?=
 =?utf-8?B?Q1dVQ0QwYU92SmdjdldSam82OVNVVzJyVDArcEJPS00yVDdoUlVLZ3VWdTdi?=
 =?utf-8?B?K3RPdlB3STg0WjJoRVRPTXhGZGZacTVQTDZ4eTF0U2lXT1dURDU5Qm1LamlQ?=
 =?utf-8?B?c2cxQkduYXlISWJMOVh4cEdkaUhDZ285NmpqQmc0ejVzN0FFUEU3cTJ6NVJo?=
 =?utf-8?B?TCtIak9DOENPTURSUUtFT2tDNWFWZ2RudGsrL2tsNlEzVDNLOEQyZkFFbzU4?=
 =?utf-8?B?RE1vUU1FdlArSHBhVTNxNWZoYldhUFNkcC9lNGJQaWZ0bGpXQkViYjcra1NS?=
 =?utf-8?B?WkV4YmIydUVUbEZNN2xwd3J4TG9VTis1d3dKelp4L3JtRTQ3RlNSSGs1TElW?=
 =?utf-8?B?bVltenBIaVkwa0w3Ymw5Y2tlczZOR1Y1eVJ4dk9leFRLQlN5ZHgyZ0c1THhB?=
 =?utf-8?B?K3lYbmhRNi9aSFlNd1RmWWVIclFvZTQ5TEhoWjBlVThPZndvOU93N05mRGtP?=
 =?utf-8?B?NG90Z1h3UlBNdWgrUkJDMFpmblpqN0pDM0E1eVJlYTU4ZDFaU3draVB4NmNi?=
 =?utf-8?B?M3NkKys4R1ZWeDdMZzNyM3ZCbHJVdGwxOGtGQnNtWklVUUVIRGo5Sjdpc0s1?=
 =?utf-8?B?a3Y4enl1TjdvcEdCdjU4QXJlZzRKYS9FQVluZDVCcjRnZmxSSXRKdjI0OXRR?=
 =?utf-8?B?L1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6282cdff-2b5b-4100-e46f-08dcc6ad658c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 15:32:01.7014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qaW59kQXK83tyKKr//fkS0g8MimVBO/Fo51OE8sRM7Kuvrsn2SCl2e4V5xMfJm90NYJmy1A05UIj6d0Bpa2PuryT3e4Z6kipHG7Aen6ejiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4777
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 26 Aug 2024 18:09:21 -0700

> On Fri, 23 Aug 2024 14:59:17 +0200 Alexander Lobakin wrote:
>>>> For now it's done as a lib inside Intel folder, BUT if any other vendor
>>>> would like to use this, that would be great and then we could move it
>>>> level up or some of these APIs can go into the core.
>>>> IOW depends on users.
>>>>
>>>> libie in contrary contains HW-specific code and will always be
>>>> Intel-specific.  
>>>
>>> Seems like an odd middle ground. If you believe it's generic finding
>>> another driver shouldn't be hard.  
>>
>> But it's up to the vendors right, I can't force them to use this code or
>> just switch their driver to use it :D
> 
> It shouldn't be up to interpretation whether the library makes code
> better. If it doesn't -- what's the point of the library. If it does
> -- the other vendors better have a solid reason to push back.

Potential reasons to push back (by "we" I mean some vendor X):

* we want our names for Ethtool stats, not yours ("txq_X" instead of
  "sqX" and so on), we have scripts which already parse our names blah
* we have our own infra and we just don't want / have time/resources to
  refactor and then test since it's not something critical

> 
>>>> So you mean just open-code reads/writes per each field than to compress
>>>> it that way?  
>>>
>>> Yes. <rant> I don't understand why people try to be clever and
>>> complicate stats reading for minor LoC saving (almost everyone,
>>> including those working on fbnic). Just type the code in -- it 
>>> makes maintaining it, grepping and adding a new stat without
>>> remembering all the details soo much easier. </rant>  
>>
>> In some cases, not this one, iterating over an array means way less
>> object code than open-coded per-field assignment. Just try do that for
>> 50 fields and you'll see.
> 
> Do you have numbers? How much binary code is 50 simple moves on x86?

	for (u32 i = 0; i < 50; i++)
		structX->field[i] = something * i;

open-coding this loop to assign 50 fields manually gives me +483 bytes
of object code on -O2.

But these two lines scale better than adding a new assignment for each
new field (and then forget to do that for some field and debug why the
stats are incorrect).

> 
>>>> You mean to leave 0xffs for unsupported fields?  
>>>
>>> Kinda of. But also I do mean to call out that you haven't read the doc
>>> for the interface over which you're building an abstraction 😵‍💫️  
>>
>> But I have...
> 
> Read, or saw it?

Something in between these two, but I'll reread since you're insisting.

> 
>>>> I believe this nack is for generic Netlink stats, not the whole, right?
>>>> In general, I wasn't sure about whether it would be better to leave
>>>> Netlink stats per driver or write it in libeth, so I wanted to see
>>>> opinions of others. I'm fine with either way.  
>>>
>>> We (I?) keep pushing more and more stats into the generic definitions,
>>> mostly as I find clear need for them in Meta's monitoring system.
>>> My main concern is that if you hide the stats collecting in a library
>>> it will make ensuring the consistency of the definition much harder,
>>> and it will propagate the use of old APIs (dreaded ethtool -S) into new
>>> drivers.  
>>
>> But why should it propagate? 
> 
> I'm saying it shouldn't. The next NIC driver Intel (inevitably :))

FYI I already nack inside Intel any new drivers since I was promised
that each next generation will be based on top of idpf.

> creates should not report generic stuff via ethtool -S.
> If it plugs in your library - it will.
> 
>> People who want to use these generic stats
>> will read the code and see which fields are collected and exported, so
>> that they realize that, for example, packets, bytes and all that stuff
>> are already exported and and they need to export only driver-specific
>> ones...
>>
>> Or do you mean the thing that this code exports stuff like packets/bytes
>> to ethtool -S apart from the NL stats as well? 
> 
> Yes, this.

This was my mistake as generic per-queue NL stats went into the kernel
pretty recently... Removing Ethtool counterparts anyway.

> 
>> I'll be happy to remove that for basic Rx/Tx queues (and leave only
>> those which don't exist yet in the NL stats) and when you introduce
>> more fields to NL stats, removing more from ethtool -S in this
>> library will be easy.
> 
> I don't scale to remembering 1 easy thing for each driver we have.

Introducing a new field is adding 1 line with its name to the macro
since everything else gets expanded from these macros anyway.

> 
>> But let's say what should we do with XDP Tx
>> queues? They're invisible to rtnl as they are past real_num_tx_queues.
> 
> They go to ethtool -S today. It should be relatively easy to start
> reporting them. I didn't add them because I don't have a clear use 
> case at the moment.

The same as for regular Tx: debugging, imbalance etc.

> 
>>> If you have useful helpers that can be broadly applicable that's
>>> great. This library as it stands will need a lot of work and a lot
>>> of convincing to go in.  
>>
>> Be more precise and I'll rework the stuff you find bad/confusing/etc,
>> excluding the points we discuss above* as I already noted them. Just
>> saying "need a lot of work and a lot of convincing" doesn't help much.
>> You can take a driver as an example (fbnic?) and elaborate why you
>> wouldn't use this lib to implement the stats there.
> 
> The other way around. Why would I? What is this layer of indirection
> buying us? To add a statistic today I have to plug it into 4 places:
>  - queue struct
>  - the place it gets incremented>  - the place it gets reported>  - aggregation when ring is freed
(BUILD_BUG_ON() will remind of this)
> 
> This is pretty intuitive and not much work at all. The complexity of
> the library and how hard it is to read the 200 LoC macros by far
> outweighs the 2 LoC I can save. Not to mention that I potentially

See below regarding "2 LoC"

> save space on all the stats I'm not implementing.

The stats I introduced here are supported by most, if not every, modern
NIC drivers. Not supporting header split or HW GRO will save you 16
bytes on the queue struct which I don't think is a game changer.

> 
> I'd argue that anything that the library can usefully do can be just
> moved into the core.

I don't say anything from the lib can be easily moved to the core. The
library was started to reduce copy-paste between Intel drivers and
resides right now inside intel/ folder.
But since this lib doesn't have any HW-specific code I wouldn't mind if
any other vendor would start using it, and I don't necessarily mean
stats here, but anything he might want to.

> 
>> * implementing NL stats in drivers, not here; not exporting NL stats
>> to ethtool -S
>>
>> A driver wants to export a field which is missing in the lib? It's a
>> couple lines to add it. Another driver doesn't support this field and
>> you want it to still be 0xff there? Already noted and I'm already
>> implementing a different model.
> 
> I think it will be very useful if you could step back and put on paper
> what your goals are with this work, exactly.

My goals:

* reduce boilerplate code in drivers: declaring stats structures,
Ethtool stats names, all these collecting, aggregating etc etc, you see
in the last commit of the series how many LoCs get deleted from idpf,
+/- the same amount would be removed from any other driver

* reduce the time people debug and fix bugs in stats since it will be
just in one place, not in each driver

* have more consistent names in ethtool -S

* have more consistent stats sets in drivers since even within Intel
drivers it's a bit of a mess which stats are exported etc.

Most of your pushback here sounds like if I would try to introduce this
in the core code, but I don't do that here. This infra saves a lot of
locs and time when used in the Intel drivers and it would be totally
fine for me if some pieces of the lib goes into the core, but these
stats don't.
I didn't declare anywhere that everyone must use it or that it's core
code, do you want me to change this MODULE_DESCRIPTION()?

Thanks,
Olek

