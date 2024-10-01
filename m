Return-Path: <netdev+bounces-130975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8650E98C4EE
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 19:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA34A1C22186
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 17:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7291CB534;
	Tue,  1 Oct 2024 17:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VY/kicSN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56DD1B5820;
	Tue,  1 Oct 2024 17:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727805420; cv=fail; b=aM19xMjbWLB/dCLfO60Vw7Mkht9JfxoyB/pP+bQMcps4Wz7MvHytpt6hfY0VRSsgLDcQbLY4L2I4Gp3vkpVGl6JcYPeSaNmW/I4I8s/CqyxtwpsF/rlkxG4e47kxFRqncapK8TvjfY360mMDmriq2aPHoDrnpUdf6HbuIkCRfIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727805420; c=relaxed/simple;
	bh=0ju/5v/r+riVitsN76KSrSi/hv5yCyk0+L+sf5ccdQI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MIa/WtMVQ+zokHcNtJbgNyiWxTeQZW3fMtrZJFudU6RGZn7UH5+0by5BefP/tWso0ebMFlh5UU7CEZb/dUNr1jZfkBxDaoNPldbD8qNZvtH93/+/ufiw6rl8GzPmripmxZhd5b59unWjx5hivs/PsxKlrOdPYebYJvkB4MHOt/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VY/kicSN; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727805419; x=1759341419;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0ju/5v/r+riVitsN76KSrSi/hv5yCyk0+L+sf5ccdQI=;
  b=VY/kicSNmt37SBq+Mp+HUXLjjazYYPcXeF80KvOXuXK280jamGyjuLmv
   sUqQi7WABhNiR6TWawWmSCwdrYmJyPKICMv3PSK9XEUDDApR8PaqfcIQ5
   tW81AQtlVgrCnmn3yuZkuqjE33tGsWjeA2/tRdlEdFWukdkZ8aNvEujAx
   6jUvlMovEblFmVHwGftj08XfJ9BDnzmR2N4IF3KfHNamVeGTWADzqoDRv
   bybqPmIcbw7wHBS0W5xyqpN/7uPHDuDIITO/tDKkWp8hBfuluFD8MGD8C
   uciYt6iY2r1Gk2oAifO6zhgUVZL+wAAooqwBiLf36xU/EulNh9/1lMjx/
   A==;
