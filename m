Return-Path: <netdev+bounces-254381-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLBmNHFJemkp5AEAu9opvQ
	(envelope-from <netdev+bounces-254381-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:37:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4495BA7040
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDE093060D22
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 17:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187CD34F241;
	Wed, 28 Jan 2026 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LKaniPPl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36D5313527
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769621612; cv=fail; b=KyHnamW2oqXpk9J6sIeibwwlHZVTY6bUiP/e9YL2o3lDsH25g+Emt2jT9BhwywBmH2eyP4d0CcEGVDJ39rxaG77owC97UDP4j3cgyVgnDV+fa0JnIg57fTuknajzWZy5+sy0LF3dX0FyH9swah9pBTEvHpaCpw70JZyFKp6NGLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769621612; c=relaxed/simple;
	bh=yPWsq3tJZb2lcqBtHgmYMoV6SjxOGp8j1TRHh6/32Z8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g51YQYp26PJqoC+ZLCn/FlkWNlEGdc/ZP7CsccAy/GJPqsazwvbZaI9+L3Aqo9m/PPeozzNxw2p9J7NtZUeGp4oto0qr8IT1/fcKZotN8Gf5U/hex1yQ/JzsWvtyERyM4mZfcNBb5XNKKR8IDIfJEhewiExzi47HmrKjieCQS2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LKaniPPl; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769621610; x=1801157610;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yPWsq3tJZb2lcqBtHgmYMoV6SjxOGp8j1TRHh6/32Z8=;
  b=LKaniPPlAaT45ubZVGUljf6i7wSo/37PcIY+MRfW2PaPY5bEp4bkdlwM
   VSG7lM2oV8HjcGhuHYRqKhDfsWmgeasWHZJKOmpQI1h1yOWhJnzVAtTd+
   hUDHihLi8CNMAGSUNCyDDVMaj6gpDQYKsD6rF2LmHNS3P2KVAmRwB0uRD
   ZB9lleMPoMIV3vORF7b4jAecHEGFo6USo4XLhX4GXFYqDsdTxsuSpf40q
   EHmPcUN9j08LFW7Uu02Yq5KhYYBpxWjqE33yUwBtv5M+o+wDSzTZJllfa
   FVr7lxxqPSO6ApXgWUBa83x/OStdXQCk/GNOInXPH8ybpiVHFwzLnZTz6
   A==;
X-CSE-ConnectionGUID: G6erXSBER02MGUODGElvOQ==
X-CSE-MsgGUID: 4aXYK3wCTICuUDhWYgzWOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="82269922"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="82269922"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 09:33:30 -0800
X-CSE-ConnectionGUID: 8HrmdwQBSSWh/fj1w9vADA==
X-CSE-MsgGUID: C8H9rHvDSaefBO93AFAamw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="207459433"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 09:33:30 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 09:33:29 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 28 Jan 2026 09:33:29 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.37) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 09:33:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMbeASRqAtjpsJtf1fnIAPGnBf6NYCLCf4E8d2wcy5fTlHH5RvP2y9887NiAh0n4KWCTkulvS8ZxFPm6w0YEvlfitGuJXEy/R72dbZMZRi9ndQgc4WLhj8mSgPcFtgZgtXceoozj2bJF26gNZkW2QfKs75TMkzQhJdCKAD4/ok+1CWQKoJh0OTcOKuvatnx3BgBgY2A90Gk7WmuYET/MWX4o70N89CvDbZWPDPDTU6KVEcqTMrroPlhWzAvlaHYV7qXOSswwAPjgtawDtn90fd5ca9ihElGr+y/1X4Izx1Fd0QHgmACLht4nqDZdI9JWu0UabECOGNN4TtlZHuH5QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbDqnwNTCEnvKGvc1AVlUvxZu2jUOJso+VQc2HVmRH4=;
 b=iBnxMugqeMcy80aerKZyL51NqjILNh8MzeT2S2jhrZgu15UZFiuS4AL0/OkBXTKyyFk4VxA6PuFcSDNIDVtDR4SWAIZCC/aACRJqMg1yHbJKyCI/rBOkqqiTLv/JV7bFOkr4lmpZwtwZq2ukq6RhgALu35NCnZ8AVzJpfPwoDZgHDM+9b85cAmiRB5tA5au8dRmnql9fu3QO3Gfsv9a9PCvFZCqzqZVz54gO0qEldEdGlNEXeM8phq/EUIWrgcYBHkEtK+UdmwZz+RqRaVotjzpnlDEYQBHTC2ZRK/pHvdEajX23ugrsO7Dor9ZFbVwDF/jq8zqj6ZxXw6LT4qSvqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by CH3PR11MB8590.namprd11.prod.outlook.com (2603:10b6:610:1b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 17:33:26 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21%6]) with mapi id 15.20.9564.007; Wed, 28 Jan 2026
 17:33:26 +0000
