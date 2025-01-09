Return-Path: <netdev+bounces-156750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D41A07C5C
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC51D7A4B20
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 15:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BA821D5B6;
	Thu,  9 Jan 2025 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RkhjU6zV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3947F21A42C;
	Thu,  9 Jan 2025 15:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736437600; cv=fail; b=a03CnVTUykpNXJkjfAlbwzfUlw9+VVPd+eFTS1t8gtKojJ7Thss9jMS36PwTazvRggst7ceBXLWO5gLn43Ezff5iPlRArJ9MIW6lWrvKUse0slakXhczc6ND6PzrBhuqGp42stV6BxUhWecBDVvwRWKS4/u6FhJsxaMXh2m7TNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736437600; c=relaxed/simple;
	bh=pIT545q/QZqbG4JeroTffycsJWANa0ySbw5lxhfa/iE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ksqMVWDAlDEME96APFnDvKN0egUi2pidzJ5GirpoItNoidecShR9qJ3UF8b8/zqXyO7XuPtQ/yccfcM3WGJlcfCgmkG0OuOTg0ELC1vws+FXRPaLpxd93/gn/MInao58kFhQmO7mvKfkv8NcA37MDilNRd2IWjAd18gJm3ino/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RkhjU6zV; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736437600; x=1767973600;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pIT545q/QZqbG4JeroTffycsJWANa0ySbw5lxhfa/iE=;
  b=RkhjU6zVxKk2/CsEuo/agZScmc9p0iv/zNJFw3CHDtJJ/9QgLYVDgljk
   D+J2f6h6eiTcA0AUSh08Yrivez7mMUdHzPxgaqc4PvMWraLcDSeOwFxeE
   RZRhfjsv9JzUm9v0+rFxWqsyGdURlytKwcKaf4T36K/i5Ccjs15CadlRb
   s6KIABS3VDufGMupRbS4kRxAI6JDiZG46e+P8INxMo1ntayElGm88EvA6
   wp+AOX4o9Zsf3p0gzRdZ9g8FEY6ToJQb8AUUDvnkyIiOy6kIrD8A7Vs9e
   8UbvZliX3o2rnP2gGuFJlmlHd37LNpfdLc5qt/D9P0YF1pEwVhKIFsfAe
   Q==;
X-CSE-ConnectionGUID: 9ON3QC+ySOelymdYTYMbKw==
X-CSE-MsgGUID: EhBUun0/SYesLqbx7vlUIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="47695448"
X-IronPort-AV: E=Sophos;i="6.12,301,1728975600"; 
   d="scan'208";a="47695448"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 07:46:39 -0800
