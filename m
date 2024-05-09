Return-Path: <netdev+bounces-94836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E044A8C0D4B
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 11:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9859F283233
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 09:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAD714A4DB;
	Thu,  9 May 2024 09:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gBsSaVoS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE64BE68;
	Thu,  9 May 2024 09:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715246023; cv=fail; b=q8+GkDpymeJz82HmnHd1XzEKMjd9CYzHOe9UoPHUDmrRJOdj3tLRwBo/WNdkdwKR0LFyiG2iR44DziTBZJETDnYNIc06IXR/1z8CYrprJc+WaYj9SvpdwOFuLu/5RD4SPNOygsyycxrvcJJio2AbxkPSphhobn+lKvX9H1KU4dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715246023; c=relaxed/simple;
	bh=Ft1rpOxkzCtCvo2zHxTSNefVqPkch7j4nTXBh2/6qAc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LCocyPyDYBMsXWZiebiYm/IZqSO3h6HKna89hBGpevERpMXl6h39vCN9qHEvzrJsDxDaXTx77Y3FF5hkvejH1IjP0d1/1f/bBc38NIKyridJ3oAFuXJFIHSqKsgOT0WT5UNnNQV0gX2370TJQLFNhCfixrbxbsXZq74iIrqVP4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gBsSaVoS; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715246021; x=1746782021;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ft1rpOxkzCtCvo2zHxTSNefVqPkch7j4nTXBh2/6qAc=;
  b=gBsSaVoSzfXp7pO0y5N6DZVRZxYOmcCGl9JX55VUcedEIYcGhuapusXl
   a/34px/dnjAHl4Kfoi1q/bt16Ydd2wlA1NlLeLwkg0HzBpCAWn6/9dgby
   8cNA1Cty/fGvAUXPGx+7Ka5Ao6vX1FYmpzFf6RSRRgXvcHWqw8bABPPmG
   sIVASvQ5slRm2fWuFiGtK10a5wPbgGu1Y3BSN5skWqTBZU4btU7pXs5lz
   kuS0KOcyjmneBB5Ep0PeqXgdrcWXecaFPeRAQv5xs3VKdiYp0dEjhxlmm
   Az5L0vckAazRhocBypTNgm4JEk77Yt/07vzAMDCmcOPWQJJ803idAOXSh
   A==;
X-CSE-ConnectionGUID: tcsxcRI5QYGnlaevQTq5tw==
X-CSE-MsgGUID: +xc6qicdTpi0nz1G222Crw==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="21723788"
X-IronPort-AV: E=Sophos;i="6.08,147,1712646000"; 
   d="scan'208";a="21723788"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 02:13:38 -0700
