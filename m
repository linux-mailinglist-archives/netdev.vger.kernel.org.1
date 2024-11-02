Return-Path: <netdev+bounces-141244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBBD9BA30A
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 00:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D55EB224CA
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 23:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933521ABEC6;
	Sat,  2 Nov 2024 23:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z6iDCPaD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BB4380;
	Sat,  2 Nov 2024 23:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730590341; cv=fail; b=O24/aBs3djcwlVKD/7NbH9Fcy7ee1Z2/BtK8dYHigCI7tqeyTZhL6QYzRnKwylE/KeABxC7i05F6PEQ6Egq16++/vb46IjbiWbyr9MdBUp7mev+KcVy/mBfPqUSp0FSesnFttNtvF2YBSy6h9Sg2IgGtfTW81MnTHsdq4+7g6+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730590341; c=relaxed/simple;
	bh=qfiOKlPtg1/d/WIgsBTK66DGK3T9gxcX1M2mF7ZuTuM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F3dbJOxRyYOykcfQ/223VRKm+NO3/P7vgpD+f+3mNjt3KvpLptZqxb8Jj8P/rdPop/z9d8+NgPXfQiXXzltLGJTARbtV9Zfh2mK16BKammwNohI+kzwWs/jKZVqSeZC+1ic1ixOfK31e3SA6rG4FlbifqFdXVtOvApaggIMlnAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z6iDCPaD; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730590339; x=1762126339;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qfiOKlPtg1/d/WIgsBTK66DGK3T9gxcX1M2mF7ZuTuM=;
  b=Z6iDCPaDsdCSlWzqOb2qSrAkDIbCxq9puzianpbiZMqnQnNJoHfxrLoo
   1plduh8uGzeEqld0c8mh/OYV/mRiHaQk7O4ic9pyjk2dclCW5Fm40xokq
   NETpytH2Y0LF+Kh2BMGIZo0hecgQMoDmiE+vmVvA8vNufrl1AXsFvx2cV
   pxNC4Sdtb9eu4zEQHNzSn1CbnmIteOKwjDc/XrKw8S7mqhpjAn0XRRVVY
   rGj/CmuVp43JjVut6Jy48Ze7yKE7jVfUKxVRDeF0d/d0gOh1VE6MyTTaz
   UyUsd/tWtUv776JZORxpQccej+WCIf2lfLrGFguTC8Nmr3lQyJEsMPA+/
   Q==;
X-CSE-ConnectionGUID: 0doLV5wOQzuTiNBjBNSiqw==
X-CSE-MsgGUID: Vz4fBIABRCOZMh86Y8ca8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11244"; a="55718923"
X-IronPort-AV: E=Sophos;i="6.11,253,1725346800"; 
   d="scan'208";a="55718923"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2024 16:32:19 -0700
