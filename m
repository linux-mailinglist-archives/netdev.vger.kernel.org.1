Return-Path: <netdev+bounces-188481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F02CAAD0BA
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 00:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D7EB3AC593
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 22:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0010921A446;
	Tue,  6 May 2025 22:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="COr4fgGi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3219421A445
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 22:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746569043; cv=fail; b=mPCXsOS4rnpN+cCJU4AEXM7cGVULkpCxkszYDnEpKLA5BVHpgewKjAbPRo8+9CKIyBJtPY9xXfMNbcsPpEUgTrBAWE824QsZJG8KHuXVOJQvuVoxi3wZG79KsNQmGkjQ4QeeFRfFWitslax+mi19w9YmhRiufoz715qG3q1OzMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746569043; c=relaxed/simple;
	bh=9hleeGHoRlT1fURG3mu/l5YX16arp6k7nMwnKs13qTI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LcSjrk4XnfE7WzBobRHvSjJ29iOpsyclMv4UH8y7Sw8kNsnVNqZpjlmUqoJ2BBRNqcThvUheX3RnK2b3RBo33PCnyJHzKLeqYeamtgZEbVg7bTaYLVJKTVYsQcYuvq3Ff2HlgEWbhuaChNftSkmc0fEMF62hUY/1BmLIFCFTiJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=COr4fgGi; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746569042; x=1778105042;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9hleeGHoRlT1fURG3mu/l5YX16arp6k7nMwnKs13qTI=;
  b=COr4fgGibI2Wns/lAI49xC7S6CXdPhIBLBOZhisepPMj0fN0gRywlQd5
   hs8QUDlUU2fhNHW6icdl8AdeIPNLWKsxQJT77XEQJ0aeeXhUD1uWlEwZQ
   K9737Pc+uHcvUb0zxSqMft0yFid+wfi+Xs/csuLtrsvjdm26n8y8nyP7e
   oC4gOmxw5rvIXKw1ib18JK1Z/BOW8EtSBxnuqNM6mFdEQdfrHm8HdPIUQ
   bF0H8X2KBw9Yam+CkcKkV85sRFihI2XWQ1a9fI7VbroE3mc/YiXbie268
   LbsWxv//qm04DtleKHozMu3VDVed96BCmSSpDzpFrwbZG6064QX2ZFaDq
   Q==;
