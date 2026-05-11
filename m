Return-Path: <netdev+bounces-286573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AB5mAwanAWrlhQEAu9opvQ
	(envelope-from <netdev+bounces-286573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 11:53:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F50E50B606
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 11:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9FAF3025A52
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19843BD22F;
	Mon, 11 May 2026 09:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C3F6EtbH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466023BA225
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778492357; cv=fail; b=ATUcneuRflPMYgN53PucWy9XRdlxWxVvmC1QkX0Pemx18buG0A0p5+HnvWNLmg8ym4hzBg77d/7bYCEbjaJkfyWoTiDMQ3ZvB499ij68q6ReNze9BawMYUT2zaAicxZkOd3apjomXO1bvr1QvPmPh1077Xc2VnsztI/e6Z8BCnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778492357; c=relaxed/simple;
	bh=aWjsosnMELmSprlsoTdMSvVAlTK0aLAPcOPxnp9ABm4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FyGMTA3nDdFzbVaaXC6OAL68lVOf5xnycoddu5zr5d/msu5K2BMPDcNDnamnL9hMyTcjmi/gF17TIplKaOgypn8pg1zYvkpbY5wbK3gtHLsasrAAnuQ8gVBD7M/HNv+Wt+NdIBh0Nzz1hpMygIHT7WhCnsOjh0BIbbmDdP0SQnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C3F6EtbH; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778492356; x=1810028356;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aWjsosnMELmSprlsoTdMSvVAlTK0aLAPcOPxnp9ABm4=;
  b=C3F6EtbHNNVzbw+7wQv+JzhWzMAnqM/sRnJLPlpTM1FBcW9PACy6h38e
   tB6Oo7/+CykjPrAc2SYT5dxo6zv0sT38PJwqpFy9Fow8cwmy3k4e7mP0I
   UF00++318E0N5C8WzkiZcDIPn/zfgf2L27VVmVhTxqmSzY8nEu7z5XGfC
   HhURDloMtyiXb84jYSk+h7erSzViJpg6pCX5akrZQYG0Lru9D5JEmYNUW
   eyMjysrtKCxDO0fSg1aXMjwEC7K1p/2un4/FpW/LosIFimd0SfNHZr5yC
   CBWzKLLUWgFY2hb+gXNoppEusZYaJ1geHzmPONlEyaS9XCh+gqv81rtfI
   Q==;
X-CSE-ConnectionGUID: wha1tDzhRIC+OHL9OOxAiw==
X-CSE-MsgGUID: NEGe4C7ySuml8W1qL7c4hQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="79236409"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="79236409"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 02:39:15 -0700
X-CSE-ConnectionGUID: S2J6Z+vQQPCfQl880YKHbQ==
X-CSE-MsgGUID: 9ifyyDUmQjiq+Jq0NoXTeQ==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 02:39:16 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 02:39:15 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 11 May 2026 02:39:15 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.58) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 02:39:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XaYcIIszZRTs+9GeRqbb4CXjrFJaHGTHnhIpvbimrZESpnuT+5ZeratMrFpc4gkIVSgRkiIIVf+1VzmHnP0JQN1UeUs6pSjn/+A530ZqGXBEMSaHTymc01M/swBRdOxEV1DS4g2cuH8vTXJThG3B/yqtuN8B+xH62ESn56eGiMwoo4bpIVXiaMsowEHigVKkjnn7hMaNWhz5VrRYiLhqOaBoTEkytkjHIvStuhTLbvTJIyGia4zagk97BlFofhZn7rcsAR7+WVs/7puaAs+SrLiyadxSb5mZmbdO/6vuCooRBvsWgEHDo4m29doK+NUZhBxeaOLxlV6l6nD6fKslOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vocXZ1uEICsd0+Kq33Vj7xXpB+vI51fD7uvTBYj/dB8=;
 b=YVDgceyBEZiv69rvDdScN1ofgwhg91WCT9bTYWQtOpeS0gR5B3zTPsi+eKcqsYd5A4jZdMn57Ysjgrl0Zlm9N9CBNvdWdv9zJRktrR7wRJ0N/LsTEhBrgf7Z7jYtAvpSOuJ5UD9WvHoMF/Bp7pXih31R3MURzXXLVtY9WkKewmpoyr54wZPlBsvJumT5OwTLF+x0KSJ31bqBFV3Q6GFNC2g496JGbUTilyZJBNKIhzjj9Yfi4y4qRrcmKrk62nkAwT4Udh61PCIYsk1eTm2LQXlU6fCHCd2zqy5Kms/ks69cGtTPnW7lQyQxBl+GkHWQLEBqDgsOhuG7wQJbF7GcYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by BL1PR11MB5977.namprd11.prod.outlook.com (2603:10b6:208:384::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 09:39:11 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311%5]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 09:39:11 +0000
