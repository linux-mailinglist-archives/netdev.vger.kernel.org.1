Return-Path: <netdev+bounces-93866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D808BD6D8
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 23:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B6571F22CEF
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 21:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A9915B969;
	Mon,  6 May 2024 21:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DcRIaJa+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0DD15B57A
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 21:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715030844; cv=fail; b=Fmd8xokYjIC296bswkkiSGXCQdvhpSNrfs23hoyWCPPuhy5wWHmv74U8ZUBsYcTOes0+DZyyy4XYTaJNvvVSJFM+saqkpETJbFLRDHUaCJym9eRvtidVQnLB3KHPJQkd3GFoYxNV/fu1O5yYWUekjmCh0lko+BvVRBoycAj3X3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715030844; c=relaxed/simple;
	bh=HanE/kuOCj8hoVHjflGehnUyIC3UEh+8A3XyIzaYCzY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Erqw+RUEz2LDyvO9gEYBgC01PfPIEgvC9ld6cB+kDDPEOash/60MA9gLwaeFMRag3f+BTdJ08a1tqdikoKJTiCNzwEbLtATU4dnCp8DYkkeowj5uZjB5rxzxLnBFirJLDBdfi+9Bt9QBw0EQnFx3O2FrQGg1arF9pZ5JmuA9DXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DcRIaJa+; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715030843; x=1746566843;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HanE/kuOCj8hoVHjflGehnUyIC3UEh+8A3XyIzaYCzY=;
  b=DcRIaJa+IxjpFTs4qnEF7Az94J73XGG6a6Hi8KkOc97MXjUk+VgGUZNW
   BQSAzL2m9gMzyrS5JobxAUHH+ukdQAaWpTHvj1S4Anei6mNHSCm2DoQiu
   7QWVA6c3lu02SGsXWYlOA4HK+C4zCvjoP/JW8/j1S+lWLujSHCttPpHmX
   bS9Oa8iw4C4JypgRMFtn9t9R188YgWEEmOFsIHRW32llyW057RDVAI/vm
   P2iGy+E3Im+pSm59u4GxMIHzmuJyNzngID0IWNm/IsV00Riey2ObWUg5t
   b5QoMNf/VpGmBHkF1kU9RVPNsAbC4sBtnIs7V43XdFpcghGBRE+9JXI0V
   g==;
X-CSE-ConnectionGUID: 8qlN0uoxRo+f4WmOuMII4w==
X-CSE-MsgGUID: OXMMJzZqQouZRb++UfDM8g==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="13751888"
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="13751888"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 14:27:22 -0700
X-CSE-ConnectionGUID: uDfE2g2hSfiM7lr94w5nxA==
X-CSE-MsgGUID: PJyrXYORR7aY+W4TNEFG2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="32953969"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 May 2024 14:27:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 14:27:21 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 14:27:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 6 May 2024 14:27:20 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 14:27:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hC0NLrzBJfYM6jYTP1R0Xjee3Px2Hn6OjEMbVmqaHKlA0nAKRO4eCnONusipMk7oj5rP7Fj9YJYHrAMXJeaVPC+WGNNZS4IgBrswuFRDvGAhBelFF/THSuGbUXVZW9caZNGk5mQB8zPm12/dRcahj1roalEmKI8Ts/YJsKowIZkYCVCxICAQPojEz8ajm/l9F5RKN83WDHNlS7/cwGWD/HpDiZj9OCQy0+/nSzHdsbyuwi9+XI2GNBBVb7Ptp4EWv39S7y/MejeNpMABjJJgFo0hqXouD7siL4DSIYzRWtjAkOKg4vU55mgIYqviZrEJXqRpk2r267ccA0NR5ddQMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbx9dc7gt+zDU+z1SS3+eQSVPSkdfJLbQOnD1RLDYyc=;
 b=IMm2cBli64GR6VKwjMsJdw/BPLA4WRO2a4woEVkuCf9Bb2aUooFVf+3QTNYrKxfV6TIxoY4TrP9X9hEy2yCMThMikC/LnHfKEZqUYeNL7JOEOkURc6M9d+gT1kYWMUvfhq/KzoXFUaGezvnuYph+OCTU0ELCBzq8tEOvc581HY2pKCqdnX0DoEWulq2/RbUaX5F+7wZexJ9rE0tQnd5QYScNnTcIGaXUH7/G8BE3QtRgUJ4f2jpTmt6ylpt6bxYbCO02KDk+/quUJ6gjTirLpen08gekD5hdgaW6o7DMyf5z51OgAZOMQnUbWeiLzCIdk9/1V5fGXV2ETBFOGZxIWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by CH3PR11MB7820.namprd11.prod.outlook.com (2603:10b6:610:120::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 21:27:18 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%5]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 21:27:18 +0000
