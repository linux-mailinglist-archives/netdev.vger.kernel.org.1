Return-Path: <netdev+bounces-153049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B21019F6A6F
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D73188894B
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662DA1EF0A5;
	Wed, 18 Dec 2024 15:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GwJaYGXf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CA619B5B1;
	Wed, 18 Dec 2024 15:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734537140; cv=fail; b=rF5EjPLaa2kH7S3DWXshdo+ko93VGPGNx5lO9y2R5m7QCEf1BpWXxi7mmVxa6KDh5G7ci2jl9boJ0bB0YXYIY/nGzJEHvV+4a8vCDYBahTOeaObgIxFeqmCA6pJgX5UgOei6bB34X3wBjE3eZU3qnuMRebB3yNWvy0UiHeT6Uxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734537140; c=relaxed/simple;
	bh=b1v2f9KJjlI/aTQJxGFuEt2hhOjW8eMgtN5SN/S6tR8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Od3Cc+USLnDhMRbU6LVceJZLQRxYNwy7Z1jiLtHK7RLpvZaoBzxv7PspY0HvMtKT2TWiaqLgS7LK8hv1kVPN1AWRjYRq04Y/TvJBMmstF97Z3SlUYoj9eN8NoXueZQCo799JSDwe3/KcVcNwfHal9p5Lb6MN7Rw1CLnazJuzZRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GwJaYGXf; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734537139; x=1766073139;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b1v2f9KJjlI/aTQJxGFuEt2hhOjW8eMgtN5SN/S6tR8=;
  b=GwJaYGXfiPjsqiyVvF+Q71dpG1VvvMwbb31HbLuacH2mCTH2sfmzmcrQ
   HY2it1IcLxlyNnEj0MVncNc86XVkeMjRc6vED+TPfZDjCeQsImcJwmPsw
   cV955ioCVsHgHcM11B+vC1qgEXwy1/07IEX+TfjMGjCGdqGg9/dLLAfCO
   kAw7/wT7CeMmSAJoDsT40Vwv09YlrdVr8yF5OX8LrFS7M3QByEfifwrjz
   hfRoERq54vwMG9qMWAO0eCCtBY3uCRvSd6NG6MMktzTxpQ9zbsk5MJffl
   3JmiFyk1QwByjR22b5EsGGt76crysOroNr7PSwV4bdGUdVIvZyB1Sidyi
   A==;
X-CSE-ConnectionGUID: jWCf/1RKSBK/j8+kNBZxXA==
X-CSE-MsgGUID: yosEn3WcRxOhuh0z6ltG7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="34739822"
X-IronPort-AV: E=Sophos;i="6.12,245,1728975600"; 
   d="scan'208";a="34739822"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 07:52:16 -0800
