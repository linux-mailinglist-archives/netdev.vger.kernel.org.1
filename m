Return-Path: <netdev+bounces-129022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C592897CF54
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 01:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A75961C2119C
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 23:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F91214D718;
	Thu, 19 Sep 2024 23:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dkttqdcD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A8C168C7
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 23:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726787202; cv=fail; b=aquOgkybUKQ3DcoGYao6IKhqec/2u8tcPX2EAhrcoETc9Jw9tV4vZu+XWBAHpw0jNGIBUyDtqy/aUKqtVfFbxhkbM8lH1VBUpuukViQwbfsZ4v9Pc2UnucdeE5IRAyWuDBzrYP5quymBxLrspuLDh8lowJHZDjezpvOFA5dMXYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726787202; c=relaxed/simple;
	bh=lphTjcv/iv+Wnv8xuR5Pj6VL9I7EGw5hYqae3So4jrI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F04soKjAYaOmoSzzjfKLsq03r9JYWfjb29Xh3quQqQzGBQu/pCuw1RoyPJzDOa89dE+lW7FbSqul5hJ5+w65emlXbOl98ei1RubXDx1ViYqJV8Jzhnn/18FyrN0i1Vr2Y5I9XtnOxISMxcI6e4QoIAp0o2ioXviZEU5gC96IV1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dkttqdcD; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726787199; x=1758323199;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lphTjcv/iv+Wnv8xuR5Pj6VL9I7EGw5hYqae3So4jrI=;
  b=dkttqdcD/0GXUGdydXvQaF9irVSgA3t8JxMY3nDa+0Gn1VsM+exGYJ1A
   Yy/QoSSajYgyNBXT8xwmfBxYoQ19NWvK2KQZ8nk6w1DtaVqy26yIJb7+Y
   M6ltNAfU7KR1IWKAONPnfqY9B7Icb7w4dJW2POx6R1ieahYMVhczx3lq0
   WruHsdBhth1QWU8NOcH/HmLYries4H4Y0I2+ooPfznMDmK28/dr0f3tRU
   9gkHCkps8r1JTfIWw3mN6PD/DQWsvwEPj8kENiQy5rHtThrdTyaCI8UXn
   SFSAtCyZWNkJuXiSYMSSOw9zm3z1dE6t/4LsS01ztqFHIMvelVRjPcFtL
   A==;