X-CSE-ConnectionGUID: B4leC0m6QF+g62fEK3lhhA==
X-CSE-MsgGUID: qzPPxSQkTuOOxAhrIDQ5Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,253,1725346800"; 
   d="scan'208";a="88429872"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2024 16:32:18 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 2 Nov 2024 16:32:17 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 2 Nov 2024 16:32:17 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 2 Nov 2024 16:32:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/gNhsKh0TWNZ37mbBwjljyNDWUPABzDVD5LT0sYf/UXLKdVPFp+bslkecSYaN7qVjquCA/Zr3IQZ7rVXUgEi2o9RpGrcPcefZXYL9uQ6xV7Ir6jLZosKu2aojSvN150sTsCFT9oL/exO5Lx3/RFpxWGyZUl5tc//ug84oOuz6IuFOg9OeH8gt9Vt3yDDnrYksYSHYAXJEVb5zwd0OlgRhKBpDxhor05ujK8D3eb2hrzyu3u4YIyK/886EqQIRLPCqb5tIpUz1trQCjUePjiMJE0YOfIrFwuoZA06PbHwcgWj3beWU2n8/EWPBBFAq9pgV2RzT2cvqfNVAN1pnArGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93eui2eRf7XMedEKkxeSWI5uL//+Jy4H+3b3mOVB8Ek=;
 b=Cg9iiEDG4iQzERYb6GveUeHcJtt+hlP+31sae9lo+HeBpDs1C85IpP8p1/NkzYW4kglRiPg+p1pbEI5Iow26PH5/3dXb10/CRKDDypTuQCvN6HJEjpNoxnvUNGCLSrgfY+c7e1sE396e83GstNd6K70FLFScUh04dIkFE/odPkwePsaOh6DsH4JLa3J6laYwWB8CyRqF3H+VWOhX768gb0ZK+S2CrN93LbTWvWXkumwVEW3/5AEtXmjSxMKqHSGcKycFD3sFR+7tTsmzWeByKYQ3tIrxsXKgQJJ3AlYNq7EEJuGkVsnCLZG1HL5OLkWq8fypXIzpKmuScbRFDGbsWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4886.namprd11.prod.outlook.com (2603:10b6:510:33::22)
 by PH7PR11MB7516.namprd11.prod.outlook.com (2603:10b6:510:275::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Sat, 2 Nov
 2024 23:32:13 +0000
Received: from PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3]) by PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3%3]) with mapi id 15.20.8114.028; Sat, 2 Nov 2024
 23:32:13 +0000
Message-ID: <af712da5-af87-4dce-84be-d6cc36de5bfe@intel.com>
Date: Sat, 2 Nov 2024 18:32:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/7] net: Suspend softirq when
 prefer_busy_poll is set
To: Joe Damato <jdamato@fastly.com>, <netdev@vger.kernel.org>
CC: <bagasdotme@gmail.com>, <pabeni@redhat.com>, <namangulati@google.com>,
	<edumazet@google.com>, <amritha.nambiar@intel.com>, <sdf@fomichev.me>,
	<peter@typeblog.net>, <m2shafiei@uwaterloo.ca>, <bjorn@rivosinc.com>,
	<hch@infradead.org>, <willy@infradead.org>,
	<willemdebruijn.kernel@gmail.com>, <skhawaja@google.com>, <kuba@kernel.org>,
	Martin Karsten <mkarsten@uwaterloo.ca>, "David S. Miller"
	<davem@davemloft.net>, Simon Horman <horms@kernel.org>, David Ahern
	<dsahern@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, open list <linux-kernel@vger.kernel.org>
References: <20241102005214.32443-1-jdamato@fastly.com>
 <20241102005214.32443-3-jdamato@fastly.com>