X-CSE-ConnectionGUID: 3bg/Cdh8QDCi+B6g0It6Uw==
X-CSE-MsgGUID: BhjtnwyUS7+zHWoGF3sFAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="26839313"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="26839313"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 10:56:58 -0700
X-CSE-ConnectionGUID: pSmjwhBaRka5dk48OdJlTg==
X-CSE-MsgGUID: WTunDuWxRYGfBQ/iHep2eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="73356190"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Oct 2024 10:56:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 10:56:48 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 10:56:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 1 Oct 2024 10:56:48 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Oct 2024 10:56:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gm5IMbWmQ2HSeABRCj0SDhM8xTuMwBetEaGuDnqjs7Zb7TsJnAAIM8c4XGuWEaLZXIehdmDErhIeZ2BubuBQpbJ2BlOfpHH5WUsNwzW966NenXTIruQYceex6r5ErHLVOlHmkDJJTEBFVPS5YVC8jmQOdUVS3arsjF9krqsIf0Qq0IPwQBBrgDL0mEJ4Iury8B+aw41n2inaOam0GxhH+64WdoiwD/bq6HMGLjJ0fygoYi9ITVNc7o18yxzEVkvgKUlUF6/NWtCGvQII3a7gy9RRICn/Qy8zT9Y3LBRTt+g96c3FiwagYiGCUhX99gpe3KjSym5XSJDVCCo9+dsCZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=544Z0uNxi+ugB6RzgMhb0qqHkvhLoVS/6/G1CPJCg3E=;
 b=U7U5HImDXQJbXTcGFdaygi3Q8/jDhcMhTeSOugnrWAfi0bPqlNxqnbzK9z/wNsZE7nc+nMUqoWifXD/1sxfnEqqt0zaFiXTs/uHtUL+zBFAZg3YMrcuCj6yLWh1J8gIHYoXEXAaWydhN6vq4llYQnfo0/a3OYyI80gxnZRtuoPdpuE1wC2y7whGY8LpUnJazOAUtPONNytkBBVtoXxXpYVAVwIplGhYy5zOfIewjVdESukLhTj3x4iq7AguUsTyi34P0xn38saH+SYszFmZnq3ep5NYaM9Kv9yS8SEEkKYCPPIR8raiqpocu5AFwfrpy/kVBc2sjqYNA3WTJjz9edg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MN0PR11MB5961.namprd11.prod.outlook.com (2603:10b6:208:381::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 17:56:40 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 17:56:40 +0000
Message-ID: <cadefecc-44aa-443c-a412-723cab46eea9@intel.com>
Date: Tue, 1 Oct 2024 10:56:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/15] net: sparx5: add constants to match data
To: Daniel Machon <daniel.machon@microchip.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<horatiu.vultur@microchip.com>, <jensemil.schulzostergaard@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
	<horms@kernel.org>, <justinstitt@google.com>, <gal@nvidia.com>,
	<aakash.r.menon@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20241001-b4-sparx5-lan969x-switch-driver-v1-0-8c6896fdce66@microchip.com>
 <20241001-b4-sparx5-lan969x-switch-driver-v1-6-8c6896fdce66@microchip.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241001-b4-sparx5-lan969x-switch-driver-v1-6-8c6896fdce66@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0335.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::10) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MN0PR11MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f70cea3-d877-4598-2893-08dce2426709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWdBNHBiTW5YMjhHNWtEMHByREl4aG9OcTVyYVRtUDVmREZiQ1A3S1Q2Wjc0?=
 =?utf-8?B?UmVxS01QYkd5TEcrMVFnc3YzM1I4YlZ3QVZpQU8xdXJ6YzFXQmZhVzhpdEVh?=
 =?utf-8?B?MGtBeDhuQUJYajRpRDN3Z1h0c1ZXRGlOY1VVNnNHZy9SSk12NHpaRzZlOVJJ?=
 =?utf-8?B?aHptTjVrNjlVOHh5dFUvaFdpaERydFBLVU5pdDNYejBFSDVKWStjQ0V4eG9t?=
 =?utf-8?B?ZXpoS3l2RDg3Q0MzUkk1MlJEZm1PSk5hQ2pDdHpzYmdFYnJ4cHpJcHJLVm5u?=
 =?utf-8?B?dlVTdFp5YzI2MWhyQXZVM21GTkVmQ21nNE9KcW1VNlJvNXRFMVJtMGp6SHNV?=
 =?utf-8?B?T2ZDZi8vclZCaG9EQ0hkRUw1b2hRajNHYzVKTmZ1R1RyK1NZNlBqRHphV0Zh?=
 =?utf-8?B?bEFyVkRnaFNVaFAyM0lRMXdSaC9VWmNrZ1FxVXA5SFFXaDdESzNzbHJXekd1?=
 =?utf-8?B?YzJnMEl4dmtNdWtBYzJPSUhWeWlRQ3ZkVDlrdWVnVjk0QWpsaG9aTWJkRnJ1?=
 =?utf-8?B?WnErRjk3blRIcTc2UTU3YWtqRy9rRW9WSnJmMERlSXRsb1p4eExRTFJUVW1q?=
 =?utf-8?B?LzFyZGJnUDJaRjEzbGZOM0JMZnJaenJBZjIzVHNsR2U0ckJXNGNKSnRCRVZQ?=
 =?utf-8?B?WEowTFhhdmhvSTZsSklNQjBDemNHVEErZGtTbEJ1OWt1VzQ0eEFzUVRGWUlI?=
 =?utf-8?B?ZGVKS1YvTGZYVmVzdzhYYVg1OVlDM0x5WkNoZUNsczIyMnhLSDhRNTNFWlk5?=
 =?utf-8?B?VXhrTWNGcTF5Q0MzdklCb0dLOFVEbTlSeW9tc0pTbExvL3RKdkJIR3pjTHVV?=
 =?utf-8?B?dkZjcTN0aEh0VFIvbkZTY2hmTU1ON2hMMkxZNFNzckJ0NmRlL3VsQXRENTB6?=
 =?utf-8?B?a0dicnhMZXY4NTM2YmpNMlZtQXJzU1VzZENOcWdnMWQrcWdRNkx4ZFp2OU95?=
 =?utf-8?B?QzlkaGFhUjRPMGcrWmtWcm41ZWRrajBiU2tBQXRCTkZJei8zM2xjV3Q5ZFAw?=
 =?utf-8?B?UFpuTFdkajNQVGRkQS9QYzJBN2JIeDZnbHJuV0tmYUdDWWhCejhtWXFHNDhI?=
 =?utf-8?B?WkFtbUFBM1kzRityTFpKV3V2YlJML0dhNzBTak13ekpaOGxKMmlmWnpmQzlS?=
 =?utf-8?B?Mm5nQW82YjdVRS94S2gxVmdnSzNrNkVkRzF3WVloVDBhYXA2aUNtTlErSS8z?=
 =?utf-8?B?akYwM2cyeGlIOUF0cFZCdHRGSnVUSHpXc0w1QU5PSE50WnI4NjBpSnp5T3pL?=
 =?utf-8?B?aWduOGJrSXNNUGlpQWRscTZONGdxd3JOaDJ4RE95dHJhLytVelpJeFBEQlVu?=
 =?utf-8?B?SHB0cFppak4rS1pkdHdyZ291OVM0ZVh2UExHRiswYUdzNG5QY0dtZTlkOVNZ?=
 =?utf-8?B?aHMxUzc2V1VwZCthRWloRk96Q0xoblBOUUMyREczbklJNkRzb2hDYno5YVJ5?=
 =?utf-8?B?SkxkQUp5TG5RVGtaNCtGQ2xNdDhVKzc3RXBuYUZubHFrUUdabFExd1dZck4v?=
 =?utf-8?B?Rk5OREsvVjAvYXhsYmpXYzJnUW10VG1pL3lMUW0xV1NIa1hRNms2dk94TElj?=
 =?utf-8?B?VWszNm5qYmJBRk9yWURpMEQxZ21PSEI4RHNIUUhJYWs5eTRKejRPbnFLdTQ2?=
 =?utf-8?B?ZmdRVU5CWVlmRzZjUHlVVytOMDM2S0pwZHRkTmtXcXl4Ly90eWxaUmdvdFZm?=
 =?utf-8?B?K2k2Z09VOUsrQ25iR1dmRlFWVmZXRXBtZ3dUcmk2dlJ3RnhxOE5sWEkwSmg3?=
 =?utf-8?Q?f0AAIoO5WbFfpjESLzKQHA60BoursuUxJA5tshs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3RVRWdqUDUzRFFYZ1RNWkFWdEVGbWlGeHZmNUhoVHBlM0c2UWVSRkxvR2JS?=
 =?utf-8?B?c2xqaGJlQUowYUZCZ09YYUNWcE43UHgyb2FGRlBrQmpQdkl0dFJVVlJmOVdi?=
 =?utf-8?B?SDBRQUhhWHp1ZjVOdDU2L3AyM2QySlJkWmkzRGNwZHZUbE5wK0lycmZVMCtk?=
 =?utf-8?B?L2MyWGcvaGgzaXJ2c1RsYzJHd29lRmhVbXB5eWFGTFZEZjFSK1diS2tZUWpl?=
 =?utf-8?B?NjhWSFBwYkorK1JTUElPU0pqeEppSlM2Z0NtbkZCVzR2S1g1amJpTEYyM3FN?=
 =?utf-8?B?aWgwbFhrWitGSUl2cnVyd3Vwb21DNkIxS1U3R1JqMVZKV3prQU5LSlNqT0tk?=
 =?utf-8?B?RjAwQWRQTnlXYXFQZU1sbjBDN0JKbUQrMTVuOVpHSXZTNUY0MnV1WmdTa2ty?=
 =?utf-8?B?QTNqTHdNUmM1aUM3Uzl5R3pDZmt5Mm9nVTVkL0c0WWt5Z3VRSjA4WnRBeTF3?=
 =?utf-8?B?RGZzbDNkS09hRVpkayt2bURNaGpaNUJIK2lYL1pJRmJjTkRuSDVzY3I5T2Nq?=
 =?utf-8?B?S0RwMHc0YWxEc1dMTFlBUURmQ1pJK0pIZ2xjYVE2MDExTHZJRHBPQmlvTjMw?=
 =?utf-8?B?N1hqK0lOZmdsWWNGWjlHbUs1RUhiMUJoUTVZVUxaTnFDaml2djExM1YvZHN6?=
 =?utf-8?B?RUZ1Y3FLVU5FSkkzaTNjTXIwWHl0Y0FFSjdRUDNhYlAxZmh2Yjd3a1YzRU82?=
 =?utf-8?B?WFA1emYrbnRLMzNlWkZLMVdxRmNsRGk2QUFPeXNwWk9lSnIwNktsWEYyOG04?=
 =?utf-8?B?QjAxZTZtdS9iSWRHRzhwQnNLdTEwYk55SllRYXhTdjRlWmhzcVF3NjFwOVg4?=
 =?utf-8?B?dGhnN2Z3MnRSTXB1VE10Y0kxcGRadlFwR0pDNDYzSlNBcTJWMHFTRVBqcWNh?=
 =?utf-8?B?QTlUeWQzVFRWK0ZOaHVNUUcySTJjV1pGQ2F6ajQ2YnNqQzVFamllUHlNOTVW?=
 =?utf-8?B?NXdad25HamNuc0szWmt2L2p2ckcwMXluNlJsbkgvdkVPY3QyamdZUHNXdXln?=
 =?utf-8?B?YU5UTTJUOGFGZGcxdHMzNVZHMW5MQjhOZU5Ob3VMQitPLzlIaGFGVVUwdktG?=
 =?utf-8?B?eDJTdVRvZ2hUK1FockNLSXR1NGRMaEUzVUtwZ1NMaFEvM3lmYkEwUXRWdGk4?=
 =?utf-8?B?eWJob20xanRSbmJWeXdiQU1zVUlxYkRIYWxSbG9yTU5adlZsVnR3TnpaaFZa?=
 =?utf-8?B?enVrTHZkMHVvYThzcTZyUGk0QkhZU29nQ3l3STBnR2J3QlV2dDBGUFIyTlR3?=
 =?utf-8?B?ZXRHTTJzdmhzYWlldHVUS3d5bjk5dks1UlpjbXZDd0hkTUtYaVJaRi9aQmR3?=
 =?utf-8?B?WTE4MG93aXRiTStPQk9YTzlES3BzaU1EWVFGbTN0azczUVBoSFBhQnVTNExj?=
 =?utf-8?B?eElGNmszUDF5OGhGTzFUcldCZi9pa0xBekxkcVh6RkY2NG1Pc1VOQktyRm5v?=
 =?utf-8?B?TDF0NWdNaXlSS3cxV3lZalRJWmdvb20wdDlDbjIwMC9sOFBqQThrVE5janlw?=
 =?utf-8?B?dzZBOWl2SzFKNEM2RmRXWkZPdmYwRWtCa1hlUnFVREVxRFVHWlRpS3daZmc0?=
 =?utf-8?B?Q0V4dGlMelJEb3paaTc2djR1czZjWDBLME1Cb0RKTmkrVHI2eVNtTm9OZVVZ?=
 =?utf-8?B?ZGtGbnFsRHpUaWlLbytUMWpYcDYxd01aUUc3Z1NnL2drN0pBbkt1VkV4WjlU?=
 =?utf-8?B?SmFjVkZVQVRqMGhWSHhJU29zajdBemI5akV4dzcwRDdTSGpHTXZZUnovc0JS?=
 =?utf-8?B?T250cmJ4OGo1UXpPeWd5R0dnNitvR1h4M1FvZVZJMlZNc2JxU3JTT1FzeXBp?=
 =?utf-8?B?RE5MNDNJNjFXVjBFK1VUN1FDVURrWURRUEtZanBoM0lqTVd0OGF6WjY1NlB3?=
 =?utf-8?B?ZHBzbm1tL3NpbnF2VWdPNWs5YzltUXhpYkRSVzZWRExTSmNLM2pxTnNVdks0?=
 =?utf-8?B?TGNvcFFaR3hhTDV2TnFxT1FVUzMwR2RqdTk5SEplaXZsVmF3M1Q1K05GajFi?=
 =?utf-8?B?VWNmTVpGMFBaeWhnVlY1cXFtWkRMVFRXdnNhWkdNbndERlRNQVAvUGhuSnFZ?=
 =?utf-8?B?WU13bFNtK0xvYmdIdFh3bHhUVEh2MmVqdEFRcGJxbkFVekZiQVJTMWpDeU1K?=
 =?utf-8?B?QjZCdTRaa1hCdUZ4cEJmajNEbVFEZnFJU0g4ZUw3QVdyR1RaSzhsL1VpNVAx?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f70cea3-d877-4598-2893-08dce2426709
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 17:56:40.5024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IxPu43x9cCQGPssxyu525SHbHNclqDIalp0nrdhwV+vmcdFVP3foQwSpEVxT1GVQFTy//373+bkE2HAw8RsaWO5fXCuqvcFqaeeQPXVIDUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5961
X-OriginatorOrg: intel.com