X-CSE-ConnectionGUID: w30WIEnaTWyd3Na4EPhk2Q==
X-CSE-MsgGUID: TKN3BUh8TJ28f//A32K8yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,147,1712646000"; 
   d="scan'208";a="33865070"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 May 2024 02:13:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 02:13:36 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 02:13:36 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 9 May 2024 02:13:36 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 02:13:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLO39WOZenGmPWvz3vhd4iIn06jgKlvS1MFb699s9KYsnkBXLVGGC+6SoCtxfoJvhULDyhYOqO7+4OfWvI3g//lkihPB+30+DPUgbTJafckdmuv9b17bKxUDIqUrT/RAGb8jaiEKOkPSa6L4eGjAw8aZ0MjH8jmephZcdcdxL3+ULkWYSqSflfXvIDqO5o3KU1svbZEr2GEOqdvsdUiCcpfGT+khMAxkCGnfOrKj6i7KEq7tcA8Xpk8IBhklM4uzBFN/8UUDgktO7hlt/hGiAhf7Vd91SYHPlsJsH+Y/kgx8ovHjp04r8+jN3rRJZx7md8bEZutrqsNH5q+TtvRi6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEFhdZq3K20pDnHit5l0j8BoCz6ZDdrej/qFtOSws+s=;
 b=KlxCI5VPWnhGHz4zUQExfbBaA9UTUVhjFWLpQ/nxm16UdDFSeet/deivYEe4nFHpJKSSuvCR0SyfomiadRSiOS1vDilJvCzCHXZjwB8zcnn0VClFtjLKCstaHCBOXVy6g53OtphnWkQl0037pVO/8ynCWaCKR2cWz7a1gdMtT/0ZdfsodLvPoQDcYjiMbWIy6rY7upa2kUabL1o3+TDu1X05Jyf0uru1hjcAZlKLfovenF/Gra4aCr0TOYGCDihIXYziC9pogRsDnbcmrm9dXxvPjSj1m1NxOIMLTaXULARcrqjV1VouxbLT5z9ZSD807XrTusyH+Nu7/rMliKHoxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6280.namprd11.prod.outlook.com (2603:10b6:208:3c0::15)
 by SJ0PR11MB4799.namprd11.prod.outlook.com (2603:10b6:a03:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Thu, 9 May
 2024 09:13:34 +0000
Received: from MN0PR11MB6280.namprd11.prod.outlook.com
 ([fe80::3f63:c727:6606:c089]) by MN0PR11MB6280.namprd11.prod.outlook.com
 ([fe80::3f63:c727:6606:c089%4]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 09:13:34 +0000
Message-ID: <334396b5-0acc-43f7-b046-30bcdab1b6fb@intel.com>
Date: Thu, 9 May 2024 12:13:27 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v2 2/2] e1000e: fix link fluctuations
 problem
To: Sasha Neftin <sasha.neftin@intel.com>, Andrew Lunn <andrew@lunn.ch>, Ricky
 Wu <en-wei.wu@canonical.com>
CC: <netdev@vger.kernel.org>, <rickywu0421@gmail.com>,
	<linux-kernel@vger.kernel.org>, <edumazet@google.com>,
	<intel-wired-lan@lists.osuosl.org>, <kuba@kernel.org>,
	<anthony.l.nguyen@intel.com>, <pabeni@redhat.com>, <davem@davemloft.net>,
	"Lifshits, Vitaly" <vitaly.lifshits@intel.com>, naamax.meir
	<naamax.meir@linux.intel.com>, "Avivi, Amir" <amir.avivi@intel.com>, "Keller,
 Jacob E" <jacob.e.keller@intel.com>
References: <20240503101836.32755-1-en-wei.wu@canonical.com>
 <83a2c15e-12ef-4a33-a1f1-8801acb78724@lunn.ch>
 <514e990b-50c6-419b-96f2-09c3d04a2fda@intel.com>
Content-Language: en-US
From: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
In-Reply-To: <514e990b-50c6-419b-96f2-09c3d04a2fda@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0017.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::7)
 To MN0PR11MB6280.namprd11.prod.outlook.com (2603:10b6:208:3c0::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6280:EE_|SJ0PR11MB4799:EE_
X-MS-Office365-Filtering-Correlation-Id: 65593de0-43e6-4cfd-5659-08dc70084d71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d1JkcTdaZGk1WWRZMFhtZTZpbFBJcDlSSWdxUHJ6SVgvWjVrZDlGOUU3SWVk?=
 =?utf-8?B?Qnp3U2ROL0ZtOVBWSWFWWFFWNGlkRWZsYnlseXhJcW1YeUNYMmhpWFJjVHc4?=
 =?utf-8?B?ZXVMYzdwWUwwRXJqODk1RTdWaGcvL0pnVzVodktEY09Ham9pT1pEajdWSTF2?=
 =?utf-8?B?TEtNekVSbDV3L0hBOXZ3a09VSDNJdHdLMzEzMm9JcnJpOU53YUJtNzRqbW9B?=
 =?utf-8?B?YjROZmsvM3E4eGg5VktMV1BaSTZoVzhjWkhiSHNJYU1NK0YvYTEraXVtVFBh?=
 =?utf-8?B?a1Nla0JrWm5sYkllUEpYaHVyMlROdk02aUI2VTVvbnNFZnBGSVE2bU1zbU1s?=
 =?utf-8?B?Q0E0ZzZtS2RMbTgyMVlIdWd6WUhVclVMSjNsenczNHBIekp6RlNDQ1FqYkRa?=
 =?utf-8?B?S0tUZFBURFVlcENUeExXY21LVnhtemRkYUxQQURnQStXY3NzcWNFYVV2Sjdj?=
 =?utf-8?B?ZUVZYzUxRG8wTlMrMEdDU0NBWmNOUnBXbVhkcUpUeVNEOTZ4ZXpXSmVGS3Zk?=
 =?utf-8?B?aTlrSWlsSU80ZitraWltbW9oMmR6eG5YNkhZWUlMZjc5M2hOZHFQRGRKTU9l?=
 =?utf-8?B?QlM3L3pseExBRG9UMGVNeUYxcHNCT0xYa2N0bmpsTDdGSlpsZVlFZEYwMlpx?=
 =?utf-8?B?VlFYakNDcTBLMGNGU1c5NEE1UThmeWp6aHdCSU55UFpKNVlZUG1PRGt4TlhQ?=
 =?utf-8?B?L1pRYUplV0x0SVBlWTRPR2pvNzV2TnpXY2dNNXd2NVhkVzYvdzA4d084UnVo?=
 =?utf-8?B?RTZZNTlQVktTZHJWK0hPemF0NHFONG5UYmJwY1hFRzFjb2VjZ0QvNGc3M1BW?=
 =?utf-8?B?clFubnpLWmt2OEVZc0I2bXJKUmZNZWR1THRRVmx3dVZpWUl2RTRpeWYrU0p4?=
 =?utf-8?B?YUNuZlZGRHcrSGszN3ZzRzJIbkl5R29SbHZVS0o1Ymd5NmQyaWV0YXAvdExM?=
 =?utf-8?B?R3lmaEdKWVRrbTNSdVNxUjRJT0hFWVR0R2pnNHRlWDFUdHMzNXdQbG1hSmpZ?=
 =?utf-8?B?dUNucnpRZThOUzlSNHlCc1NXY29WVGpZWk1LSU8vUHhWTnFaaEd0RWljYy9I?=
 =?utf-8?B?Zkd6Um1vNW51alkxL29KVHJDTkFMUUxHa3BJWmRwSkJEVjRSMkNJOStpa2Vh?=
 =?utf-8?B?RnFZSWhUWkxBTXFudHVabXJNaEY4SUZDdE9zL1lZUm9zN3o4N05ZbmZvaFE3?=
 =?utf-8?B?UVA4bkVHL2s5RUYzT2VTMUFZVnR1MjNCMm50SUZqZGRrUmRqcTRReWw1RUox?=
 =?utf-8?B?di91YS9yamJjN3h0RDArSURQQUliUWVybHFRZkpNV1ZVaTRvR2tBeTZOenRF?=
 =?utf-8?B?UVNwTWgyMGVxZU9LY3AvdHdzaEhac1lGVzIybFpUV0tPaEZaRWFQWnVvNkJ5?=
 =?utf-8?B?clgrVzdoOE4vaCtGc3pHM3g4WFk2UGFMQjFQbDh1UWVNOFBQS2FZMXBNTEc4?=
 =?utf-8?B?QzZoRFhZam95U1RYY1ZSN055NTBIamhrSWZaNzNsSGZScmsxVmlDVVVia04w?=
 =?utf-8?B?N0NReHZBZVNDeS85M3ErZ2VOZ3pvayt1TFBkTXYvUkNZZDlYNXk5ZTQ1VUpH?=
 =?utf-8?B?c3F2L0VCc2wySFpUcXJ4T1hoUkR2RUh0TDYyZFg4dkUxYjBqWDdvZTVTRUhX?=
 =?utf-8?Q?jJ5ekLHsCGPrEEzqXsNoawmH2wfxYxEnEv/ytHE0+oKI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6280.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmpzOG9iY0cyMllpUXVkYzZLdmdRL3lsMkMxdnl3R0x6UEVvYVBuU2hnYm1l?=
 =?utf-8?B?OXBhMmpnL1lPTWFJM0o3K0tVNHdDdmRDUDVweEF1Tit5YkNVdVYxZFBCOGhG?=
 =?utf-8?B?U0lNRlRpb2RPYXlYMWppcjJuTzBKZCtFbUFJYWljRXBhMFcyRVFlSnFtWDND?=
 =?utf-8?B?dXVkbDEzRTBHeTVFM0M5V0JYc0xoNGZHditGbkVCSnloWVNaOEN2RHU0T1lq?=
 =?utf-8?B?bG1aOXJrOVpWdGlxcjZocnFxTkdyeGNyMFYzNWZJME9vdU1oZ3VMQnNhUllq?=
 =?utf-8?B?L0ZqbkswQmdzc3FKRjVJb2JibVVRRWg0eXR3MkllWDBFOUxnU0V1ZXZCUUV4?=
 =?utf-8?B?eFBxWWd5cHdvemxGci9lYk9Nb3NKMXl4czNoSC9DaWlDcXhPR29qYmlMWWF5?=
 =?utf-8?B?VTI1UmRQeUtlelQvdjlSZ05qM3Q2cVZYUUV1blhubjJLcTk4WnA3MThzMFdH?=
 =?utf-8?B?d1RlK1FzanRLZjlrbzhJOFV3UWsrQ1R3bUh3T3E0T1U3bjB2dyszMHJOWmk4?=
 =?utf-8?B?L2N1N1ZLbllpR0xTQW5PM2FuMzFYWkQvdU5YNnNrVlZKMDBaS3hoR09XQXVj?=
 =?utf-8?B?ckIvcXBGUUNvbTF5VEFTYzdKczZaRkxrZTNURFUxYTF4NURzek1YUFZpSGov?=
 =?utf-8?B?RVNnSEdkVytpT3dEVEhSUXdsaTk3RGt5Sm03VkJxKzhnYmtXRVFoUzVMdG91?=
 =?utf-8?B?M1RKUWdHVWVBVzhjYjVJNS9vRGZvWVQ0QXoycDF4bG9TZ0FTRHJ0UGVqK0RC?=
 =?utf-8?B?Q1pjTU9QYjlyN3VaSUVyNE4vMGZqSHFVL1dKZDRSdjJyQ2k0ZitkWk5pSzFB?=
 =?utf-8?B?bk5TcEpkTWFsUCtOYWdtaCthQ3VYYlVQNlZzejNCdm95TlkyVVJRYnhQd3dR?=
 =?utf-8?B?cHd0ZTNMdkUwYVlId1VzRjlKRHB5d2Zib2tpSkE1QVIxRWlqeG0zNmtsRmZZ?=
 =?utf-8?B?S0h3cUpGQVRzc2tOTUVENXRyVTlyYXNZT2llSW1IMU9hcmtGbDZIVDBnMVNK?=
 =?utf-8?B?RXZOamRMWHFVRkFENldVSXhwdkdzMm04UGFDZUFFZ3djWGNCRGJWb1Y0ZElD?=
 =?utf-8?B?bkV6RXFlMVI2K3N5OEhaSHc0QVNZVkJrNVEwN0tlVDZrcm5WTmV0bnZKUmVs?=
 =?utf-8?B?dERnckZJZjVXSWhwVnRpblB3MkFXVXo1MkZaTXdCZVdWazFKRW0zK2c0WkVm?=
 =?utf-8?B?RzRIdytvS0VtQnZ3a0pKM1RDNkVqVTQ2Y0VjT1lIK1VxNm56dVpsMFdiVlFJ?=
 =?utf-8?B?QklLL1B3NmVnYnBhL0xEVnM4Tncrd3NQYkVCMGdDUFdwVlljV2NaQ0dZQVdP?=
 =?utf-8?B?UnliZEUzcnFmbjNyNUZjckw1MmFRY2tvK1pCNzV3R094L3lVdjcvaWhGWnlz?=
 =?utf-8?B?N0hRbHJsa3U4NXJNYXpNVUNqV0tZemF2QnNTQkxnQ3ZxMjlNajloaXB1L2Qv?=
 =?utf-8?B?ZGlOZE9zYXNhSHE0WHlFVnRaMHFOaVh3dFNQNHdXelduV3REM3dqTWNZU1FJ?=
 =?utf-8?B?c3VwK0l0bUhCUkMwaWZPdVJVV09WQVZyNGoxVWxlc3pqK1pVamUrYzV2L25O?=
 =?utf-8?B?czByVUVBcTZkWnI2L1NjaGkxYk94TStCVG5odnZpNFplNlBXLzZGK0cyTHhV?=
 =?utf-8?B?cXV3dUhIamsydTdxZ2JIV0NDVUoxQWJqVUt3VWNhN2FmVjh0cmFOZjhjbWZR?=
 =?utf-8?B?cDQ4NlVvQm8vcTVDVUc4QTgxejZYVTFnaFZRQkVGQ0JFR2lkWWpIbHlEbXRY?=
 =?utf-8?B?VDVIUFBCeU80bEducElrQTRoWDU4c2pMcitxQ1U0eG9QblVSVk8vbkVCWmo2?=
 =?utf-8?B?bDBueWEvd1BsYmtNb0V2WktGcWxDcVlhYnRhczBqNXhiYWtPRU5STnJJWHEx?=
 =?utf-8?B?bStkZUpKdUQxa0hYNTVuWkZuWGtsaUFRZzNPdXNDTkkyMnJINmNOajJ2T0xr?=
 =?utf-8?B?UW9MU1NGd1EvYjNqWDJKQzRKd0kyRWlnckdGeURkSmNOSDhzYTFJU2NtOVBu?=
 =?utf-8?B?OUZFcGNuWmZiZXRlZS9DamI4REV0OU5BK0ltSk5STnIxbkpRQlhkSDg2bmhW?=
 =?utf-8?B?dSs4UjJZRExHRHQzS1lad3VMQjVCa3MzZzVWanNQV3VWWjNwbXYzbm9SZ2Yx?=
 =?utf-8?B?ajlLMFVsamt3a1JrREp0cXdLWHZNaFJZTnZDQmVPcUwzelYyMGRyVXVIdUQ3?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 65593de0-43e6-4cfd-5659-08dc70084d71
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6280.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 09:13:34.3344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rbf1Sd1HRq2s/ajZFkAUAaVPOPPSNoRjJSgBUbQQ/NoR9+0kcBxUTjE4270OsFlIO1vdEYXTzeDs/Gj8MPcUhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4799
X-OriginatorOrg: intel.com

On 08/05/2024 8:05, Sasha Neftin wrote:
> On 07/05/2024 15:31, Andrew Lunn wrote:
>> On Fri, May 03, 2024 at 06:18:36PM +0800, Ricky Wu wrote:
>>> As described in https://bugzilla.kernel.org/show_bug.cgi?id=218642,
>>> Intel I219-LM reports link up -> link down -> link up after hot-plugging
>>> the Ethernet cable.
>>
>> Please could you quote some parts of 802.3 which state this is a
>> problem. How is this breaking the standard.
>>
>>     Andrew
> 
> In I219-* parts used LSI PHY. This PHY is compliant with the 802.3 IEEE 
> standard if I recall correctly. Auto-negotiation and link establishment 
> are processed following the IEEE standard and could vary from platform 
> to platform but are not violent to the IEEE standard.
> 
> En-Wei, My recommendation is not to accept these patches. If you think 
> there is a HW/PHY problem - open a ticket on Intel PAE.
> 
> Sasha

I concur. I am wary of changing the behavior of some driver 
fundamentals, to satisfy a particular validation/certification flow, if 
there is no real functionality problem. It can open a big Pandora box.

Checking the Bugzilla report again, I am not sure we understand the 
issue fully:

[  143.141006] e1000e 0000:00:1f.6 enp0s31f6: NIC Link is Up 1000 Mbps 
Half Duplex, Flow Control: None
[  143.144878] e1000e 0000:00:1f.6 enp0s31f6: NIC Link is Down
[  146.838980] e1000e 0000:00:1f.6 enp0s31f6: NIC Link is Up 1000 Mbps 
Full Duplex, Flow Control: None

This looks like a very quick link "flap", following by proper link 
establishment ~3.7 seconds later. These ~3.7 seconds are in line of what 
link auto-negotiation would take (auto-negotiation is the default mode 
for this driver). The first print (1000 Mbps Half Duplex) actually makes 
no sense - it cannot be real link status since 1000/Half is not a 
supported speed. So it seems to me that actually the first "link up" is 
an incorrect/incomplete/premature reading, not the "link down".

--Dima