Message-ID: <f1b79865-7390-4512-aeb1-3aeac2c176d9@intel.com>
Date: Mon, 11 May 2026 11:39:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v1 12/15] ice: introduce handling of virtchnl
 LARGE VF opcodes
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Schmidt, Michal"
	<mschmidt@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Jiri Pirko
	<jiri@resnulli.us>, Simon Horman <horms@kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, "Richardson, Bruce"
	<bruce.richardson@intel.com>, "Medvedkin, Vladimir"
	<vladimir.medvedkin@intel.com>, "Connolly, Padraig J"
	<padraig.j.connolly@intel.com>, "S, Ananth" <ananth.s@intel.com>, "Miskell,
 Timothy" <timothy.miskell@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Czapnik, Lukasz" <lukasz.czapnik@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
References: <20260508124208.11622-1-przemyslaw.kitszel@intel.com>
 <20260508124208.11622-13-przemyslaw.kitszel@intel.com>
 <IA3PR11MB8986A9CD58E2977B0E79B8D3E53D2@IA3PR11MB8986.namprd11.prod.outlook.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <IA3PR11MB8986A9CD58E2977B0E79B8D3E53D2@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0184.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::7) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|BL1PR11MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: 739f7e5b-af2b-46af-7576-08deaf4127c9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: f6fuIaTKxRufanVsvSmvwoMf72dMxI2+NcAFsg7pTxLu0DlLaAQ2KOXF1xBoPnQu9QEJxDef/AjbXov7KXhaOnkWWlcv0bK3TtLGjQ3snUCb4iHN6a79UnsPWazwp9BYF7jrmOCAuRtln+Ny0liPDimcWDzzkU0XoECVKQWQQsvBC0NeHx8cFIkxjhDG8QLqVWxS0sKdbClPOOsJs78xHq5S2TWQFPJPRdIrE5K0BZjl6LMxTzMgC95Kzu2wNGDFX3cRQtjEooYYDj6cuz+XKDPJZ1k3GeYfWvePvnQgoE99dPuDqFqp1+DYDaEDQxh4jSLwGIq00eV3Lm0no5v0uUVwKz78Iojpxn5R4+ZHel+Yk/vxcT4M2XUkbYoqOCWKyM6LxBCdNPax98E8hHquW8qWcYCAGgjD82KTimAPEGVTqk+KzTFrsKV8HHZaboVjqGmNT9vl5fnjSO8Kr76uG1iJmaaG2GYPTtgC1Xn/kOMEBwyojScEArWnDNfORAxgdxKBr2pb35PrQDm49y4YvJjkKOJ1GlwjVgyBX0iB771eJ4hi3MrPUAov557gSn7kNlRHsBnlRGuZ9hwGMFfxtnzKFP/iTTgT9kdis/GaKrXVTLHMkKeOe0+K7Da3CGOyBCi2j0/v4RerzpVIl0mPtsVsBHQgKlOkxKViXjl/xgfyvbstf34QZa66vK4PG7/k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2JiamM3MUh6NnR5UEtMaUNGTGQ0c3c5NWIzUG5YcTFib3ZaZmptSksraWJp?=
 =?utf-8?B?Y3ZTeVRXazhjbFZmSWYyMzBxam9GSlo3djBpOVlaWDFjRmUvZk5QV1FkLzVC?=
 =?utf-8?B?TitVK3lycExvZEhOL05YSDVRbThXS3pMbGxYTXE3MHMwVzJGUWJFZ3ljVGMr?=
 =?utf-8?B?WWhHZ3Z1UWkyZ0VLbzIvMjhzbWdoZms3dnM4VTVwWHlUMThXdWVBaXJ5UGZ3?=
 =?utf-8?B?Snp3NXc1RndXMUNvbWRBYWNyaG8vdWJSY2M3RnBzcWZpQWtDeVhFR08wN00r?=
 =?utf-8?B?WDVlc3BQeEtlL09MREk5OUsrakJBc2hTSnpiaGNDZ0wwS3E1bXFvZ1pvOVA5?=
 =?utf-8?B?QTIweTlRaUp1YkRNUSt1WkZzcUQ0ZEF6MEVRVWY5RTBsL1ZDT0xKbmpjdlpI?=
 =?utf-8?B?YTgxZXEvaDRqaUFyUFBGZEo5bTgydDNYYWJjK1NNMy9odjdCVmIrV1J0bUQx?=
 =?utf-8?B?UE5ad3BvRWlPTm5DY05BeVZ5S29tTmtxRy9SUkpMcDJaWVdsYXFPMTlZeDFh?=
 =?utf-8?B?WlM2dE5mN1BReDRhMFdvUmEzSU1CWWdUL3NxRkdjMVFpSDhvcFdmRmZZbllj?=
 =?utf-8?B?MGxMWUt2S011OWVTQWNQMzZWN1U5MmZUOUhhVlFWV2xlTlpnUXBGb2ZubVRx?=
 =?utf-8?B?amtVajY5ZE9hRXZWdEE3bE1HK1QwTDh4dkZNT0VDeE9nblI2WmFsWTBmY21j?=
 =?utf-8?B?aVVVN0MwbmQxdUpYa2ptU29YOG01RWI1WFRqUTFvQVRHMFNqNVNlTzBZdHh0?=
 =?utf-8?B?OUxFRER1SUNFV2VEQzRWR0I1L0JtN1dwaXNVdFZ1ZHM1d1loK2xxREJaMnVU?=
 =?utf-8?B?YkZ0VWRwek5DaDdwRVJ4MU5UMUlDQmMrQTRpcm5tVFpVS0dKeFFaejBnTkNK?=
 =?utf-8?B?T2YzNWdDNlNkVXdFRmJPMTV5ZVhLNUFGY0srYzkrRUFaS1VpSnpweGxRbUsz?=
 =?utf-8?B?V3BGbmpZaTlNWXp4MmhWVnlkNy80WUZtcWpyOGszdHRXd2JhU3BGRlQxL2tw?=
 =?utf-8?B?SUxDUVRCZzVnQmtUanhPZFlCY3pqa0JJS2E2VTYwaUlQRW1zUlhWekRSZFpH?=
 =?utf-8?B?cUV6eGdOWWRKODB5Vzl6ZjlUQlBZc2podkE0SHd4TGsrUjN3RkZTNmo2YVhr?=
 =?utf-8?B?Rll6dFdEQnlKTDZyV0k3V3QzWVR2bkQ5cCtwbjV2SWVsLytzT3ZqYlhxSEph?=
 =?utf-8?B?MS9QdFBHODVlem1IbmVkUzhrWk5NYmgvVkN1RURCOEYzVjVaaXJvd05DOURJ?=
 =?utf-8?B?RjNTdit6c3pqalA3bGRubDdvVEdHYVJkeVc2RGFJUFVlNnQ3aXBJMlRnenlv?=
 =?utf-8?B?Mks2cklKd1d1N0NuYndUVTBiWTFDQ3RTbHZZNzFVK0RudFJjRmszampWTGRx?=
 =?utf-8?B?eG5RL3ZLY3FkeVlKTVVTUDRwSnJGc1A0a21KZjlJNUxHdEJzMjAvUmljanRa?=
 =?utf-8?B?cjR6VDBld1UvbHZwZ25ZNThoRWFvYlJndXJvbkVvNVR2ei9qdWl4OExXQ1ph?=
 =?utf-8?B?citEM0hyRE1HT21VV2FvUkxCUE5NUDR0MDExT3luYTh5ak9VclhwVVVxSGN3?=
 =?utf-8?B?T2NxcG5ZQTNkbUR4MC8vRHM2blFSNHI0U0VSK1ZlZ2p3dksveEYyZGJwb0Yv?=
 =?utf-8?B?RHRtamdDUEYvWlFRSFhSb2V0Mm9XRGtsUlJsOUtJL0dheUkrdHROMi9qZHIv?=
 =?utf-8?B?L2xnc2ttYkFCeGI5SXJibFo3eW1NbWRaaTFPVEUxaWNMVC9PZjVjSCs5YklU?=
 =?utf-8?B?TDI1Y3F3ekxVV2xBQkE2ajcvd3p3RlVBSG5mek01WjFOSHlrdnlYU1hxSFVP?=
 =?utf-8?B?RkFjNVVtNWdvd0c2VHVpWEFDUzg0ZCtHRHRtVmNaeVd5OTV0dWNpNGpDWG05?=
 =?utf-8?B?VGlkbm03akR0ZHZKUXIwK0c5cjRIYkVaazJwRVNXZ0VlQXB1Nk4zZldXLy9K?=
 =?utf-8?B?RmdYOVh6aUtlby9WNlJsak9WR01ramZzQThpcnFoZk9mWGJ1SDNIVHBTN2pv?=
 =?utf-8?B?cnFoMmd1bGhvVHVkUEcrOFZhbUdRTVRLUkRSd0RPTFEwMEtDb3BWbVhMNVdQ?=
 =?utf-8?B?dUdLdFU0ZEdLRFNVYjZmcG1lb1lodnEvMzlhRmg0OHB6ZkhTMUZwWHRTbTM3?=
 =?utf-8?B?N0N3UVNRRGhGa1lqTllra0dkQ2VLdm5EZG1VTitNYXhPRU83aUtwbys5dnNs?=
 =?utf-8?B?angzVWZ1K1VUNmsrK1JGSXFtU1BhRSthUTBHZXNFWnZBMzFzd09ld1FqcDl2?=
 =?utf-8?B?R1lVUmpCNG9VVnVQZVRlWjhkV1RycFJLKzJ5UkZzR2RvNExscHhOSUpDclVl?=
 =?utf-8?B?cHpuSmdOTW1YbkN4bXFsVnpaa1RDVGJHUHpJdmRCaEF1NVhYbnErdzEralZ0?=
 =?utf-8?Q?88HEPrB+SpngaRIs=3D?=