X-CSE-ConnectionGUID: gU8ouQLET6efPcefR7H5AA==
X-CSE-MsgGUID: fGLs8PQpRoWlk/A2jMXsSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97736331"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2024 07:52:14 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 18 Dec 2024 07:52:12 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 18 Dec 2024 07:52:12 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 18 Dec 2024 07:52:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=natJhOj923FoSDVySKqd8yb7DluKJMrAT+28wsaJXWTyNbb35ojBzLjw4FIDF7qwE1NaYpJsSVcy3XncV3krOH8nLgA+l96mlkRSnhjFLqvqy1LaUFDt9wQKvJh8afH1zGnvrksfLxEFnllOnpHfFF7ABMEDRgYBqsJo1T/USHU5wH9zKlf18XonAblE089muBjrB/XD+LAHIjzs9d9BYUhg/AAQ9pKRZhCxR6cTWW2Y2jaBh1f5aw0hy8OekADTTV0zOsxKyC82MDuXpxmFXFH9ZI1zDPd6WrkwuUD26Uj9lBqyjPLTz1Tn08WAxcNbFVoP4DwAJjko63Vyk7guMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7lzmI3A5krx452nlPvM+Rh51ku9i3OHu5QkT16ZfQc=;
 b=mLq09gJUlMIiQdmvpUSjUGjguw4YfvUUjY/C5aOp/ydtF8Oe5/sw8lw4aehVOoEbNIpozUcHae0b2jTSurv2NgJfXrhZJmey5aqJKoVMEwJnyhi2zarsps1LldPxGmmLe6STZiHNTlPKT4JFQCmQQ4qy7m49AFGcdF8yubxmy3jGpUs0VS6fXgiGuzdCKw12dnzeovzTFX3n1tZuhnYmbtocNDpKTvzevqtedbxlU2D759Vyibcjou7gqyGnfYwO3+kspY1/va1H5zghlUjVraZJCXAn5HnhthypVe5tNu6nj3YEQL1+juPHPoy8H4Tl10imj6ZALORvcN1TNiPUIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA2PR11MB5018.namprd11.prod.outlook.com (2603:10b6:806:11a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 15:52:05 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8272.013; Wed, 18 Dec 2024
 15:52:05 +0000
Message-ID: <e6d4fa08-b0ce-4014-a8cf-3d7a034c99a1@intel.com>
Date: Wed, 18 Dec 2024 16:51:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [net-next] ice: expose non_eop_descs to ethtool
To: Jonathan Maxwell <jmaxwell37@gmail.com>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241216234850.494198-1-jmaxwell37@gmail.com>
 <aa49d578-dee4-4ee8-b17b-b6e941d9126c@intel.com>
 <CAGHK07COaxjj4WJvDKFLj=ev9j-jRxuw5bXh_zCZtL75Twu7rQ@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <CAGHK07COaxjj4WJvDKFLj=ev9j-jRxuw5bXh_zCZtL75Twu7rQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZRAP278CA0002.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::12) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA2PR11MB5018:EE_