X-CSE-ConnectionGUID: qxwqz+CaRRiMYqhOWYH3Hg==
X-CSE-MsgGUID: MRxIWAiOQO2ivfhcSCGX6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25924248"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="25924248"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 16:06:19 -0700
X-CSE-ConnectionGUID: r0nuARzETRmbshr1obWoOQ==
X-CSE-MsgGUID: xhPvEfJwQXCoQLorMz4GwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="107559350"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 16:06:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 16:06:17 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 16:06:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 16:06:17 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 16:06:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e5djSQAs4sFJ2wKQGuvSFUg54p6jomQUYFIhJ3roiGjfZAThYaiUr1wwBvidALqr9Uqr92X1yLkylwreCK+C1anyc9MDiKfzTlbUpkiproGmQPnWx51pJu4auHgtvLv0YC+LCv1fEpWJdm1gtMOCn4PhPFdAP7A4ULHIm9Ui29OQ+IvFL4n0DZNhiREzby9LZKbqJwp9GQr6HHJnEPiN6yFQPneNqltrSram74w1b8UPVMfH9pqXLxh2fmdMvvj8JiKzEKiFriFG7h2zHxctDvZxZI81/3sckpE5N7mnH7eTpsVTXqKnit2Z6pT0JWw25kxj7JWU5+OuHPu7wrfsag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrtXyUNqIRmNARuMLfm3Lj3iAbdBxH6HMrd33sikgIo=;
 b=ufTbT+ii7l2iXtVNgsHXg6DcOlzY0xYNPOHeQNjFl+8j9bW83Kz/YrqSrWeAeUQ/eibkhvbLOkjKBKdMSpgPOuxAewEvKAGylSQRDJFkCaSwkNw4j3gDLML1IJtfQ+zWg903OT4B42JmOcAPFkv/Cxzbg1LEhD0bnevYEQL2leniy69vTfbr8U9nhd4sYYiNtFtRqPK9GXOy0LE9agFncR47b7v8XRXMRLLhQBqwROEsyADuT7up98L4v7CSZnjOVo0+Ej9XnLwbUm1e9U3+bSzJ9ll5FYKoRB52bFW923r+wMG6L3wAZa0vrTn4EUzHkAZ6nbWdDJpOZR2LpNHF1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB7091.namprd11.prod.outlook.com (2603:10b6:806:29a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Thu, 19 Sep
 2024 23:06:15 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 23:06:15 +0000
Message-ID: <0ad84ba7-88ff-45bc-8a2e-3c1f3a384950@intel.com>
Date: Thu, 19 Sep 2024 16:06:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: Dealing with bugzilla
To: Stephen Hemminger <stephen@networkplumber.org>, Florian Westphal
	<fw@strlen.de>
CC: <netdev@vger.kernel.org>
References: <20240919091046.64cb49b6@hermes.local>
 <20240919161709.GA18875@breakpoint.cc> <20240919094312.1d0d4b87@hermes.local>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240919094312.1d0d4b87@hermes.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL6PEPF0001640F.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:16) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: df983820-17cc-4f47-9668-08dcd8ffa96f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Yk5ELy95QmZLaFo2NnR2d0RyZTFueElCMmJCcmZWNmlNSFhYQW9TU0tnRElh?=
 =?utf-8?B?blEya1BVcVRnNnNGdGJYa0lLVVcwZXhpWjRRdExCVGMxYW9YTHIxVkFNRDBM?=
 =?utf-8?B?WE1QaDJKdUxZOTBFKzBGYjY3RzA5bVlhZXBJUlBXZGh4RFJZdTlrajNxSXEz?=
 =?utf-8?B?aFhBdUNhN0VyaFNJd2hBc2dzdFl4RTZJUWNnWGxLWm5SV2RiZ2VVUytpVWNK?=
 =?utf-8?B?L3dhMDg0Smd4Vm9INEhmU1ZPT0tlQStKb0RYeEgzTWdpbGpQbzBRK0FjWmFN?=
 =?utf-8?B?NzY0M3ZlL2UvVW5EY0NkcmlQb3NuMzNIY05md3NLN0FGS2pTYlJ2ZjRmc1lt?=
 =?utf-8?B?KzFVT1laayt1ZGNuci9INlI4NXJrUUtLM1U2MWtxT000MDBWblJmVVcyZGxR?=
 =?utf-8?B?cmtXWGpYR1lJeFAyTE13TCtmTWRaSFFBTHB6OG9JV3dDRXlQWndZb28rMGZ6?=
 =?utf-8?B?VHNNS29MbXFCRDA4ZXp2SVJBd0ZUR3c3WmVMaklUVmtKWVIvQmt0Y29ycjhK?=
 =?utf-8?B?dnNwa1pHSmFac2dyS1FTNkNBdkJOeUZydXh5eE1pK0lzRXZ1eVg0NVFadzd2?=
 =?utf-8?B?eVB1aWFUSmFpMDBKZzZwdmF6M0hJT00vbUpibUtrV04zUHlrT2ZlUER4bVFY?=
 =?utf-8?B?c01iWEJ2Zmg0cmlqbHQyU3M2RlY3YWhreW9TYURROU1UZkloUWlaNXlWWDFQ?=
 =?utf-8?B?UU9YNTRUbFBPeEQxOWw0T2VxTUYxeFd4YTdDamNMcXRYeE43aHhza2FYSGd1?=
 =?utf-8?B?QjQzeHF6SzQxTGMzaFNTWkdYeDhjQSttWTlrQjJmWGp4MDJud2d2Wkc3MEUw?=
 =?utf-8?B?amdOOGJ4QjllUDBjbFV1Q3R5ZkkxaVFYL0U3ODU2S0RHTWJLVnRhZ1VZV29D?=
 =?utf-8?B?NTZ4RmthOVRuekxGem4vMklGMGw5MDdtaVMyYm9YVHFCdmVlWGh4WjJHek1m?=
 =?utf-8?B?MHVaVExhRlJ1S0VrYkFjc2FRY2RXMU9ZMzFNTUIwcWpDSEx5MG1VMXl2a2xT?=
 =?utf-8?B?SFhVeUhVSk1hZHdBSUJJU2lyTVJJL0NrZ2FIMnpsMGF6MVBMT2RYTStUT01F?=
 =?utf-8?B?eDg2ZmFDYW9UTHlUT21ZM0RET1dDaGVvbUZaMi9naElsMGFWUXd3OVB4QXYr?=
 =?utf-8?B?OXk0YXJmRTZtTHlWUzZ2OEYwU2ZSYUZiOG1lVWRHTUwzcnZ2WXZmbFdIUkpa?=
 =?utf-8?B?Sm1FVHh4Y2pVUjczaTBYQ0FwUjd1T1VqbGlQNkEwRVB2bzl6bGdkc2tWL2Vr?=
 =?utf-8?B?YUpwMlZHM3h4aVd2LzQ4c2JLMWFZVTU4RmdaQmtOWWZFZkZ2RzN3Zk5jSitB?=
 =?utf-8?B?V0F5a0hjYjFuVVNqMHBlWjAwWVFtSjFXWllKVW5WREJFdXNpaTZTeG5qaDQx?=
 =?utf-8?B?d05UR0NXUlZNMWRZUEhzOWoyQkFQdFN1UDFHYjZNQmJUVFA4MWZsQmpxUXZZ?=
 =?utf-8?B?VHhPKzRaWlVNdjFQTWJKTUZOdGRKWG5GcXRXL2VsSTg5TFhSTUUyd3JNZVNy?=
 =?utf-8?B?dzBtbHNvMkNuRHFPMzIvRmlBdDViM09tQjJNS21HUlkrNmxyR2JLZ3pWSW56?=
 =?utf-8?B?TWkrRUxjbTVXTDlUODJrNTlYZDJzcTBhZUwvYlI5eDhTQmhaQldxUlJLQUND?=
 =?utf-8?B?WnVFenlaVVp6b1U1K01YbVpNbEpHWHpVV2RFSFlHZGsvWkZsL0pJZC9OeWFn?=
 =?utf-8?B?MXpGcEtnNTlwSTVIanBieWY1bjh2RytlaXMvNDVJeXdyWGpoY1MyVjhIVmxq?=
 =?utf-8?B?dUQvdkhrT011aHpUUkg1Rkxmcy9FMHYwbE1NVkFMMFR0bmNYOWk2Y2tUVEwx?=
 =?utf-8?B?S2JoWjZXU1lONmdRSlRPZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWg1ZEdyNUQrNEdMTm95NElxbFp2OGJMRHIrcXZjblpLakI1UUtPSkVBNHU0?=
 =?utf-8?B?M21DbkIwWTR0ZGQ5ZEQwTmFLZ2hNQzY2NGRyMlM3L1ltZ0Rqb0taeUNRb2Jy?=
 =?utf-8?B?RUZUM2pqbjJTU24xK0s5ZXdQUnV0UG1WWWRGaDR4M3pueVVLbFlzem5nNUxU?=
 =?utf-8?B?QVh4V0JCZTlEaGpoK2o0eUt3UVduV0t3dURtUDkvV3hnWHN6VGs2b2E4N004?=
 =?utf-8?B?WER5N0pGazJmUElyQVpKRURCUzNJQnArQ2k1M0dwRGxQSEdiM2JrUmhOVlYz?=
 =?utf-8?B?b2l5RkRmR3FtcVBxTVNhVmhDdDFvTFVybVpkTC9YOVpIenRHc1FzcERKQVFV?=
 =?utf-8?B?NUNKbEkxN0J6bVVoN1VuRHFORFY1OENnN1UrZ3ZReWM5QmJ1dlVrbDFnR09x?=
 =?utf-8?B?eStxam5QRFVEeHpLd0UxMHBqLzdpMFpVSER3eGxBS21ES1R5RlRHQW9qSUJu?=
 =?utf-8?B?OUpoRi9MVENYbnZnczV1OHQwVlUwTlBHdUpxd054VGM1dUtUUncrU1BSUGli?=
 =?utf-8?B?U3hDekJTSXE0Qk9tdU41U3hMaUE0NlZ0cGt3SDVUVG5vUnM4REpqTk5EM1c3?=
 =?utf-8?B?NTlTa0RGQXUwUnZpbkRKK3NyZWJzcDVNbC9MTU5pSVZaOWJWRWJ1K2xBcElD?=
 =?utf-8?B?K2JIelkxYk1MaU5qNjhES1l6M3YvLzJCckFsMEs5RW9WaVg5RlY1MktCMmND?=
 =?utf-8?B?TmdpWFRmZGRaV1hJOC9jT2t3Z21wVXFGdXF3UXE3WGZ1MU9ibUcvZytTM01q?=
 =?utf-8?B?Y3ZBWUFWL05OTWJWdGU1emoybjBNOHZ0NnhBN1RNdFVCVkx4Y0FDMHo1eURW?=
 =?utf-8?B?cXFJWWRCNHU0bGJobHpRR1BtU2dDRmVWRUY3WnFiZFVwNmRwVlo0aEZxQlA2?=
 =?utf-8?B?MC9uY1NZWGNyUGRJOTVLcW5rR3hpQ3N4QlQvRUZVRWdkYzUyT0NhcnR3a3pO?=
 =?utf-8?B?STZPNEgrb21Tb3JaNFhrZ05FN1J3N0tjVitEN3QzYzhYMGJQZWdqcU93em4r?=
 =?utf-8?B?eSszaHpKLzZuQzErc0pmdGFuMFhscWhxaW5FTFU3Y25DalVYR3dxQjNvY0Jw?=
 =?utf-8?B?YS9XZTU0Q0RSZWZidVNGeGFPNW1RTDBSVjRZY0xERk5VcktHK0FsTXNBN0hs?=
 =?utf-8?B?RkxmaEFFejFzb2JWYzA0d2tlZ1g1cUxsd2RxU1Y0a2ZvK0hNeGVZd21xRXdC?=
 =?utf-8?B?VFMxQWxYa0FNSXlPb01sOHNvU3ZuRDB5cFhZQW9mL1Qxc1lBYi9DZFRmVWVR?=
 =?utf-8?B?bk5Vd1grWndLdlJGQ0xORnl6WURHakJ5VnNnaGcwVFRSb1NDb0RxUEFaK3NG?=
 =?utf-8?B?MmNRT3VVMWo4YTN4VG5sZVZyWmFOSExsa0ZEK2JYT0xBZUk1dS9pVU5SSEVk?=
 =?utf-8?B?SkJwby9RR05UTTRab2ZuOC9GcUE0NHpKTTBUREVuNmJNTUN0QjBRaVFuVHdw?=
 =?utf-8?B?MHh3ZzBHVFcxQVp5UkdqZ0pRNWpsVTNsSzZIdWFNeTA5emhBWVIrUGRhWmEw?=
 =?utf-8?B?QUlqTGlhd2Z4dC90ZW4xcDJ6QjgxTnBOa1JUN0ZTWFM3VVFzUFFiZXBxdHhB?=
 =?utf-8?B?dGRiRCtQV0ttR0l6ZTZUangyNHJ1aEFQNFFrZnlJOElXUmxIQzZ1SUkwRUxn?=
 =?utf-8?B?ajhGbC9zK2NETjZxVnVuc0RwN1NsRDNmbGRzOUtUay80aVVSaTg5S2h2Ri9O?=
 =?utf-8?B?YVh3NUdMRm1sVFFqWFROcUxIRkpLSElUU1VCTmhhTGhPMVo2NlFRV1VsbEpm?=
 =?utf-8?B?RjNqM3cxd1ZueUQwN29OWEtZdjd4MVVFNWdmSnQxMTZsQ0hScko2ZVY4N21y?=
 =?utf-8?B?M1FFQythaXJrNjMwZ0IzSlVHQ3d6clNHWDZtSW1uMW8wT1luY1ZtZEgzdklK?=
 =?utf-8?B?L2V2K3VPYVc2MlhjNC9GOWdmSEVrK0VLV0Zzd0t1dUNYdk9qVVpaVlB2Zk1w?=
 =?utf-8?B?cWp1aFZkajFtU2JUSVNrTkc0MFZkeFAzNDdveDRFaVNBallOM3NCbytjZmo3?=
 =?utf-8?B?NmR4bGZVdldOQy95aDI3dXNGY1JMNnZieXVTTnZ1d0M4N1BDaEZZc1NkTHJw?=
 =?utf-8?B?KzNkL2R4cjE3cE9aKzlLZS9qMHBqSXo1RkEwZThPTFJ4eDJDY2g3RG12czVt?=
 =?utf-8?B?aklLYWowcWFqMzJOV3MxTGhpQ0h6bTh0b0w4Skh5d21KUktNWjlRT3dmK3ZH?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df983820-17cc-4f47-9668-08dcd8ffa96f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 23:06:15.2491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZG0kXArvk75wxd9KpESEkZ1bfECLf5YoVTCrOTcgU4LRISwACjlnpYT9i+nKFjvK5mx8yizwB1Ou4kQUE40Yg30jZFVzlgia7qptQ+rIS1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7091