On 10/1/2024 6:50 AM, Daniel Machon wrote:
> Add new struct sparx5_consts, containing all the chip constants that are
> known to be different for Sparx5 and lan969x. Also add a macro to access
> the constants.
> 
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> ---
>  .../net/ethernet/microchip/sparx5/sparx5_main.c    | 21 ++++++++++++++++++++
>  .../net/ethernet/microchip/sparx5/sparx5_main.h    | 23 ++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
> index 9a8d2e8c02a5..5f3690a59ac1 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
> @@ -953,11 +953,32 @@ static const struct sparx5_regs sparx5_regs = {
>  	.fsize = sparx5_fsize,
>  };
>  
> +static const struct sparx5_consts sparx5_consts = {
> +	.n_ports             = 65,
> +	.n_ports_all         = 70,
> +	.n_hsch_l1_elems     = 64,
> +	.n_hsch_queues       = 8,
> +	.n_lb_groups         = 10,
> +	.n_pgids             = 2113, /* (2048 + n_ports) */
> +	.n_sio_clks          = 3,
> +	.n_own_upsids        = 3,
> +	.n_auto_cals         = 7,
> +	.n_filters           = 1024,
> +	.n_gates             = 1024,
> +	.n_sdlbs             = 4096,
> +	.n_dsm_cal_taxis     = 8,
> +	.buf_size            = 4194280,
> +	.qres_max_prio_idx   = 630,
> +	.qres_max_colour_idx = 638,
> +	.tod_pin             = 4,
> +};
> +
>  static const struct sparx5_match_data sparx5_desc = {
>  	.iomap = sparx5_main_iomap,
>  	.iomap_size = ARRAY_SIZE(sparx5_main_iomap),
>  	.ioranges = 3,
>  	.regs = &sparx5_regs,
> +	.consts = &sparx5_consts,
>  };
>  
>  static const struct of_device_id mchp_sparx5_match[] = {
> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
> index 738b86999fd8..91f5a3be829e 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
> @@ -51,6 +51,8 @@ enum sparx5_vlan_port_type {
>  	SPX5_VLAN_PORT_TYPE_S_CUSTOM /* S-port using custom type */
>  };
>  
> +#define SPX5_CONST(const) sparx5->data->consts->const
> +

I'm not a fan of implicit dependency here. Whats the reason for having
it done this way vs passing something in as a parameter here?