Message-ID: <59b428e1-dfed-4e80-be62-5c4ee4469e8a@intel.com>
Date: Wed, 28 Jan 2026 09:33:22 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v4 3/3] igb: allow configuring RSS key via
To: Kohei Enju <kohei@enjuk.jp>
CC: <aleksandr.loktionov@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <enjuk@amazon.com>,
	<intel-wired-lan@lists.osuosl.org>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <piotr.kwapulinski@intel.com>,
	<pmenzel@molgen.mpg.de>, <przemyslaw.kitszel@intel.com>, <takkozu@amazon.com>
References: <f521fae5-54d7-4a8a-a190-80e29b6275d8@intel.com>
 <20260128060958.6333-1-kohei@enjuk.jp>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260128060958.6333-1-kohei@enjuk.jp>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::31) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|CH3PR11MB8590:EE_
X-MS-Office365-Filtering-Correlation-Id: 85fc328b-27ef-4761-b296-08de5e93580c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mmt4YlFBSEFEUDNXWmdNaHdWVDBpdnNvcjMxRzlxTDJoeEFDT3dkMGpmRlk1?=
 =?utf-8?B?VVNHR0ExYzUzbGZ4aTR6OG5DQXk3UmNzMm8xTTJjSGQ0WXZkYU9zY2Zkd1Vy?=
 =?utf-8?B?cHNlRTh6Zi9VZ1JqS2xRQ3FQRGRWRjBVOVpsMEs5WTQ3QnZpc0FxVCtzeUNV?=
 =?utf-8?B?YTR1akxGVjdPeXI5TnBuNDlWYnk3QlpXMzJueGl1alFiVlkyQmJEUXR6TTR4?=
 =?utf-8?B?cmxENjhVajgxUHcvMGlUOWcvRlRkRlJmMTlSZWY0dUM4bXJ2NFd4Q0s3UE9Z?=
 =?utf-8?B?eFVsbW9Od2toZ1ZlNG05VUphSVlkQUJOeDBMREQzNjRqL0cyRmtGWTRlYWpF?=
 =?utf-8?B?M2tObFdpWGFjRGczQXVQWXJVa3VkVE5PV3RYWVFndm81WG1LcjJGZWN1bHBy?=
 =?utf-8?B?eTU2aGx1Qi9TRnAvY0RBa2lwNEl1VFk2SVlmRnRhb0NvVzJET3cwMlNSZGVI?=
 =?utf-8?B?d1dUcW82Qkx4aVk5TlEyUHN1c21XaE9IcHRqSm5xbkZuRXBXNUhsSkFFOXdZ?=
 =?utf-8?B?V0drTE1IUTBRekFvaDQzTnh5Yi83bmI1Qi9jeDlpWTN4REltQXBvU0lTQTRE?=
 =?utf-8?B?dVFyMUNaTk1NNHUxWUU2WVRRWnMzbkpOeXMyb3FuNFV6TndkNmNwZ2VhRkxv?=
 =?utf-8?B?ZmN2Ynl1TDlnTFRHWjZyaGVRa2k3SzFtdU05SkJzRFgyMnJDbWNpaG94cVJ1?=
 =?utf-8?B?RUVZcCtaaEE1Z3RqL2dTVnVMeUoxa3pQTS9CcFdER1Q5bkoxY2pnbk1Dc1p5?=
 =?utf-8?B?eHd2WW9RMTZwZnYzd2tNT0l5alNEVDVGWlF3bkM3RkN3Z2xLWjhnMG9yeFdl?=
 =?utf-8?B?Qzd1M2Y1WG9xRHhuK1QrdTBRSE9JVEM3MkFBWE16YUlRTmdMMWpnckNGZ2sw?=
 =?utf-8?B?Zm1aT2J3V1krd1dUTlR2TUFzY1docHdrOHRKSStTQUhubUc0eUhBNjF2MWJB?=
 =?utf-8?B?Q3VwNE52dVNoMDJuejBMNjZWSmprbXVLSVlQTUpEMXlzakVyc3p3cUZCY3Bl?=
 =?utf-8?B?NFQ4b0dua20raVpZRURVclNSRGJST0s4bVN0T0dxMlZmcDYzVS9MeHpGb1hj?=
 =?utf-8?B?NlpWYXFNSWEzMWd5dkJVVDNlb3FiS0JvdHhGQTRYZU1WcFFJcmcza2NrdkFa?=
 =?utf-8?B?TXpzOFZlcEVwaklNeHVKNGYvTUZUV2VvU0tSVzdOb0Q3bHFCZ3hTMFRwSGg1?=
 =?utf-8?B?cEdUY2ZRaWNOb3NkMVFHQ3VJNkl2OTFJU3BPcktkWmc1OE9aY0ZiZmgrVW1h?=
 =?utf-8?B?NHo0VEdkWStnY1g4VzA4Z1VENlZwejFHN0Y1MEMrcXVxYlVQMVhabHJ0WHY3?=
 =?utf-8?B?MlZ1VTJzY2FhUGVBS1dOWUdsWUgyaWNtWml5RjVlVUxoc2hLclJqTDNOODRY?=
 =?utf-8?B?dy9ZNzBFMmlaQW9YK2ovTCtKNEQvdUQrMUZ1VVdIN0J6S1dUVzUvc2JSdlha?=
 =?utf-8?B?VXpSRVdrVzlqL0pHRHUxcEVQYTNsZFpRNWxXeHErOW5SMDdEM0hnN1NFZm0x?=
 =?utf-8?B?VG5HVkg2a3BQdk8yeWo5WDRiUWFXd3hJWUFPdGtEa2JoQXk4ZVNaaU1sa0JF?=
 =?utf-8?B?eTZZSExybTh6OTlNL1BTSnFxazRWZjdQV3JSVVdOK3Fmb3dxdnRrNGxBeHpU?=
 =?utf-8?B?SVpONHBLc1Nsd2xZenViOFk3NW9qUE55QVR2SUJjYXVnblNVUjYxTm5mYm1s?=
 =?utf-8?B?L1lsREtSazBNSEVNTmNlR0l5V2N0UHlZWGtDUGhkR2hMYWdZeUVlRUFiSlFp?=
 =?utf-8?B?YXlwdnZHa3d1RHRsNHdoMTN5WEp5bXZvZ2ljTGhuZW9sOGJYV2lYL29jVC9K?=
 =?utf-8?B?cDFJRHVCcGR5UlR0NzVnNGpXSVgzc052NGlFQmRWVHQrU2lGUlJ3MGlqRFll?=
 =?utf-8?B?ZDF5Rzc4V2oxdTdSSllQWWZYL0dGWlBDb3JrSmpGUkcyaTJjSHB2N1B1NUpr?=
 =?utf-8?B?U1Judk5WUENrcDVSeDdkQkdXMS94emFZV2I4cVI2MnZzOGp0UXRHbmVoTWJh?=
 =?utf-8?B?MEdDZ2JLUTVKa1VVUUZ2YVU4a24veExpSFNNS3VKc21ZMUQ5NXRkVFJGMmda?=
 =?utf-8?B?YUZLeXJvaVh3RlhHbDNwNVdxdXVwRXNsa0dpZWJkd2xhYXBrY2E4blV5Qnps?=
 =?utf-8?Q?8RA4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHVjeE40MTVUc2RwdllITWxOWTR2c2JCQmwxN0lRMGc5a1l4M0RwVzlYSjhy?=
 =?utf-8?B?djViTDlJTi9aQTlQTGorNGJ2eklkdXVwcGdNdExrc0wyd1BVcHRFN0xOMFZJ?=
 =?utf-8?B?K3cxaEMydEdJOVZ6RlI0K2pEU0VyY01Kd01ZZ1lTOFVjaHRwTlN2VW1Od0ov?=
 =?utf-8?B?Q2F6aGhVbWsvRUQyamdTdFBQTHdJY1F0TEE5clVxS1pGN0E2NUpmaFAvV213?=
 =?utf-8?B?eVA2NjZxYUpka011alZxYkxJOUhVYWMxMGZNQlVOUHRMRlV6R0Y4a1BsbWxM?=
 =?utf-8?B?VVo4MCtmWDN1UW1XVnB3b1hvSGFrcXlSV0VYNFhUcURPT09HRTVXdDJ4eEFx?=
 =?utf-8?B?OE8xOWtmYzZmS3BFUitsczlRYVdMUnBMNHErSjZBd2IrcnpqRUJyK1ZYeWpt?=
 =?utf-8?B?K2dYYkVjYVp2L1ZJZVVqQ3c1RUJtb1RRc0FQQXlaM2NvOWJUV0kvU2NvUFpV?=
 =?utf-8?B?Q2p0Wk9wWGVCVmZxRnNOR1hKVUxTbjRjN2FkdEw5MEdoYkliU1FheFNqektu?=
 =?utf-8?B?Zm1VQ3lNMU54YlNjUjJML1g1aml0aDZPYytraGpTQUY5dkppR0VDZ0I3c1JL?=
 =?utf-8?B?cDkrOE1vSktyZVcxRjJuR0lxaUJzTGJUU2UwNmRyREdOMW02cHkrOC9YcXMx?=
 =?utf-8?B?Znoxbm5pN0JRdGY3aWo4ZHpFb0Q5N3ZOb094SjFWSmI0UVVIUlBrYzFRUlY3?=
 =?utf-8?B?c2twQVlSMS96Mk5IdmhSUnFPMnJWNU9uajdaZzJjRVpvQkNvWVNkRjUrbHlT?=
 =?utf-8?B?WERiUnREWXo1N29jR0VDQWhxSG1XdXBaeFhPdmtxL29TNzFIbnFmbDF5YU1H?=
 =?utf-8?B?c3JQTmUzNXJBUTZsbUhzQ3I2aGhYUlVXRmxnYjZtRDEzcDQyRkNXbzlqbERX?=
 =?utf-8?B?c2VHTUhyTENpcVJuSGlwZWNocDg3bnpWVnJuamUvd0xZaEdyQ1NLUHF6NzJ6?=
 =?utf-8?B?WHQxbTYvOUVZK0xRcmpDOG9jTytLeHA4WkxKdXZDOEFrRDZBRE0wQ20yNDJu?=
 =?utf-8?B?UXRua1JvM0F2bnVHTzllbmlNYXRIdlAyUndNM0x6cm9GMVEwYUxaRVh4QnJM?=
 =?utf-8?B?REI3clVQQ0QrQUJRYldYeGJiUm50VHZySUlWLzhIOG1ZdnM2dmorQ0lHa0Vm?=
 =?utf-8?B?VFBWTFlJMld6dFFRa3Y2YU9kWWRGZS9Bb2JRZVk1ekM5eXkzbTJkMUtqSFpR?=
 =?utf-8?B?bTZhU1F0QjZuRlBhVWVVWnhPbDI2N0VJdlJ1S3M4TW8wK1E1bE55QnZ6cDhw?=
 =?utf-8?B?MVU2YnFkS0FFRXRGVU9qWjJ3ckdpU0FxWXpMS1FRaVJNQkF2NTRWZFA0aUtO?=
 =?utf-8?B?TEZtZk5lajg3d3NnSVpBRGFmQisyNHhaWE9NZzRWSmFESlJhbzRIcHc2azQx?=
 =?utf-8?B?V2RSTFlKRmVyUWNTZ3ZnWGdvWjZUMGNqQkJIYmloZHY3dnpKbVM5MUZ3Q2Zn?=
 =?utf-8?B?TDVoaUdnMUdhMmsvZldJUk9wNDltT25vUlUwQ3l2ZEVEV1RFOUM3dmZweGsy?=
 =?utf-8?B?Mk5VQlVEc3FCSFFIVUtDMUhZQkl0ekE2TWtESGFyb2hXMk8zL0JOSWtWWDBZ?=
 =?utf-8?B?dzV6eHFjVFd6M0ZFZW1QVjREbU5TMzJtc2UzcGNROStmUEtjVTZpMXBiM3o0?=
 =?utf-8?B?bWJ3aHF6cUVqTExWeURrSlhsZmkrZ0MwOU5YSHVkMUQ4bGp5aWk2ZE42bFBa?=
 =?utf-8?B?Z1pzMmEySm5VSHo3S01sd0tsOXozbWIrSUdpcDVtbnZIYmVGaktaOHp3OVNS?=
 =?utf-8?B?K0VWaWRvZWJZeWF1M2drT1JKdUdHdGU1M1lwY3N1YmZ1cGxHM1ltUGF5VXBX?=
 =?utf-8?B?N0ttQmpkRTdpR21rNk5SOHpPRmxTM3VCUjdyVnRjVThTY0JoRVptZEhJazNm?=
 =?utf-8?B?NkpMRUZPc2tPbnBONkcvRjRqZHRmZ2t0ckNOSm9yd2JxZFowNEhNRUh5d1Bi?=
 =?utf-8?B?TXQvWG5xUWhYMTNtY2NNTXNsTFdMU3VLOExackJlNGNJREZBNUJjMzBmeFg3?=
 =?utf-8?B?TVZxM2hEdGF6YTRpUzNZTzg4bGVuZ1dLZHQ1bFg5UVRxd2cxb29TQXdxWDFs?=
 =?utf-8?B?cUdJeFozQ1NJSWNQY3ZOSWpsYzRleEswTWlna1hIZ3NGK0psY09lUjJQc2Rx?=
 =?utf-8?B?ajNoTm1Kalc5Vy9zQjVXbytnbDJHb2RhOUlpQitxVmZLUm1PZXlHL01KZnJy?=
 =?utf-8?B?b1F6endmZXdXelNUeUpEbHZsVGU0eFY2UzdOS1JHYVlxMnlXTnRqN2lJQjFU?=
 =?utf-8?B?aHZVOFl1NU1zNi9WMDBKT2V4MVUyc2RkRWVYdU9rNG0rbmN1UThEVUdEOW8y?=
 =?utf-8?B?VCtVWkV6VXpMb0VSUTNrZVhWVnN0SGF1ZWtlejRuUXBXMTJFVnU0VXV0T0RJ?=
 =?utf-8?Q?DDYTL3H6vY+9GJPw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85fc328b-27ef-4761-b296-08de5e93580c
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 17:33:26.7181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gGly5m8RF4i2Np5Ut7w6WyavqWuvHIOAqY1MHP4wZ+8XgK6Ha5mjcnZlmQlT5lsSuK+8Pr/qFVZZ6AIDSLrGiDX2U+eFAr1KYx0JWIP9Gn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8590
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-254381-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 4495BA7040
X-Rspamd-Action: no action



On 1/27/2026 10:09 PM, Kohei Enju wrote:
> 
> Yes, you're right. I'd love to do that and post as new version,
> so could you drop the series[1] from tnguy/next-queue.git?

Done.

Thanks,
Tony