Message-ID: <9d359843-e7a6-d2bc-cc7c-e7133ba3662e@intel.com>
Date: Mon, 6 May 2024 14:27:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] ice: Fix enabling SR-IOV with Xen
To: Ross Lagerwall <ross.lagerwall@citrix.com>, <netdev@vger.kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>, Javi Merino <javi.merino@kernel.org>
References: <20240429124922.2872002-1-ross.lagerwall@citrix.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20240429124922.2872002-1-ross.lagerwall@citrix.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0368.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::13) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|CH3PR11MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e9ae3b2-b116-4998-df08-08dc6e134e90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y1FINDVvZE1FY3JtNWtZdnNxd0Q4ZGNiTGdoeThMaW91OUczdEQxdlZkMkd0?=
 =?utf-8?B?VUZneDB0QXMzc3BlYlpxT1Q3OVF1YmszUERhM0hjdGNGQWFJalN1d1dHZUZk?=
 =?utf-8?B?Q0VkWFliNHpPQ1I5eE5pRWxQMmp5MGtlSHNQMCtudldiRG9vN0xONmROTUR1?=
 =?utf-8?B?SWt2RmwzVUJnS0twZUR2M2loQ0ZXdTVkcGwraG00L0k4RzVYazV6OHNybVEr?=
 =?utf-8?B?SzIwTkRUOW5wWjl1M040Z2ZnVDhWTHpxQUQ4WXErL0VEZVdGYVA5WjdDTTBH?=
 =?utf-8?B?TUw5amFmZEx0NW81YVR4VVJMYXNyVnljTHQ0bjAyYS9KL09sZGRwejc5OVMr?=
 =?utf-8?B?ajBuYVRtVFdSM0FJR0pXSThpR2s2d0xDRGVEUWdLY2Z1Yml0Zm1QK1hMSlMr?=
 =?utf-8?B?enJWUDNWWTdEbmw5cFErWnY0UkMxYVd5cG53eHprOHJza0xydlp2WE5nZWtj?=
 =?utf-8?B?L2pqRElkVEsvQzdRakJjQkFKM3hsYnBzZXdLR0NLTkdiQ1hqdHF3Vlp6ZkdR?=
 =?utf-8?B?RDRsSFlBR1pBTzhOcm42RVorUGlNVVpQdWp5N2ZOcjJqTVV0Wm1RVEltVFhm?=
 =?utf-8?B?NWlUOVpCK2hLMWtzSTdSVWI2SVRJQkVkM2M0UGlWeU5YZVpRc25aMjh2aWMw?=
 =?utf-8?B?QU5UZVF2WnNxUG9sSHNBdEwrRzdNZmJZRUNLMkxYOUhpbUwzdGhoY01xQTFU?=
 =?utf-8?B?bXpwdmYxM1N0d1EwMjJMSXUyT3pnblR1WnBVYkdmMVdLbm9keVNkS3g4RHh3?=
 =?utf-8?B?MHBXUEs3UVIvVGgwUFNoRFBEZ0Q4bW5hc2NKS3VHc0t1VGcybTMvN2lsV1Ex?=
 =?utf-8?B?VFRNTHF4a0FvQjhObDNCb3JETkN0SEJKazJzMEM2S1pqd21uT1QxTDdOU050?=
 =?utf-8?B?WW9HcnBhaXl2cXBQZUlWeVZUbkFMUUtQVTI3bHpITkVQY0lrOGkwUlhGM0hj?=
 =?utf-8?B?MmM3TStTQlJBRnhtNU02aGlhQkJLYnIzM2pUeWZpUDA2ZHhjTXk2RjZ4dGZz?=
 =?utf-8?B?SHNGcW5LZkZuZ3hiN2FGbGVvSFF4YlhDVE5aR1lZRVVQc28wZm1SdnJkdGVk?=
 =?utf-8?B?eWYxNVhBQzByNWVDbEFadFZlZk1RT2RjbXBBSWN5WlIyRzE5VWl5Sytjcmg2?=
 =?utf-8?B?NmpTRGVXcTd4RXBsZGRVQTQwelgvUzRVYUlIZWVBV215UCthRUIwVjM2d3No?=
 =?utf-8?B?MjVBTlNzWnZLY1ZYanF5d2hhWjNKK2lqUXdMdkVGOUhqMWhTRGhwZi9rZnhl?=
 =?utf-8?B?QTBMS2o4VTZad1NFWlBZUVJMSjNmZXZQQXBWQUdrWkNEUk92MHlxVm9NZDNI?=
 =?utf-8?B?SUJHUHhjZis4N3BlNDc3ZXlwQzVDYXNOODRIRXg0NXNPSjhEUGZWcnRWY3Z4?=
 =?utf-8?B?ZE56bW9OK3FBL0RJZnFSalFtR2I3K2ZTZExQYnJXclRuRGJEYmdhcTh3Tnkz?=
 =?utf-8?B?ejBoTGMrMTFLbG45WDdKSU85UVhSMWs4b001ZXF2dEVhZGRpKzV4T0hBdWdj?=
 =?utf-8?B?SllMK3ZpRHdDTVpCMVhnYjdVRmZBYmZ1azlpM0J5WElEekRxSExtMVRJcjJI?=
 =?utf-8?B?Tkw2V1dhRWxva2tnQzIzL096SlduTFlxZjh2WTZOQnBSanFMK1kwMW9FMlA2?=
 =?utf-8?B?aW1XVlJoZXlqQW5ZYWpzOHlmcWN3RDZzdGphcmRFYXJkYm15a3AxTHZoTFY1?=
 =?utf-8?B?akdzZUhFVk1IM1QyRytIOTJ2Z3BPOFExMDU1UmVxTXhtbitkVmoyMll3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXRMRlhTZGlFcWxRdHZxOHJEQk9wOHlBT2p6Z2NYazhCemJCbUEyT29lRnFu?=
 =?utf-8?B?alJKeklyMmVuaXVRZVA5V3hYRFZOOUZqQ21ZMWNSZWJNcHE1ZGgrNU0wamdP?=
 =?utf-8?B?MnhpcGxUYTc4WEIzVWFFMk94Y2JveHhNdktURXNTQVd6MHNOVzgzcFJyUXh5?=
 =?utf-8?B?dmY0RUNPMGhJOWFteGFWdDdiclduSjg5cllUZW9SU2tGTGV5dWpUM0RkYmpR?=
 =?utf-8?B?eFpYNDI3TXEyR1Zzc2F5Slg5NmZJMk1ZR2playtUODJLWGJaNU1ja2hiUGM1?=
 =?utf-8?B?L2JQOXRiMFdWdm1MTFJqbTV6ZEc3TkFLbExOZzhDbTJ4NzFIdE5GSnJ6QzRK?=
 =?utf-8?B?eHF2dzVMY0J6QWRBYklmbW1KVmdpS0ZKQ2RuQUx2dTRKb3pGT1BvUm00UFVm?=
 =?utf-8?B?QytXZERGSWVVczRvZnRoQWtZTENVYVlKdjJpQU9lbVI2ck9mdjMyOVYxcjVi?=
 =?utf-8?B?Tit1Q2lVQkovL3pEYmxqNU0yckRrb0hMa2JVeklsbkhRTGlGcTYzSHRJYkdy?=
 =?utf-8?B?d0owaEwyVG1aWU95VWg4VHZxNW5pZ3VmK2MrNU5ibEhuRGJPUjhJT0NGb3NS?=
 =?utf-8?B?YzJkb0ZjTndwSnNSdDZucmhwZUNpczdWcFU2MitNUVNHdGRVZkFOcUIvTmRr?=
 =?utf-8?B?R2gvc2oybURkaGdxSk51bFFPWDNOY2I1d1dHYlRyMWtUeUpsOEF3VEdtejRI?=
 =?utf-8?B?bGx0TXVHelJpNlR5SVZJOTFRQSttWWJsVGM2eXhIWjR3bFIxRWFkaWJuQWJ1?=
 =?utf-8?B?VmdwYVdaRTBOT0lMUWZVYW9DQmtYL1VKMVJ6S0gxWWhqQW5tY1lVQjlDdytv?=
 =?utf-8?B?SVdyRXN5dDh1cUVtLzAzQXBGeFFUb25yWXAxN1pDVTYxTWhOdzdDVTQ2WHcv?=
 =?utf-8?B?WkJnVFc3SFExVFlwbW9DWHpJVld5a2VvN0hWa2RaL1l0UWp2bzZQNnZ4eEdF?=
 =?utf-8?B?cmpFU3RySXFwQWVvckgzRU1sd0VaUkRLSWRBcHEzMkZnZkUvRFA2Zmhic3hP?=
 =?utf-8?B?eXpLQ2pBN2pQaWhqY3A0R1BrLytCbW5NRnZGbElSYlc3SDh4d2xTOFZMU1RY?=
 =?utf-8?B?RU53Wlp4aFI5eEphZHgvK3ZPU25ublYyd2xybFJmQmhqZXlSeDZlY3V3SUx1?=
 =?utf-8?B?Q1pVZFpTejREbnBXYkNlMzgraWRuajlqMmJkanRKbndFaUY4Z3pSV01LTFhV?=
 =?utf-8?B?UkgrckNnbUxvVDFHUCt4OWc0dG9BZnErZkpOOFpDcUJseFJmWDREZmYyaWp6?=
 =?utf-8?B?NXQrT3JCQ3lDY3k5T3JzdXlDeHpqMTJFN3VYVy8zalU2V2FwYThzZU00b1E1?=
 =?utf-8?B?OEpQS0FjbVNBRzltNUtLcXZEWVlOQkp0dDJMYWdodk9zcGlvMTgyVXVtTE1X?=
 =?utf-8?B?WjR5SUIrTXhMRU1jSVl3RWZnaHU4U1FaMkhTSTBxNUJMSHo2azZ3NjFBdFZQ?=
 =?utf-8?B?MkJRTXZpNzRVY0pzUGN5NkpaRlNDUndERnoybURJRlVhZ3RYZ3Qvd3RwK3JB?=
 =?utf-8?B?dDVieDFmMkZIWDQxYWlYSWFRTkR3NkkxakpHam1Sa3Z4RjdNNEM2WWtTNWFR?=
 =?utf-8?B?b0RSeFN2MXUrNXFIWkQyRTNFR3lFc2NyUXd2ZmlxTEtndjZTM3NxUzhFNkgx?=
 =?utf-8?B?bHpzSGZlVUNBQWh5TXl6cFR4TDd5VlNzV1JyMlg1cXVEdlB6ZDVUdHBtWXF3?=
 =?utf-8?B?RHl3U05RTDZER21pT01JR2RaSE03V1dicHlGclFRdmp4Tyt5MlRuVVc3Y011?=
 =?utf-8?B?VjQrK2ZWdTRhSHBJaTgrTFpNV0RsSTZ4UnVGZytlZVBScHdjQXlGd2hPdTdJ?=
 =?utf-8?B?a0tJZkhBdFEvaXYvZGNnNWRETUVmNTZuS3FsMkRmT2RrK2RYYnlZbitKTjRO?=
 =?utf-8?B?Zi9vZ3B4NUtNWVRpYkRFRDQ2SStxbXBrODhwaWxiMnhCcFZTQ1VsUEtuclRP?=
 =?utf-8?B?SE14VGJHM1hxbEUwSDU2bkZGTVJOZ3ZPTXNLVEFLYkIvNmdPTG43TCthN0Fl?=
 =?utf-8?B?KzhzOEoxcEI0Rzh3UFJJd1ZTMlVraUlnaFRxcENnbEVydFUxRHM3UzUxQ2Nw?=
 =?utf-8?B?endSajNRRXlPVWJDd2VaVGlnM05LWVFyazlnNjVxKzROZVhLYjlYaTkyUWRW?=
 =?utf-8?B?eTcxVzQ4WFlNYWoxMU1QbmtVU1JEeGt5eFhGbkgzOVdqWEh4SmU5SktWN0M2?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9ae3b2-b116-4998-df08-08dc6e134e90
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 21:27:18.4154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Epr2olsIdwZiEZ8GVLtJ28b09UASRTdDbUUn7xab86oH0U6Lxs6g0IEDj1++dLAJgoD3i5QIm+OGQacwYbAj/zUliujzu99t2kA97b3pDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7820
X-OriginatorOrg: intel.com



On 4/29/2024 5:49 AM, Ross Lagerwall wrote:
> When the PCI functions are created, Xen is informed about them and
> caches the number of MSI-X entries each function has.  However, the
> number of MSI-X entries is not set until after the hardware has been
> configured and the VFs have been started. This prevents
> PCI-passthrough from working because Xen rejects mapping MSI-X
> interrupts to domains because it thinks the MSI-X interrupts don't
> exist.
> 
> Fix this by moving the call to pci_enable_sriov() later so that the
> number of MSI-X entries is set correctly in hardware by the time Xen
> reads it.
> 

Sorry, I missed this on initial review, but bug fixes should have a 
Fixes: tag

I assume you are targeting this for net, if so, can you mark it as 
'PATCH iwl-net'.

> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
> Signed-off-by: Javi Merino <javi.merino@kernel.org>

Also, sender should be the last sign-off.

Thanks,
Tony