X-MS-Office365-Filtering-Correlation-Id: ab0517f0-0355-4aa1-067a-08dd1f7beb65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmxiUWhEWHRtd09lU3NzTGZod2VpOWZGQk5PS2JNQmVJSVlYbWN0MlpENnVh?=
 =?utf-8?B?NGxsYUN1RFk5MHZTcnFmVWkzWTR4bWQ2bkpGcXdLRmtVOWs5QTVaZ1ZDU2p1?=
 =?utf-8?B?VHdHQTg4L3ljUjZsaHZpampaanBWaGt4YjNpWHRBc0NKQ2Z5eENpMjRUL1F2?=
 =?utf-8?B?c0NOck45YXlPSkpiTjJnY0RDNkcySWxJa3VCekVCbEwvRkhqMld0S0o0aVdQ?=
 =?utf-8?B?MHlBUjcrV1kzdVVzU1RhQUFzc011MDh4a2oxUDN4cFE3Z2Nma3NRMXlhLy9C?=
 =?utf-8?B?VUd1VnZ1NThUNlIrN3puOGJ3T1ZtdXJqVjAxbnJYc0xUVk85WHd1b2hwOXBr?=
 =?utf-8?B?cGRwc0ZHanVvdHF5d1FvS2tEeE5IYTcvNFNxd0dkYm03L09kbFRiMnhjUFNu?=
 =?utf-8?B?ektFM0VLb3I2cnE2M0lzSmF3UXU2VC92ditmV0svWkZub0ZZLzBVZTRuby9u?=
 =?utf-8?B?WFM4bk1SVW83OUxBb0FMcTI1bzhVQ0RGcElxVWF4MkdMZHNzVXA3T2RVY3JO?=
 =?utf-8?B?UWJUTzdKNU9EMUJrM3ZrTm5YQUo0UWJPU3ZvcDZXSEkwUEt2Z1B6NkJFWXVh?=
 =?utf-8?B?VzloVVJMa1RZMkJvMWh1OW1mNmV2R1h6YjNTbitWSmxSZjdTcmMrMHNOSVRl?=
 =?utf-8?B?NWczK3hQVFZrSmdKTHNrQnR0RTVHZWlNZkZNUXdXSmNlcms4ZTAvZ3pHWUtW?=
 =?utf-8?B?eTNGZzJCdDVtN2JyWU9TaEJ4NTh5NFhFRm40aUJmQzBQYWE0cDFQQXpPbzM3?=
 =?utf-8?B?d1pjWnYwcGhuK0FvS09BaFhDQ2hIaGY1ZnBtaHZDcXVBV1ByTk51cnUwZUxJ?=
 =?utf-8?B?dVR6c2FGQjl4bTBqSEh5Q1V2Ri8yYmhWUGx3WlQyQTJ3OExWandUdUt6dDQy?=
 =?utf-8?B?dVo3WU1jSDBFd0U1ZURMc2ZXaG10RVJmRmtkMVp1WWZYTFBuVVhHUjNuSE42?=
 =?utf-8?B?MnpmdkdVbUpTZjlBRlNKSDBVVWc2S01tTzFiQTE3dURHRTRld1lCZzBJaUxv?=
 =?utf-8?B?bURNRWFOM29LdG5Od2J5MXdhNWVWcmNSSE4wZFVienBPdVl2S3lWVGhUT3Ex?=
 =?utf-8?B?dGgzVDFEb1pIOG1pTGNhd0tVQTFPUXQ1VjdXbmRvOUNiUUlVdDJGMVhpeDl5?=
 =?utf-8?B?Q3NGSUdUd0svbTBrYVNqNmVaaFQ0ZHpCZlplQ2loVHlVQ2o2NmVOQnBIYTVR?=
 =?utf-8?B?cmQrTFNway9UMzRIWnQyRW55QlB3ZHROQm02WFV0VmR5MnEyV0F4VHRyK3pv?=
 =?utf-8?B?dTZ1UFM1ajRiMjFsZTg4ZEUyYUtoUzBUQ1ZrR0NrZGVtKzJBcVhENTFQSmRm?=
 =?utf-8?B?MDRUYlhYZFo4MWprSE5NQTU1b0x4WjZyTHc2V1FVL2RiNjl6ZTcxTVdUYkpP?=
 =?utf-8?B?NWk0NWEwMU5pbWpTSzV5bnQ1RGI4amFweVlBaFFTT3kvUWdsOTBrNTQ2L1RG?=
 =?utf-8?B?Q21pV1ZBVGxTVDlPd3V0aTNVMkxrK01IVW1nVnRWeWlsMkRJSzk1VERmaGdL?=
 =?utf-8?B?bk5GSE4xdit4OXQ0bEorOVZldW1yMHJrUW1ISXF4QUdtaVkzZTdTdjlaalZ3?=
 =?utf-8?B?NFhpZUQwcUVRY25Ydk5hYnNxSWVRNmxtY01aU2xGT3ZzUC8rR3h6MEY5N1Qx?=
 =?utf-8?B?Tms2TDJxWDJtZllLcCtJTTJOeDNFN0RJUUZ3Q01ITHpwdzZyTGJWYU5UbzZP?=
 =?utf-8?B?Z2tBemx5OVpmMVhsRlF4ajVrTHJyYXE4TDZPRVlydTlNdm93NSt6aE9ZR2dZ?=
 =?utf-8?B?SU84ZDRSbVdmYit3d0VBL1lya0FhL3R5cXpBUDVxVjdYR3dsOURTakN4bnVN?=
 =?utf-8?B?QUJHSUIrNHNDTFFGamoyRkxJclpSMm9hVDhCVVNNalZ1bzFKL05Ha2tZSXEx?=
 =?utf-8?Q?n+euRzx2c+I3H?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0p6UUIrcDg5elBvbHlBa1hBYm1KMUt0T21LbngwTUJvTnFtYnJob0FSd1lD?=
 =?utf-8?B?SS9sSHZvZXN0MDl5NWV2N0I3Z3czVis0dURpbkUyQU5hZisyTVJGUkhNTUpD?=
 =?utf-8?B?VFdJOHlRb01vZ0x6d2MyL1pISitxNXFna1IzVnBkcVBiaUErcEZOdTNnMkJP?=
 =?utf-8?B?Qnl3YjRKRnZrUDBsa3ZoUHJOZnFOTE8rdXg2ZnRGekNFZGhTb3l1b2NsZHZ2?=
 =?utf-8?B?VU9EM0ZoZHYxeGpmc2FzL0cwN0RnNnZURGIvTjVZTndRMko4YzZSVFJ5Nkhk?=
 =?utf-8?B?VE1TR3k1dzJUVUpTcUtjK0hhRzZNR3BPSElDN09FemxDNWQwTlQyRnVFZEtr?=
 =?utf-8?B?dUpxVkcwNStiV2hFVWxLSi9xbElIMFQwcWdhOXJQRkNlZWxZcW10a1FiTGRt?=
 =?utf-8?B?aUVMOGh1VnRHT2ZnUTk1VVZtaGRvTzVRd0VMSkJvNUp5OUhXb3dUSktIQWZR?=
 =?utf-8?B?YVlXK1I0YWVzK09Mc2VNYkpOWEoxSzgwb3Z5UnFpNVg1NHZNR0RtQXczZ0Fr?=
 =?utf-8?B?UE84d0hQR1dNR0Z3elpRbnI2bE9JVFJwV1dJSVRISHYvcXVFUCtKMnUwclR0?=
 =?utf-8?B?ZWVBc2lyNW9iU1dGSnJJdjhndDRvNnZnTUxtVm9SNzdZdEE0RVdtdW9vZlpa?=
 =?utf-8?B?bFNHdFZ1eU5VV3JLdVpncTV3TUpObWRKRGY4ZEVtMVQzQnNTeFYwVGpkY1Ay?=
 =?utf-8?B?R2g3NHYzNmZoSW1sckhUUjk4bWpGaUxiWkZTQUN2Y2k2SU5nejNZTzJyTUx4?=
 =?utf-8?B?VTlWVmRSc1FJOEFKTGZ4bE9zL2VRZDNBU0IrdE1QSUQyTVRGbFp5Sno3akU2?=
 =?utf-8?B?V0k2WENqV3hKSUttZkNnbm9VZm5rYjI4cUtOT3JEbjA1dGdLektkQ2JKdHNF?=
 =?utf-8?B?YzZKQUZwbGVLWnFzM0lRK1c0WDRGM0o1RkNIS3k3YkY4eVloWFNIbDQ0KzZG?=
 =?utf-8?B?RXAyNFppZ0xvdzNqMEhIQjFFTXBqQzI1VGdMaXFPMUhlVGxEN1I0Y2VSVnB2?=
 =?utf-8?B?SG5weGVhYnZsbUFiSU1pVHUrT1FOd1k3YytUSUVnWTVTS1BUL0NqWTAxRkxU?=
 =?utf-8?B?MFpRRFViQ29qSmtaVjREVGRpMnJJMXdsVHBEK01yQ3lqVW9vbnhtdXd4WlRx?=
 =?utf-8?B?czFjVm0zbzkwSGFkcTJiQXdDUXZEMDdkTlpjTUNjVE40WGlDa0kvU3N2VDlJ?=
 =?utf-8?B?NlEzRCtZMGdSZ0JiNXFJSlI1UHQ1L1lHZVIvNEE0bUEzYlVZbTA5MllSWUY3?=
 =?utf-8?B?dzNmZVFFRUJrRmlHTFVtcTBRQUNrUmJTMlpKNmRNY2wxZUtHUGtvVW1jcUdH?=
 =?utf-8?B?bVgydVQzS2xuNjI2bDB1TEhzRE1YZTZzOUdNeFNPL2ZyaFZUV21jb3dudTlF?=
 =?utf-8?B?WmxLS0RiYWtCak5FRmlSQ3FKT09Ka2xackVKRGl5RHMxSzQ1WVdsb0JMZ3Bs?=
 =?utf-8?B?Nmh6b1FjcVQ0WDRleHVya1hmbkF1QUVQdzA4Vk90ajBneVdyVzZ3dGt3SjJs?=
 =?utf-8?B?dHA5WUg3SFUxalJ5MVlGNDZLb0RyalF4ZzNueUxINVV6VTdxMWlqVGFiL1h1?=
 =?utf-8?B?bU05bzVheXR3SE95Mmh2MWkveFE3MXpibktZNmNQOFEzODZVT015d0dxV0dF?=
 =?utf-8?B?dzN3WFlzZmxaVkNucTNvRnJzdEZRWnNTNnZkRkE0SktLTVlBTEZrMlN3WlJm?=
 =?utf-8?B?T0thYjk2VnpXNXJ1Nkg3alI1UWJUWGNGWk8rQlVvQkJwOGhLMTZjSW5MRjhS?=
 =?utf-8?B?MGNHcVFEZXVTVHhReW9IMFZGSjZHajJUTkUxVGhaNG0vcm9Rc2VCckgwOXFY?=
 =?utf-8?B?VFFld3djb3VDRjBDdHJjTUFERytUVWhTemhyZ3FTUXQrYkdFNHlzUHhjamNz?=
 =?utf-8?B?ZGhqazNKY0V5Zll3aXE0Wkt1bWtCZi9Vb0xLeFdvR2tpY2Qyd1MwOWUydFFr?=
 =?utf-8?B?cVFrQWRXTnZSem1EWlRqVGxlL1IwWlFwU2VwaGQySkhLbHYvVHV4WFJDSUdB?=
 =?utf-8?B?WlRSd3Z1cEFveTc0bEpmQytXbUVBREZtL3RjTmxSaGJvUUVka2F3SFBTMk5N?=
 =?utf-8?B?T3YyZ0FNNDFiTnZwTXpicWtsbkNCbkF0a01kWEtBVUlWNVE1bFVKWlcrS0Vx?=
 =?utf-8?B?SllYR3pEdmx4R0NydnE0a3BHNGs1YXB6M2drYnFYS2k2cml4V0QxYkxORVFj?=
 =?utf-8?B?K0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0517f0-0355-4aa1-067a-08dd1f7beb65
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 15:52:04.9816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xU3nA8XPh7lbzwoW3yjFUgqNt3SkbXobvU/T7QUUogawQ36m+EzKNV5aUywS009SEZA7XGovsTUUx2kfinQ97/t72SX4OXNRhg3sBfCJk4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5018
X-OriginatorOrg: intel.com

From: Jonathan Maxwell <jmaxwell37@gmail.com>
Date: Wed, 18 Dec 2024 09:13:00 +1100

> On Wed, Dec 18, 2024 at 1:49 AM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> From: Jon Maxwell <jmaxwell37@gmail.com>
>> Date: Tue, 17 Dec 2024 10:48:50 +1100
>>
>>> The ixgbe driver exposes non_eop_descs to ethtool. Do the same for ice.
>>
>> Only due to that?
>> Why would we need it in the first place?
>>
> 
> Not just that. We had a critical ice bug we were diagnosing and saw this
> counter in the Vmcore. When we set up a reproducer we needed to check that
> counter was incrementing. I added this patch to do that and thought that
> it may aid trouble-shooting in the future as well so I sent it upstream.

ethtool -S is slowly getting deprecated, I wouldn't encourage exporting
more new stats. The best thing you could do is to add such field to the
generic per-queue stats and implement them in ice.

> 
> Regards
> 
> Jon

Thanks,
Olek