X-OriginatorOrg: intel.com



On 9/19/2024 9:43 AM, Stephen Hemminger wrote:
> On Thu, 19 Sep 2024 18:17:09 +0200
> Florian Westphal <fw@strlen.de> wrote:
> 
>> Stephen Hemminger <stephen@networkplumber.org> wrote:
>>> Up until now, I have been the volunteer screener of networking related bugzilla bugs.
>>> I would like to get out of doing that.  
>>
>> Understandable, thanks for doing all the prefiltering work all these
>> years!
>>
>>> The alternatives are:
>>>    1. Change the bugzilla forwarding to netdev@vger.kernel.org (ie no screening)  
>>
>> "OH NEIN !!!11"
>>
>>>    2. Get a new volunteer to screen  
>>
>> Even if someone would volunteer I don't think it would be good to have
>> this burden on one person alone.
>>
>>>    3. Make a new mailing list target on vger (ie netdev-bugs@vger.kernel.org)  
>>
>> I'd go for 3) and see how that works out.
>>
>>>    4. Find someone to make a bot to use get_maintainer somehow to forward  
>>
>> I'd say 3, then see if it can be refined somehow.
>> 3) would also allow to get an impression on the volume, the signal/noise ratio etc.
>>
>>>    5. Blackhole the bugzilla reports.
>>>    6. Bounce all the bugzilla reports somehow.  
>>
>> 5 & 6 are worse than 7), which would be to close bugzilla
>> and keep it readonly archive.
> 
> Volume is about 1 report every 2 weeks with about 10% dropped.
> Most of the drops are because the report is for an vendor kernel which is tainted
> or end of life.
> 

That seems low enough volume that a few volunteers could handle it via
something like netdev-bugs.

What do you do with bugs once you screened them? Presumably try to
forward to relevant parties or the main netdev list?