X-CSE-ConnectionGUID: KpAt6BcgTv+bGmDAqeYJIA==
X-CSE-MsgGUID: FDNcHHp3RRu/OIvCoMH6MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,301,1728975600"; 
   d="scan'208";a="103246184"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2025 07:46:38 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 9 Jan 2025 07:46:37 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 9 Jan 2025 07:46:37 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 9 Jan 2025 07:46:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jE55SXeGFDA4pzIzfAWuYm+Y5xD9eiY2RVc4waGjo8Rj65RJPpiyhIoReS8jzQBSzWEGLrq4uh++JNr96DRTbl4TYbBV/FKoYH27xm6KjUY7qT+c95wJKfeibOqc4OTPdp0Q/uXjf/Z7ZxqcJcdFU3qFlkMUK/DWlb/snzLrBwnwn5CxYLFKAWGrDLPbMmzhKaG/SplpPUfFusbGLe/tDJ+gHWLHOHJbU8xOd+VYVWRl2oo+TPtMkWqFCZfwTPel2kUVLbn76wdtwFV9fkG5eb8RO0gVlkXrvjOwn08yg8pOdHpVHNGdK1R0GFBd4losOyFzlnK+wFlM9Wc2ktAcSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuzim0wKKLO8sypZlpVNdwuuOGrIoqbffF6oz84c1Qk=;
 b=oPZuKE7PK8by9HHQvvQTexwTk5hbdWwaU2CKKrErh+fx8bvq7wpbwmDB9emr7zvm8zPtnO2BCIJb2PoOgoXRLNgUmQgqGq4xnk/7VUnhk30jS/7Z/w5Si3Q1E4ZvfWQP3bXqD99Y+zd7EuS9q9fUsqIT2fyLgkSuQ7/PuqC3OOEf1ZVo7vg/b+zk5Y9KistVoKQBzgK+Q9GgvdofFQDHoiYU2w28KV9zG5yJWD1h/Mqr9vxEQUuTS7y/VctAkTmh5hPGgEzDYTkWt/wl1AQ/mCkVtQHq8KEa5zNzynCBqdre6m82nKY9EukAoZoDCyGXgp1qcfvDnx+byexQ7qMMzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SN7PR11MB7419.namprd11.prod.outlook.com (2603:10b6:806:34d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 15:46:07 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8335.010; Thu, 9 Jan 2025
 15:46:07 +0000
Message-ID: <dda98f40-6964-464c-b468-61fed67e0e96@intel.com>
Date: Thu, 9 Jan 2025 16:44:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] page_pool: check for dma_sync_size earlier
To: Furong Xu <0x1207@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>
References: <20250106030225.3901305-1-0x1207@gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250106030225.3901305-1-0x1207@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0242.eurprd07.prod.outlook.com
 (2603:10a6:802:58::45) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SN7PR11MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: b76adc46-9be3-45f8-a42f-08dd30c4ba8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MUlPcTlsS2Z0VGQzeEI3NE5nOHl5Sks4SzFqK3k3VGtCb0o1U2kwVU5GM3o5?=
 =?utf-8?B?UHVEN0ZmZmtqbUlReHZGVTh0Tm42N3pyL3JndXNEK3dPRVdzWS9qaXZqTjVl?=
 =?utf-8?B?aTZvRStYaHN4YTBqZE1ncEZpeEVoWHNJRGFMWHhESzlTdW1veTlLb3I2M1Ns?=
 =?utf-8?B?b2VpeE1ZcFdpQm14SnY3Y29VMGJZRDdHa0ZlQUJVb2Nsayt5SEdRVHhzR3ov?=
 =?utf-8?B?RWJKc2laTmxEMVE1SFl4WVM3S3BueHZySGRPMWxENEprTndHL0JITXI1RHBn?=
 =?utf-8?B?aEZ6YW1XL1ZMMUhEOFR5T1V0UnFjSTdleklwa2tRQjR4b0dncWJUMXFEMVJX?=
 =?utf-8?B?WTg3a3AxTk9IR2NFaUlSN0hmRk5ZR3BmSy9kdG9aT2dkcFRIS1kwQzB4ZlRm?=
 =?utf-8?B?cis4OXBUdXRMZzZaSmEwV0dtU29KNGlkdkFDVkh2cDk1Q1duV0pnaW14enJh?=
 =?utf-8?B?aEI3d0JiRzd2aDJUYWkrWjhvaVZyMmx1YnB1cHdJUkpsQUpJci9zOU96eXN0?=
 =?utf-8?B?S1BQUGNNa2NES0VLcWxSVy9TbW81c0xDcXNIdjZGNG5Xd3J3VFk0ZFFUQVZF?=
 =?utf-8?B?ejh1QnZHMmt3dllUSjFsRUlEUDFOMFQwV0hXczhpbXoweDNOUnlLVWZhM05Z?=
 =?utf-8?B?NmNvSkU3clE0V01JaDFIL0hLdXMwdjZnWVd2K3pkeVQ1cFBmWVhWOEFDYVNG?=
 =?utf-8?B?M2kxcUx1blZ6YWUyZjZ0Y1VGQkdLTnJqMzg5aDlMYzcrYWR0cjRXM1RQeDFl?=
 =?utf-8?B?UDBqeTREZzNPYmUxNk56K040WC9hZjl0M3AvVmM4ZjhVZmJtcEFxZzJ0VDJ2?=
 =?utf-8?B?VFc0T1k3eXc4aGk0TWFjekNOL3Y1SkgrMnIyeWxFaGp5QXJzTGRzbmhnREhw?=
 =?utf-8?B?MUZUdkN1WlJxLzRla096NW9LM2QyQUZ4dlNNOHdURXJMVEsvTEhyTWp1cnlm?=
 =?utf-8?B?OGU4NTJmMEhpVmxPczBua3MzR0RIMm5TblRCOVc2U2hzZ2p0RUpvUlhWd3Zs?=
 =?utf-8?B?c2R4MndmQ1N2KzhqS3J0VHluMDlWUVVTaFRnWEU2RW1XNXI5NGt3bDYwY1cx?=
 =?utf-8?B?bnVDVHc0Wmc1K1BXV0swZ3U1eFIwbFN0UGFZV2xHcTJORFJpUmVETW9uYU5q?=
 =?utf-8?B?bnVTT282SkloTFZSTS9uRDU3dFh6TVJpQ3A0QkhzNDBBeDJ1cHBxNktjTFI3?=
 =?utf-8?B?b2FBNnhCbklwU3pSTzRTRC9OS29vWlZmdUc5YlM3L2g1OWYrS3BzOWJ6TUtW?=
 =?utf-8?B?bzI4N3c5K1B6cmVPL2VjWmdZUCtyOTR5Z3NaaC9EcGluVlZEUHhndTNncVg2?=
 =?utf-8?B?VG5EaE5ncXdpTVprS2g5NWVTSXQ5UHRqNllVYTJsY2FJcFc1Rm5MSjRPem5h?=
 =?utf-8?B?eXJOZEh0eVVMMG1hVlhwL0Rvc1BkS0Z6TWYrakI1ZEYydGVPRm9ONHAySzhE?=
 =?utf-8?B?NnBza0ZGOCtxQWhBYkN4NFY3ZjExS002WjIyMStCM1dRU1ozYzJkbnFhR3Uv?=
 =?utf-8?B?Q0VmVHcrUkpsWjRqNUt1VUF3QXU4SjJWLzlDVXhLQlRQb3ZxNGgySmQ2OTBT?=
 =?utf-8?B?cTM3TW5DZGRpYmM3bkZZL1M3ODkvYlc5QXI0bk1SamhrQnVuL1UxeVFsK3V4?=
 =?utf-8?B?NDhnOXBkR0NSVzZZTEsybGIyUktVd3B6R2xpTkh0TG5VdXRDRFNRaTA2UGVN?=
 =?utf-8?B?bUhOOTBYeFpDeFhldkJSOXJPRTdRYVgyR0JUaDM1ck5kMjF5ZDJSaVNsbHhY?=
 =?utf-8?B?NmpPKzVsOHZ4UjVhSGNtaTZ4bFF5WHhEN01QUTNDYnp0ako1VThLbzFybDZL?=
 =?utf-8?B?bjdSZGxZeFR3TXlOYWp2SXBtejlwOFBsTGNldzZ2VUJVSDdXaTdreVp6ZFE3?=
 =?utf-8?B?UnJKR3FXN3d0dkFmcEphODBVanEvM3gzUnFJalZCWUFMZkE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVFYMENyczREb0hBUlpYYkppWjVSY0NITzVubHowTHdtM1Z5ZFl5cFF0c1o1?=
 =?utf-8?B?am9IMDFoZzE3SUFUZ0ZtWWsxTnVIajN3VmV1UUZDaVF3dVh6TlRTQjUybkhI?=
 =?utf-8?B?anhSeHczaWluTUkyZlNlSS8ySkFQSFVtNGlRNTIrbDVXM2tMaFNpYXV6SzVr?=
 =?utf-8?B?YVpEZTlGWXNBbzFVUmU3UWpvaGlCQkdMY29HMjRiRmNOaWVGRktIZHBkeGNa?=
 =?utf-8?B?K01WbDhnNUcweHRiSENSK3ZnSGpOYThKNDk0UnE0eUxReVk4U2pNT3ZLVG00?=
 =?utf-8?B?VzdPZHhUUE5RV0ZBYU5qZ1h0cUlrZ3VETytaWkFCWE1FMGlhNTZCcjFxaHVC?=
 =?utf-8?B?S040YWhEYmJMM0p4NmxBYVU1VkJJSUh1elJWYWl4emJxSkNXdFJ6Qlg4eVFx?=
 =?utf-8?B?VGI3V3hvWFRkaDIzSHUxYUVvc09JWHprT1drZ0JaT1FZUjdoQXY0NnFNNE9m?=
 =?utf-8?B?Sm1welJCeDJ2cG1VVmsrUFZ3T2ZITEFaY3J5ZU5nOXQ3VERBQTM5WE0vU1Fk?=
 =?utf-8?B?TVMxMlh0OWpxd2tacUxPNWtmQUZ0WVpjOHJxbklYUnluNnRyTHNRNlBJQ3lx?=
 =?utf-8?B?aE9ESEQrR0F3TjgzcU91d08zcEYySTlIR3hWZERrM01QbFgzcVNmdlQ2dStj?=
 =?utf-8?B?UWZ0TldBSDdZcFFJbFFzbFRaYVFOamU1OEp6Z3JSalA2dDU1K0NjbkZPMTVk?=
 =?utf-8?B?QndiQlByUTlnazc2cVc1Qi9mckNra2haTng0a1dzKy9zUmZrdyszU2xCbjJ2?=
 =?utf-8?B?Wkg5Y3IrV1FQczIreTZNVjh0TUJ4ck1TY0h2ZldQYndDS3Vna2N1OFBPZExE?=
 =?utf-8?B?aG05SHNWTDEyd1N1Vy9QV0NVbW9hSmlJRzU0ZXFhUzkzQ3lSNDQ2YTBHalRr?=
 =?utf-8?B?SDhUN0xPTjIrUlhLKzNaOVM3OWJ0aEJ0dWJ2ZWo0U3EwbE43dTdoRStNT1Bz?=
 =?utf-8?B?b0FUc0IxTk1VRng2NWhjbDl5cXRVYkV1K1dmaW1GVXdhNGFiV0QvRnlTQ0Nr?=
 =?utf-8?B?V3JVdVp1ZmJ5WDNYNlFEUjFpVWltOWFUWXlmRFMyWHhLUmEyUzd3YzJuWUJ0?=
 =?utf-8?B?dGdURHMvOFBLbFh4dVNXOXJub2xvUGp4UEc5YUpldFhGRjU4dWdXMDRxQW5T?=
 =?utf-8?B?NVkySUl0bU13ZFp3S1p0NGVuNDNzVzF3WXdrNlQ4L096ZWFaTnJwMlpvdWxL?=
 =?utf-8?B?Y000bjFjRnErYi9YWWQ4bFNycjltcmlWYmtmU3ZJR1RFcGdrZC9STElvNEdn?=
 =?utf-8?B?UERleWMydy9WMys4Nm5BLy9uUy9NVTdpUFM2QlZlU0ZJWnFzMEFYMW92YzV6?=
 =?utf-8?B?UXYyWStkRFhZNk5pZmEvR05UR3M0Q1ByWEVQckYxOGNoOXg4UTRpV2wySTUy?=
 =?utf-8?B?TlU4WGl5KzRvYlpXN2gzOGhlUEl3ZS9SSkorU1U2TzMyRmsxUmZXMXd4OW1z?=
 =?utf-8?B?Y1lLYzRoOWhpNGNEd2ZPaVpnL1JFd21pL1hSYlo5ZTJKdDNoOFdFUkZPKzBn?=
 =?utf-8?B?QmtqNmJoRXg0UEVHZytsK3FSVWYvT2dqbWIzQUJoQmRCN29FaCs0S1Bjd083?=
 =?utf-8?B?b0hqZlVnam1za3dYQ0hqblhBZHVuM2xTbVo4S3EvRmN5S3ZpODRnY0w1MlVW?=
 =?utf-8?B?TzRydEovNEV2WnpqVDRaeHI0TmduSDYxWjJKSTVKTTlGUnBocTU1clFKVFp5?=
 =?utf-8?B?dE4rYm5WNjZGbEcwNUcvcjBmNStLQzBZV2ErK01QdFRrSHAvcE8yem5NNE5v?=
 =?utf-8?B?Mlc4UDJUUnJaZUtNRFRydUVCWmJVdXRPQ2h6dldvNGptNGhlUHF2R2hPNmNF?=
 =?utf-8?B?THo4SWQ5S0RUeE54VXVENnNYSGpvYk04eDhpS2toUE5WaHV4UStGWEtDWFVh?=
 =?utf-8?B?alhCaFV2ZVNnWXBxck5hZmZEK2hEeXZwd0hNb2U3UnVDMThNaXlsSU5DaTlh?=
 =?utf-8?B?ejJsM3NEemdHd2tOU242ZnBMQVI2Qk1kUUtyYnQ1d29tbXZzZjR0ZW5ubzZJ?=
 =?utf-8?B?a1I3b3ZIWWVTWnhjMVFYeHBSdCsvSmxPS1F4S01aQTFkK0VKTXoxQi9DZFZP?=
 =?utf-8?B?RkRaNlFjUDVnRmdabGd5amRKWCt6YTJBQzB4UjRRTGRQQWdNVmpyTHlSNDF1?=
 =?utf-8?B?ci9iN1dxQitTUWw2a1J0VHVVMndXYjVGSGFyeHdHNDFuaDYxVnNaY2dVempF?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b76adc46-9be3-45f8-a42f-08dd30c4ba8f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 15:46:06.9113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XQvvbAgfUUWexgRb/izaX94IqWLwoPRG9D39Gl54rawUDxcOi9mlfvsyIbNQSKUeEI/+n3eRdTkvRAGCK3Ps00LJDE39LMhVM0wdkQlfMYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7419