X-Exchange-RoutingPolicyChecked: Zg4lWcJjXhNShZp8dSDI9/H6cC3Nifcl4rX4sjBKWFZ5su48a2cO0jKfL4nGLdyaJ6HGCgIDb89iK1lbQ2QUlnZKfAB6+HqvSBCrzCCpWobpxPbpOT88TGwJoXpHGiMV6Wd6jErUr2MVPaNiR1vDoMca4nGZA7jkmg+hTZChnHcaL58gDPlOYlVuZRjvdEgf6SdW8pGU3ep5jEnDSrtDHH7W+8JYUu8D7mJ4NNesbeGD2S8cwbX6XnK41egUWCodzT4NXPA1LjFpciINxKTSaVsJOD/aO6qf0Hhuo8Y1Q2G2eW6oqjTABOMzViLL5EVQ7aY5WFrqTimOyWSgw2Q8+A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 739f7e5b-af2b-46af-7576-08deaf4127c9
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 09:39:11.0735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7+TRng1TXGeZltzxIxJ0Hlm1Iw/U3qs3oCMnSGxF27kbZW9K2vLHUvBIh2m8W5rYqWsVReIMQ1H1H0fTFobxeJYBta8IJiR7AHVLqFzOCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5977
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 6F50E50B606
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286573-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On 5/8/26 18:55, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
>> Sent: Friday, May 8, 2026 2:42 PM
>> To: intel-wired-lan@lists.osuosl.org; Schmidt, Michal
>> <mschmidt@redhat.com>; Jakub Kicinski <kuba@kernel.org>; Jiri Pirko
>> <jiri@resnulli.us>
>> Cc: netdev@vger.kernel.org; Simon Horman <horms@kernel.org>; Nguyen,
>> Anthony L <anthony.l.nguyen@intel.com>; Michal Swiatkowski
>> <michal.swiatkowski@linux.intel.com>; Richardson, Bruce
>> <bruce.richardson@intel.com>; Medvedkin, Vladimir
>> <vladimir.medvedkin@intel.com>; Connolly, Padraig J
>> <padraig.j.connolly@intel.com>; S, Ananth <ananth.s@intel.com>;
>> Miskell, Timothy <timothy.miskell@intel.com>; Keller, Jacob E
>> <jacob.e.keller@intel.com>; Czapnik, Lukasz
>> <lukasz.czapnik@intel.com>; Loktionov, Aleksandr
>> <aleksandr.loktionov@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
>> David S. Miller <davem@davemloft.net>; Eric Dumazet
>> <edumazet@google.com>; Paolo Abeni <pabeni@redhat.com>; Saeed Mahameed
>> <saeedm@nvidia.com>; Leon Romanovsky <leon@kernel.org>; Tariq Toukan
>> <tariqt@nvidia.com>; Mark Bloch <mbloch@nvidia.com>; Kitszel,
>> Przemyslaw <przemyslaw.kitszel@intel.com>
>> Subject: [PATCH iwl-next v1 12/15] ice: introduce handling of virtchnl
>> LARGE VF opcodes
>>
>> From: Brett Creeley <brett.creeley@intel.com>
>>
>> With new virtchnl offload/capability VFs are able to make use of more
>> than
>> 16 queues. But to old opcodes were designed with a max of 16 queues,
>> so new ones were added (by iavf/virtchnl commit of this series):
>> VIRTCHNL_OP_GET_MAX_RSS_QREGION, VIRTCHNL_OP_ENABLE_QUEUES_V2,
>> VIRTCHNL_OP_DISABLE_QUEUES_V2, VIRTCHNL_OP_MAP_QUEUE_VECTOR.
>>
>> If a VF wishes to request >16 queues it should first make sure that
>> the PF supports the VIRTCHNL_VF_LARGE_NUM_QPAIRS capability.
>>
>> Co-developed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Co-developed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com> #
>> msglen val
>> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
>> ---
>>   drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   1 +
>>   drivers/net/ethernet/intel/ice/virt/queues.h  |   3 +
>>   .../net/ethernet/intel/ice/virt/allowlist.c   |   8 +
>>   drivers/net/ethernet/intel/ice/virt/queues.c  | 324
>> ++++++++++++++++++
>>   4 files changed, 336 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
>> b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
>> index 1b56f7150eb7..5411eaa1761c 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
>> +++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
>> @@ -125,6 +125,7 @@ struct ice_vf_ops {
>>   	void (*clear_reset_trigger)(struct ice_vf *vf);
>>   	void (*irq_close)(struct ice_vf *vf);
>>   	void (*post_vsi_rebuild)(struct ice_vf *vf);
> 
> ...
> 
>> +/**
>> + * ice_vc_map_q_vector_msg - message handling for
>> +VIRTCHNL_OP_MAP_QUEUE_VECTOR
>> + * @vf: source of the request
>> + * @msg: message to handle
>> + * @msglen: length of @msg
>> + *
>> + * Return: 0 on success or negative on error  */ int
>> +ice_vc_map_q_vector_msg(struct ice_vf *vf, u8 *msg, u16 msglen) {
>> +	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
>> +	struct virtchnl_queue_vector_maps *qv_maps;
>> +	struct ice_vsi *vsi;
>> +
>> +	qv_maps = (struct virtchnl_queue_vector_maps *)msg;
>> +
>> +	if (!ice_vc_validate_qv_maps(vf, qv_maps, msglen)) {
>> +		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
>> +		goto error_param;
>> +	}
>> +
>> +	for (int i = 0; i < qv_maps->num_qv_maps; i++) {
>> +		struct virtchnl_queue_vector *qv_map = &qv_maps-
>>> qv_maps[i];
>> +		struct ice_q_vector *q_vector;
>> +		u16 vector_id;
>> +		int vsi_q_id;
>> +
>> +		vsi = ice_get_vf_vsi(vf);
>> +		vsi_q_id = qv_map->queue_id;
>> +		vector_id = qv_map->vector_id;
>> +
>> +		if (!vsi) {
>> +			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
>> +			goto error_param;
>> +		}
>> +
>> +		q_vector = vf->vf_ops->get_q_vector(vsi, vector_id);
>> +
>> +		if (!q_vector) {
>> +			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
>> +			goto error_param;
>> +		}
>> +
>> +		if (!ice_vc_isvalid_q_id(vsi, vsi_q_id))
> This function declared as returning linux errno, not enum.
> And in this case there is no reply to VF (goto error_param), couldn't it lead to VF stall?

good catch, will fix it
it wouldn't be VF stall, but an ugly "PF not replied to our request" msg

> 
>> +			return VIRTCHNL_STATUS_ERR_PARAM;
>> +
>> +		if (qv_map->queue_type == VIRTCHNL_QUEUE_TYPE_RX)
>> +			ice_cfg_rxq_interrupt(vsi, vsi_q_id,
>> +					      q_vector->vf_reg_idx,
>> +					      qv_map->itr_idx);
>> +		else if (qv_map->queue_type == VIRTCHNL_QUEUE_TYPE_TX)
>> +			ice_cfg_txq_interrupt(vsi, vsi_q_id,
>> +					      q_vector->vf_reg_idx,
>> +					      qv_map->itr_idx);
>> +	}
>> +
>> +error_param:
>> +	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_MAP_QUEUE_VECTOR,
>> +				     v_ret, NULL, 0);
>> +}
>> --
>> 2.39.3
> 