X-CSE-ConnectionGUID: UuCckaK7SUe4cVJJ7ZO2BQ==
X-CSE-MsgGUID: mpQ3jKo1QASonOFEin1y5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="58928142"
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="58928142"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 15:04:01 -0700
X-CSE-ConnectionGUID: 7BwF3LWgTxmESu8VFHYflA==
X-CSE-MsgGUID: Tzs/Jfa7Q96BrVTLEaWanA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="135715557"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 15:03:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 15:03:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 6 May 2025 15:03:53 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 6 May 2025 15:03:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tEUJi07nc7qQlmPd7zVZ8vlHtrZMRA9HKiKI5iyvRQh+B4MhSCImToWb9lhxnKhJWDWrFykLdmYRuzrcd7gq5e2FYXQsKAwUfJUeNNA8qITuCbrUErK3XG7tWTRbQlpsqZC5S/pmCrPqFS8J4zd63Aam83kPUhY6ppOySF4HKlqmc1oUzQA3nqQ9adI5tV+9daP/Gbr3NeeTPVeozmNYs/SPajVqxdtNVuCZrj03u8Z/kVcs5n7KKtzE8IIj96Y8wbEOKGa54I+Rny5+7rbWNlFhoUjgaxAJ+urG2+2V/2lTZJdyVgQk3bApAnvtwVvZa4yKkhOznBpDaEgtmwwFkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/rqdUALuTFKWHj6drw1VBZfy2sKik0MdKH+0d69Ljc=;
 b=i7MwV3rWlN91dBNPsvf+DM1LJCzjXOQkpjQsWl9aCzES81xD+jfjMJhszFag900GIPTmukvfoLA4Wa04v8KXMpbV8kUBLk4H7iPEpUTATX4+V0yFoIHki6JV83/XM2s2UV0chLTTzcJNWXPGSeQTN5i8k/ZruzbL/EsGak7s7qoW+asvVOCacv82SCbWGS1APwv+TGDxm/5d41FZFCmo09yrh+s3yEJepC7uWFDgzO3tY4m8dahOsr6dvl56YlIPnssdq4QyWKfSpFSECP3dgzPavAWNTrC3rnMpyOOn/dyNG45JFPKbVPS97tHu+AQEqwP2NaAmXcMt6+ubYPez4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL1PR11MB6025.namprd11.prod.outlook.com (2603:10b6:208:390::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Tue, 6 May
 2025 22:03:19 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8699.019; Tue, 6 May 2025
 22:03:19 +0000
Message-ID: <04bb706b-5576-47f8-b649-8d7c53cc884c@intel.com>
Date: Tue, 6 May 2025 15:03:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH v2 4/8] fbnic: Actually flush_tx instead of stalling
 out
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
References: <174654659243.499179.11194817277075480209.stgit@ahduyck-xeon-server.home.arpa>
 <174654719929.499179.16406653096197423749.stgit@ahduyck-xeon-server.home.arpa>
 <b85c0c94-6c31-4c27-b90a-0e8c540d8751@intel.com>
 <CAKgT0UdF53M8mJ43SuZNdsF4J4EoDOURwp8X2GaeHi29cn6ccQ@mail.gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <CAKgT0UdF53M8mJ43SuZNdsF4J4EoDOURwp8X2GaeHi29cn6ccQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0234.namprd03.prod.outlook.com
 (2603:10b6:303:b9::29) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL1PR11MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: d80923c2-fd44-433b-27ab-08dd8ce9cf41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RmF1eHE4clFrRE1USnl2ZDRPK0YxNlNNUFRzVWkrSlZRRVRHL05rSzhvVkJY?=
 =?utf-8?B?cTkzLzZWazRMQy9NZWpZa0ZwYjVvOW03TDBqWi81MEtRclNPZHdBMllScEdR?=
 =?utf-8?B?UVVBKzNEMUlVZ2IyZXQ4a0N0ZWRGb0lWbkMzRWhqNWxFL2phWWFyVmx4enNv?=
 =?utf-8?B?Zmg4YVlIYVNTV0ZtSVBSZjdRVmZWdG1SUGJBVTZOYkF2ZzJSUjRERGozS2V1?=
 =?utf-8?B?RzlLVFZqTElrUzNnbEVMdWQ3MGp2REF0Z1VPOGpGUVVEVjNKM2pFdnNkN09T?=
 =?utf-8?B?emFFaXRWVTBzSVJHS3pxNnZ0bi9PYnQ3YnN5dkllbGxBVDcxbS82SHhsOVE1?=
 =?utf-8?B?VWRXVGdrNEpva2VCTG1YdkNtWThybG1aMGx5SlBGVHJQcmpaQzBIcmJiMEts?=
 =?utf-8?B?cVhPK2VBaFI4bElPME5mRkdrT3g0NVZ3eG82K2hhM284Y1k3TzdINE1FL2hm?=
 =?utf-8?B?TjFHcjdGTkNKaUJaV0l5SDJLcXR5eE9ZTnpiRTZCYVFtbTlVS1VMVmpodW5w?=
 =?utf-8?B?b2hDanVSaU9GTUpqSEljZlFmUml3Y2dVMFBrdjVoRHJJc09OdHpvbU5VTWRT?=
 =?utf-8?B?Y1ZteFA3QzIvOEN2YW10MjM3bHpVV3A1aG83QmNUWWEzVlUvZ2JlRE4rbEQz?=
 =?utf-8?B?VlNneVdIbm5oc2NMb0xwOUlLaVczYVdzbis5MFlGZURPSzFHQ1dvd0JMdFl2?=
 =?utf-8?B?U29CNUFWUVc1R2JjcCs2VkZNd0RDWnI5RnZSNmZmY052S2w5ZGRHdXB3T0Zl?=
 =?utf-8?B?aDdhMlphSnNrMEp4MXlFNGdyS0swQ1VsRi9jQmhOTllPU0k2aTJBOVdUNHBI?=
 =?utf-8?B?VFBiM2dWUDNKck9kS0xydFk2a0pOM2NHcG5BMlBVNzVoYjdwU2gyeWFEYlZj?=
 =?utf-8?B?d2JlQkt1WmUxTVdRaVpuaERzM3ZPWHU1UnJFK1RHN0VEZlN2bzZLTVdvbHJW?=
 =?utf-8?B?MGVua01NMzJaY0hXZ2Z6OG9yZ2k0U1pKK0lsZW1UOEV6QUk4VCtiZzRrTXB0?=
 =?utf-8?B?cW1uakFzWDdOK08ySFRZcDJ0U2FqZlZNM1FidXpWUEMvZDkzOVV2ZzczTFZF?=
 =?utf-8?B?UTlPQmo4eFlpSzhtZ1Z4TkVKSDdMWFZLQ3Uzck83TkJPckd3UUk5WDVQdkFC?=
 =?utf-8?B?N1RFKzhkUjJHUkV5SzFwb0cyS0UwZWFnV3c3YUlvQTR4ZS8xaEdOMWxYUDJP?=
 =?utf-8?B?Z3N5N3BHMUxJcWo3bFRHZTVHWHNTbGovM2F4ZnZUZWFrd3gvLzlGMTRDc0Rj?=
 =?utf-8?B?OVp4bUlYb2hlczNIRlBoWlpSN3FQcFhpbFlYeCswTlhuc0hsN1F2cUF6UGNN?=
 =?utf-8?B?dFA0b0ZyU3dCM0h3SHI0UlQ1aDFPVi9rUzcxblpoSElRU2RDdHYyMTg4elhD?=
 =?utf-8?B?V0JOVkNjUk41TmNwaFR3Sy9zYyszaUpoV0ltemh2NENHa21hbWZDTm5JRTVQ?=
 =?utf-8?B?M2JzTWZDbm9BcGpjZzJIMS90ZmNteE42YlRHZ1BiU0laVTE4Z3JEOGJ4TUhq?=
 =?utf-8?B?MVBRVmRwT2I0Yy9RaXhDbE5CZHBCNUNmYUk0UjdEN1pqVEpVRGtUNTR5NGFK?=
 =?utf-8?B?alhmMzRRMDlyQ0g2RGd2cUdaeWh6WjRIWW5aU3pVcklDQ0FVZnplNUI5Q1Jq?=
 =?utf-8?B?clI2UTU2cTd0eGc0bGtSeDBSZWlxeFY1T21lbmp2SXV6SFIyVityekJRSmkx?=
 =?utf-8?B?dXNQektOc2ZCa0NONFd1Z0NhOVRZbDZoZEJFS3NmTEUvbFdrdmE4VFUwSEc3?=
 =?utf-8?B?UURPZDlVSlJtckxKQllpeEd2cnc1MWVOZysxWmJNLzk5SG45YXV2VXcyL1pa?=
 =?utf-8?B?ZWRyTzVXeWxvTlJUYy9OK0tUR0Z0WldFckVGYXJtSFloK254UXo3R0NUbzZx?=
 =?utf-8?B?WGNwcUhlMzdlQlpUZit5RUczbGl5VGZZV2RKVGVTWlJNVGFLeWNCeVc1SFBQ?=
 =?utf-8?Q?yBI16+nhPdU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVpiemJqWGpxbUhWUlNxTWNvZzd1VXRvOTROcmF0eFR6NGdXbmU2UDYwa2xx?=
 =?utf-8?B?TngwazJaRVJBY3NXM3VrQitHOFVqd0NzdEJCcFV0eXI4ODhkWm00T3dlUFhV?=
 =?utf-8?B?dVk2SVJjOEgxZ0VtYXFDWWRmSUp6MTcza2VGSUJZbExjZGlMeGd4N2p3dG92?=
 =?utf-8?B?NTVkQ2VHTEc4ZElmTU5YZG4xUmxZYkdaRE8wTmRMNUFKZXdnaGFZazZGa08z?=
 =?utf-8?B?WWlvVkF2USs5YWRNODVPWEtJdHl4RTNDN0V4ckZXZWdHT2EzYlJ5VVV1aTVr?=
 =?utf-8?B?bzZyMEN2eUZTYnVzTHg2RHhXaEVxYk5tNElLU1ptZC9taHRkNWJ6T084eHNl?=
 =?utf-8?B?dXpPdlY0dXRYMVhPNGhBK28yMVBBK0MvTUVMZE5XNFFNWkNTMlRqV2pmaXpI?=
 =?utf-8?B?L3djVkI2dmpvUm1BenFIRkgwaENaNjlHcm1aKzU2UXFobnlwWDFMRytKM0lY?=
 =?utf-8?B?N0dLTXNPT1ZDSE5nRVJSK2kyRjRjaVR5QlR6a1gxN1NuU1dWaE15VjlmdXFG?=
 =?utf-8?B?OTV1TFFrZjlMY01nTjZSdGhld3B3dUlXdnNYSE1qOC81Q1RsQ1lhNEtZU2lk?=
 =?utf-8?B?QXN3YitGc0Z5VkVNWFJvRENzUVFaYTI0SFB5NWpueDBYT0hZVVN5NGkxa1RX?=
 =?utf-8?B?UUpyUDErd0tzRzRBMkllUlZzdHhzTThHcUYyMEpWZzRjd2tndXNvVitzM2xI?=
 =?utf-8?B?Q2t1a0ZNUzQ2VnZRZkRCak9PQVpoK1dCZlNNVnhNY2RRZ1FXWFg0YkI4bVhG?=
 =?utf-8?B?QVkvR3FRUERMd2Z3RTY4eUNMZDMwWjFxbmRYeXhWQ1Y2OGxoU2cyZ09kcndK?=
 =?utf-8?B?dXBNRU90MXBtaW56d3RyY2t0TGxUd3lKMFdPeDlrRi9BT3REbTg5ZDRXVEVY?=
 =?utf-8?B?c2RERGJvR1FDN05STkk4YjRiTVI0ZjNVTHhQZzE0MWJka2htVHZvUkFuVWhE?=
 =?utf-8?B?UzNjbCtGM1VDSE5pVGFtUE9BMUk5cGZtenUySlI2NWxQVDFVYjE3NHBjaVgy?=
 =?utf-8?B?TzMyQWZNOEtGRDZOVzFuZFVvL0FmMVF6QksvMGZqVmQ1d291b3kzZXdCMDZI?=
 =?utf-8?B?a2NTR0RLYlVaVnE3cE9HRksxaTRUWUdXbXB1blZCeVZZbWtCMXg5YlZLNGNG?=
 =?utf-8?B?L2tmNzFCMWdnUzViV3hueHk2TFlFektjbEIxUy9zbVFUMkV3KzRqVHNZVi9k?=
 =?utf-8?B?ZFJOZkdUM3FVdnV4SDE0SlpHU3dpTDFkVE9EVWVYK3ZTaDRkMEZmczI3MnlE?=
 =?utf-8?B?Z1pzUHpFeU5oS1FaRTIvZzc2SndSZWkvbjZDQlBZL0ZqYm1sYzdEdXcvVktI?=
 =?utf-8?B?L2RnVnlsNFZyUG42czlzVHBUVFFsZDVGV09wUGM0akVvNjJZekYrMmR4S0VR?=
 =?utf-8?B?dnRoZVo4TkpkTXUvdU14LytrRjUwRmxxWnc4ZzBaMnIva1NSQVhkSWJhQjdw?=
 =?utf-8?B?djZRNlE4cFJmaTF0eTBLTHhRdUhRd0J6UjdCWUNSWmE3QjBGU1hhbk43N1RG?=
 =?utf-8?B?TEpPMStEdEF5d2hJMWI4Slh2WElaUEJiUE9hVjRYSTdnTXFGU0lxUnZoSHRi?=
 =?utf-8?B?Tk43VFVFbTdMQmZyL290emxIM2lidGFzenVZRWpVK25YaXB4S0RuVyt5dHJx?=
 =?utf-8?B?cVlrNy9WL3lSZ0xTb3ZQVTRDZitKM0Q4VHdTNmJUVEt3eVJoSWs5YjdIMG91?=
 =?utf-8?B?QUtjMXZZOFFwS1h3alRkN2o2STdnb2ZHUUlNaGtBWEJxTXBxOVY5ZDNvVWtt?=
 =?utf-8?B?VlZJR0doRmdQVjZaTVk0ejUzdWhnM0Iwb3JCQ2M5eDVpOG9YM1oxNWpOd2xa?=
 =?utf-8?B?SERXZm5SY1pLOU9mNmpld3F3ckdnUndCTlQwOWNZSitpTEc3UnppREw4TjZv?=
 =?utf-8?B?K3VPWnFsd1BtZ3YxZmRZSkVTVStlOE9KM0RCMXY3Q3dCNXZZYWx0cTlrbVZl?=
 =?utf-8?B?eXFsSXlYVGJDeHdtR0ltQkZySTBWZ013SktWVDB5dlBFOEFYNHJ6VzlkRDVw?=
 =?utf-8?B?UDhKb3lNRllLK0R3R2c1NHorVWxGeWVWd3RaYVJFbzlJdlpybmQyWlpVTGk3?=
 =?utf-8?B?MEFoYm9ldzhOaFdmdU9tOGdkblQ0VnptOWNDVEsyUDRxOFhJS1dLOUI0cUt2?=
 =?utf-8?B?YmRobDlKbFlBZzZ2dTlUL0Zqd21raFU3Ni8vYUROY2VZUGE3dlIzNTZTemxK?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d80923c2-fd44-433b-27ab-08dd8ce9cf41
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 22:03:18.9949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +DRJYe3ld40pom5uHxx3a86l4IceRdF3AniFcooHcvsH2lD+nl4A1jdgktrYdKpF5FLNcCSSugweXYfqRoHhbdFUXX6+kqkxbRJdXTiSlL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6025
X-OriginatorOrg: intel.com



On 5/6/2025 1:31 PM, Alexander Duyck wrote:
> On Tue, May 6, 2025 at 11:52 AM Jacob Keller <jacob.e.keller@intel.com> wrote:
>>
>>
>> This block makes me think of read_poll_timeout... but I guess that
>> doesn't quite fit for this implementation since you aren't just doing a
>> simple register read...
> 
> Yeah, the problem is it doesn't quite fit. Our "op" in this case would
> be fbnic_mbx_process_tx_msgs which doesn't return a value. We would
> essentially have to wrap it in something and then add an unused return
> value.

And something like wake_event_timeout() doesn't really make sense either
since you're not waiting on an event from another thread that could call
wake_up.

I'm fine with this, just thinking out loud about the different patterns
available.