Content-Language: en-US
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
In-Reply-To: <20241102005214.32443-3-jdamato@fastly.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::15) To PH0PR11MB4886.namprd11.prod.outlook.com
 (2603:10b6:510:33::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4886:EE_|PH7PR11MB7516:EE_
X-MS-Office365-Filtering-Correlation-Id: f9420f2d-6168-4e0e-1791-08dcfb969459
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eW9FbXFzY0hDUWVvSVcwVS9oMFF2NUFzNkpaMlNSTlhEQzZ3M2s0Ym5aVktV?=
 =?utf-8?B?RWt3MElzMmZJZEtyZGRuMXcrVEhjdjZmQmFhRnpEMjNDc2F0eFFWckRFV1d1?=
 =?utf-8?B?UkhNeGoyRDk4U2QvS3ppdythc24rdGlLVklrSHRmb2VaUS85MkVWUjlMMi9J?=
 =?utf-8?B?K1dUUWYwejRoVnFuRjE4UXJQOEhFNXZaM0JzZ2tsM1c0Ky9yY1VFRFQ4WVBK?=
 =?utf-8?B?dzhSRDZ6c1JrbXhSQWY2bXdQdk81REVhUlRmRjR4d0FEZ2VZaTN4WWVEMjdR?=
 =?utf-8?B?aFI0Y0tPaXRmQ0lXRFBkTlZjMlYxZ2hxVGplYlRQUk4zYWgyYXA1SmhWL3VE?=
 =?utf-8?B?Z25xZEVoQk5oMjNpS1FhUU9hQU1tcldyQ1NFdU8rc1hyUDNTU1NrMHpwZHFi?=
 =?utf-8?B?VHhPSkNMWHZNU3hRbmJzUjJya1k3QmhaemZkZlkrV0dNY0xtQ1FWRC9KcWRF?=
 =?utf-8?B?c2R4TFBCanZsNDFab3ZPZyt5VjI3WjVBSkozcit4SitQNG5mRlcvMDZ1dzBO?=
 =?utf-8?B?YWZDZEN4clB5N1RwYk9OYTVxN1V5QmZYV0htaUJJNWxtcHpKUXhnSC9yRnBj?=
 =?utf-8?B?cXZiNmxQOGswR2xiMndaVmJZbVJmOWR2ZDF2NVY2cVo0MDE0ckY4WkZCRURv?=
 =?utf-8?B?RS9pRUd6TTFhM3B3T0lXSDE1OS9PK3I3YU9HWkh3blRaRWo3VHJZd0lVUGVK?=
 =?utf-8?B?UWw2MExZNUg3c3dsZHVHRHBSU25vNnhGYkVJK1lFbkljdER2Y25yTmJiUmNz?=
 =?utf-8?B?ajB4eWNZNUFlRkVjRUpNZDdlY0VYYWRHQUZjcTNmUDRWODFWRkFzWE42TlFl?=
 =?utf-8?B?aFlTLytML0Y2amgxYlpDTHd4dEFRSThBKzRFajBrNFZPVG5BQnJTN1dBNHlZ?=
 =?utf-8?B?QlFUU0I2NEUraTRtVGlQTXlWY3ROWDNETmlXZ0EyUmt2YmhQMlNKeVpOc3NP?=
 =?utf-8?B?YWNYVk5xYUE5UGVZaTZ6NFRmWjA4SGFpQzVvZlR0Q2lyOWtzMUVSTTBHeHh6?=
 =?utf-8?B?dzFjQ0syQmZCS2twNHRsV1JveVcwV1VFd0hoYkl0QTloZlJKYVJ2QXBOWTdz?=
 =?utf-8?B?YUEyclBTd1FrbWllQWt3V3pSZFNhUkZsVHdrQnFPd05lNTBudC9mYTJBbXNT?=
 =?utf-8?B?dkNnTld1QmRLeC9lNUtKMTUvREdObTZwUnRXQ3Ara1JJazFjMmhWME9xK0lN?=
 =?utf-8?B?TTNOZyttbjB6aWxQWEJjWTJONVkrb1FmMjUzRFdFMHd5Vmd4TUNIOVNQVGEr?=
 =?utf-8?B?emlyaS9YNCtzVU1kRWt1djFxVVVPdS9xR09rdlpSUjRtblEzZklkZTQ1YWJG?=
 =?utf-8?B?clRhWmxYWnJacWFjdXlQZG9XTVI5eFJqWG1xNkxWNWl5WUhBN0ZGM0plWkFO?=
 =?utf-8?B?TGRVRzRmQUJpVjduQXRRMkdENlp0djlJT0RKenNBd2lIUDNnclJqeHFoYTdJ?=
 =?utf-8?B?eUNBdWM5bWpjS3BQVFZabGhPWDJ6Q0FmLzJEdWRWMXZsbS9OZHJDa1ZEeGt4?=
 =?utf-8?B?Qkllc3hhbDhGVGlWSU5PRWtaVnRoQVlxOGNxV2k5SWVheFZweWw0WTVKenRw?=
 =?utf-8?B?ejMrSmlQMFgzY0VCYWZENm9iZE9vRlpJQ29FTW9CR0l0eEJ0TkFvWHU3TWJR?=
 =?utf-8?B?T0FJQ1ZJTXRiZHZqRmxEV3dNSkZUVWpxWkRNNWtSNlVLL1QxR2NWRFFFMVpZ?=
 =?utf-8?B?dzdGQnBWMUJ5RWljUWhBeklDU3dWSjFRc2d5VTdseUdSNENkYjNiZFdNKzBU?=
 =?utf-8?Q?icWO0k3TvVCGxMe/xOmdYVG9AugmDKaXCYqzF3y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qm9LZWkyUmhENldCRUJxNzdpYWYyS1F1cUJ6Nms0cmljSWk5dUpraU85RzJy?=
 =?utf-8?B?eVA2MHdCRXB6Mm1PL1JGTWM2Vk5aUGJnWUhOZGR4R0NuWnlCMEllK2FOVlJ0?=
 =?utf-8?B?YlRwclA5WnpGb2F4QlNZT0NrVlltVmFuL3VkdmNWQ1JaTDRFT25NeEJrSUor?=
 =?utf-8?B?RW03aDNNQ3BmREk3U0YzYUJ4aXNON0dSNjBTTnJzZE1XRUYxTXpQS2RuMlND?=
 =?utf-8?B?TjcyaDNHT1VRNVhBcDZLVG1WR3hzUEZzOTNMVUV0eG82VWE0T1dpNmFydmhr?=
 =?utf-8?B?Sm9YK0ZndDBlbjI5NnUyS29FTzlwQndqYkJxdUR6NXVKa29KRWpicyt4WkVm?=
 =?utf-8?B?SEZTNWJ6MnJoekhhdnNZV2d0MXIxNi8rbHFBVkc4a04wYTBJdnpXV3RrTG1O?=
 =?utf-8?B?Vk5PRHNRa045VUp1WWRqalowZng3YUdENDZPcnU4eEtrMXVteGlHQ05KRUR4?=
 =?utf-8?B?Nnp0dmlNV3d6S1hnY0JxZmxzdU1JV1NCM3lpcDB3bUdHd21vUW13b25FZlF0?=
 =?utf-8?B?a1UrUWFFazBEZVZEaWZHUW00RXdjZFpOMlZDbGZLbG1xLzgyaVNUTEw0U2NU?=
 =?utf-8?B?Wm9xRDRiN2NIcEcvRnBvZGhMOVlTRktQOVBRdkpaZ1R0QkppNGZRRUNtS0ZR?=
 =?utf-8?B?UGpxRFBVZjlya00zNXQwbkdXMUs2VzluSjhQSTEwZHNLZU5HSGpiRzdEZVVj?=
 =?utf-8?B?eHFhZUFDS2pHbHNzUTFvQStpUTdTbkF5MEtSVjBjMlpxL2RlMllLTHg3UWdL?=
 =?utf-8?B?d0JrYUFBYVdGOGEzM1Z2Ui8vL0pJQXFIejlyekpyNVYrVmZ1aUYwM2hSK3ds?=
 =?utf-8?B?QmVVK2c1K2xxc0JaUWsvM3V2MVB1akpMelVVamNWVFk5eDgwejViWmU5cWVP?=
 =?utf-8?B?ajA0TDllWlNGcVMwYkM0SmloSEMwOVh3NFRnMmNVRU1jYVJEVEMvRnRwbUtF?=
 =?utf-8?B?Q2RxanV6cU55d1pweFM5MklqQy9DTDkzQkZlZ3JjZk5RTzlEV3ZsN3YrWlBq?=
 =?utf-8?B?T2RNNUJTZE82M1J3MlAwL2szVkxoNnhOTHFkMElQNVNFS0lkRkpwbUdpQ2RK?=
 =?utf-8?B?VDJTVUxMYzlUQjltK3JsVXJjd2ROaUpQa0pSeURieURaaXJVaGRMR0xBSEN0?=
 =?utf-8?B?Z2IvTGt5elpDeXBnQS9CY2gwemdzNXB6TEJDTnZjK09NbzNZNWIwWCtvMDVU?=
 =?utf-8?B?SmJFbDBQdHF2Z0ZZZUk1WURpUjB1NCthYzM0UUZ4akQ2WW44S25PN2JaNXVR?=
 =?utf-8?B?Yk83T3gxN2FOTEs1aXNxZ1B3ZXhQbGc5eWVHdXZsZnVQK3c3NE1ZYXBkUzJu?=
 =?utf-8?B?SFp2elpnQmJ1Z1NoaEZzUXBwck5tbm9DNWg2dDBQWWJoM29lZWl5SDQ3cDBv?=
 =?utf-8?B?NkZpeWdaRkg4Ynl3ZGQ2N3VpU01oaW1DdXVoTWY3eVZVQTA5R3NjeDkzQW16?=
 =?utf-8?B?bnRIVkxERC9BblhBNm9pdHZBU3BObVNzTkw5ajR6ZkVGVXZoVTM5ZWNCck1m?=
 =?utf-8?B?TnhqYk81dUN1ekgwSTVrNlhoblRQdTVjbnFFc1FlQXoxRVJSamwrOWxpeFlO?=
 =?utf-8?B?SndxdW5PWVlhMFQ2eFNHVWpXMWxSM1ZTdjk4ZDQwSndNd3FvaEQ3UkNoZ2JL?=
 =?utf-8?B?S3lLeVVZT0VGaWpvMTNUUElnMmVpajlLYk44aE5abUlYZ0VZZlptbmVYMVlz?=
 =?utf-8?B?cXp3SWdOa2VXckZRcCs5dDZwWUtUQUorU1M1RzJoQWJoZkNRSmFTeFBaSWhF?=
 =?utf-8?B?U0p6dG0zcmo4MzJ6aVRsRmFDZ2hsVEpLYlhMVEExK200TEY1dnMralhESVBk?=
 =?utf-8?B?S3YzeHdQazBoZFd4dm5UcWRabE5reWZEWXpQV1ZqNSswQm5VKzhJRHZKL2ps?=
 =?utf-8?B?Z0ZJYkRPZ3doUUEwclIzMUJKdWFCMEJoTHEwTzhYdWg0bnpFZ01qR1pCaWJH?=
 =?utf-8?B?OGFxV05NVjY3MjljcFhsOVFwZm5pcXgySm9xY2p4Z09TcWdZdnltK2xGOER0?=
 =?utf-8?B?MWlXbk8zVmhIRDZiNFhWWmNZRVg2WEVwVWxpT3lDdWpaTHkwQ2lxUlJycWdT?=
 =?utf-8?B?cjBRNlVHMFROZDB1dndhOElwQk5zN3I5TERlajNrSzBTQjFIbFVPMzBybzZ1?=
 =?utf-8?B?NmpuRFR3QmUxamQ4RlBuVFEwODdFWFVwRjh6VTU2RVUvVU5Nd1JyQ0RtazFP?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f9420f2d-6168-4e0e-1791-08dcfb969459
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2024 23:32:13.3447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zOnI/2ZK7jIZ2x1s0ikC0Ij7FnzBGjaHCk9jSMNtWrPE6GxeduQxg22zJjceuaM4SZ92zNpRXL3dlDXOPGkb4pyR87eIXCT/dguE98gBlg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7516
X-OriginatorOrg: intel.com



On 11/1/2024 7:51 PM, Joe Damato wrote:
> From: Martin Karsten <mkarsten@uwaterloo.ca>
> 
> When NAPI_F_PREFER_BUSY_POLL is set during busy_poll_stop and the
> irq_suspend_timeout is nonzero, this timeout is used to defer softirq
> scheduling, potentially longer than gro_flush_timeout. This can be used
> to effectively suspend softirq processing during the time it takes for
> an application to process data and return to the next busy-poll.
> 
> The call to napi->poll in busy_poll_stop might lead to an invocation of
> napi_complete_done, but the prefer-busy flag is still set at that time,
> so the same logic is used to defer softirq scheduling for
> irq_suspend_timeout.
> 
> Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Co-developed-by: Joe Damato <jdamato@fastly.com>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Tested-by: Joe Damato <jdamato@fastly.com>
> Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> ---

Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>