X-OriginatorOrg: intel.com

From: Furong Xu <0x1207@gmail.com>
Date: Mon,  6 Jan 2025 11:02:25 +0800

> Setting dma_sync_size to 0 is not illegal, fec_main.c and ravb_main.c
> already did.
> We can save a couple of function calls if check for dma_sync_size earlier.
> 
> This is a micro optimization, about 0.6% PPS performance improvement
> has been observed on a single Cortex-A53 CPU core with 64 bytes UDP RX
> traffic test.
> 
> Before this patch:
> The average of packets per second is 234026 in one minute.
> 
> After this patch:
> The average of packets per second is 235537 in one minute.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
> V2 -> V3: Add more details about measurement in commit message
> V2: https://lore.kernel.org/r/20250103082814.3850096-1-0x1207@gmail.com
> 
> V1 -> V2: Add measurement data about performance improvement in commit message
> V1: https://lore.kernel.org/r/20241010114019.1734573-1-0x1207@gmail.com
> ---
>  net/core/page_pool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 9733206d6406..9bb2d2300d0b 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -458,7 +458,7 @@ page_pool_dma_sync_for_device(const struct page_pool *pool,
>  			      netmem_ref netmem,
>  			      u32 dma_sync_size)
>  {
> -	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev))
> +	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev) && dma_sync_size)

page_pool_dma_sync_for_device() with dma_sync_size == 0, but with
pool->dma_sync set is VERY uncommon case. In general, this would happen
only when the device didn't write anything to the buffer.
IOW, this "shortcut" would only help *slowpath* code a bit, but
potentially harming really hot functions. Such hot inline helpers are
designed to make code paths which get executed in 99.999% times faster,
while we don't care about the rest 0.001%.
I dunno how did you get this +0.6%, but if your driver makes Page Pool
call sync_for_device(0) too often, the problem is in your driver.

>  		__page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
>  }

Thanks,
Olek

