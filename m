Return-Path: <netdev+bounces-112680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 373DA93A90A
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 00:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89CD8B20D34
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 22:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC69143C4B;
	Tue, 23 Jul 2024 22:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MWUbnntd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D63E1422CC
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 22:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721772316; cv=fail; b=sPsHODN43s0K1DnvgU63i8IGm5hFoAvWc6gtJo3sZnCNO9dNesBl19M/9J2uH66l4OEua1ZpUaEivCkho62BV4QYY2dJpvKndXXxILteQrDBsSEYJeg6EUtMx3Z/K0zPqUzIZbmHbQQBVBgaBCRa3+Qni7LHVdnD+0BJ3OduZic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721772316; c=relaxed/simple;
	bh=Df1TFZJD2zOSTDZRezyZx7pWwLjpSALO1wo4vVKAFUo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rE6SQHy0NhXzP822gOi6hBQ7Ih/OZwuz6sSbnssV2UO45jqGJVbCXoNAD09PM9VM46XY1FlormnG/VbmUFo2zN6YjXvsNtTRuDJ+WQCaGpJjm9UJmq0mPGhpJ2nlnqax/BraH3oHEPU2Q/hn7NJsk559FKcB7p+xSsGKNZDrb1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MWUbnntd; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721772314; x=1753308314;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Df1TFZJD2zOSTDZRezyZx7pWwLjpSALO1wo4vVKAFUo=;
  b=MWUbnntdHcc4MauzQqVJb18SjjwoMhtSQpOsG+NyOl5300+7gLQPLH7E
   aBfLNQ2F2buFkYejfSzANRwl+2cfZAlE6V+lWmr1YE5nhuXgOuHMz47XX
   tHlheRFBQ907avvir9ETBAPnAYu0M4qxZrKVsrDyiuCBc+MJ5xL0a7uGc
   Gco08l/y9cHZgBfgXGwbYvwhMm4Oah74Pwj9R3tC/2c//N3iChPPXtSYc
   nJPEmTT4IOW7IzewiGy8yZuKwJzGdze2pcio+FbUK+lIr9Jn3yFruJZN5
   CUULQpIq9mBkloA+Y+5oen53GBQQJdtUixpnybLhD+3rIQI2jrqgpUX+H
   Q==;
X-CSE-ConnectionGUID: bp14y77aRkunUfD1A5kwOQ==
X-CSE-MsgGUID: XU3dhzvgRaiZqQnEsr+naw==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="23288644"
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; 
   d="scan'208";a="23288644"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 15:05:13 -0700
X-CSE-ConnectionGUID: Vty0RB1gSCGWqZmrysGIYw==
X-CSE-MsgGUID: HBVYBEc7R929yl2EtAVDDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; 
   d="scan'208";a="52265174"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jul 2024 15:05:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 15:05:12 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 15:05:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 23 Jul 2024 15:05:12 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 23 Jul 2024 15:05:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TuMoAgBjClHe8M9R8XLCCp+4QTCyZLkj/5LaOLbz703tjdoxHfx/nube1gP/80hacXfRmSebDsuJ7GGFmxacnW5Ae+gADPkz6I2JwVyW92hUBvaoAyNtC0Iep1XSBQ3MQ4TU2atlkf3Na28Ph5a6xeBK4QrGW2OAAQTKTph85jICSfAhsr0Z6ISKIEIB2I8di79E9zSNwfTt+f29aqturhJ4gMMvkBWWHrJ3mmFZ8fCn4OsUmMEUcpLCmgmmmcD4bq1M20tjtS7VoWKW1k5D4f3DCpInB1BOS0M+fkq09kz7jJd399jCD6E/OX2eYlDGo/nx3/Op68V77G2NtjVohQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JVm/tiNd/I4YLXZUJlm8JjJOH4mhhXinM4JpXZfgyE=;
 b=SVku7PPfQvX/uM3e3QHIabemONE36Imc9XD489Vf3svGpI4ZzaZeLLdSxlSKmNnP5fGi9Sg+Pd6JCH09DfxaY2DrerTcxEQSBfTaSCnsxJ6WlvxUzsNpz3pa3WMUL8c/6iqwqlziyn4ORelg/w1pndFK2VI7Bh6WAr6/z1dlqKcHnr76Oc0grWeRZGqZqmZC+05szcGEuYIKfAtE0zzyE26Y7e/kHypanSsKr/I5+SJQHUTdVTxIA+qSSrhrY7XMajDtDsxIHzTCxDHvbTDlyXPTQHdL3PudOJP7JUmukWMGkJvku8+02fvUrMrjoH0jQbs52AZZl6pA+5oQ/6fsOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by SA0PR11MB4734.namprd11.prod.outlook.com (2603:10b6:806:99::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Tue, 23 Jul
 2024 22:05:10 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%2]) with mapi id 15.20.7762.027; Tue, 23 Jul 2024
 22:05:10 +0000
Message-ID: <2b992595-5b6b-e741-0dd0-f1e45538e68b@intel.com>
Date: Tue, 23 Jul 2024 15:05:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 iwl-next 1/4] ice: Implement PTP support for E830
 devices
To: Karol Kolacinski <karol.kolacinski@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <przemyslaw.kitszel@intel.com>, Michal Michalik
	<michal.michalik@intel.com>, Milena Olech <milena.olech@intel.com>, "Paul
 Greenwalt" <paul.greenwalt@intel.com>
References: <20240711092757.890786-6-karol.kolacinski@intel.com>
 <20240711092757.890786-7-karol.kolacinski@intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20240711092757.890786-7-karol.kolacinski@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0045.namprd07.prod.outlook.com
 (2603:10b6:a03:60::22) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|SA0PR11MB4734:EE_
X-MS-Office365-Filtering-Correlation-Id: b543f48f-586d-422a-531a-08dcab638510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVlOdWpIN0RPZzZ0WWo3Q1g4QmZreEtYMU1UczZPeTRMYmRMak5DQ2JZUGJi?=
 =?utf-8?B?Ly96Z1lNWisvWUlMY2xjd050VWhORlFjRmEyQ2xhcGJqbGNzT2MvUFA4bUVO?=
 =?utf-8?B?Z3I4VnE0d25aeWNTYWdXSklPVElKSDgzUWY3ZFJsd0w1K001cnRoU2R4L1VZ?=
 =?utf-8?B?UE9XL2VJbGNzOVVPQk9LQW9sSWdWdGtYN1EzYjlRTHFjc3FzVHNhT05zMjBx?=
 =?utf-8?B?SFFtZExicDRKVzRuVnNtZ3dwbFNZWDEvVlJ6QmdlV1kzVWR5WGlzRWtId3VM?=
 =?utf-8?B?c001YnpvRm9mc000VkVZWkp6dmU1TWtldG9EKy8vS2RqV3M4R210bXI1Tm9S?=
 =?utf-8?B?QmxxUHJsNmRrbDYvbmZvRnRnUGNUVzd3MlZINjU3U0kwY1NIRkx0UlhQemFq?=
 =?utf-8?B?UjNrTmk4TVRKNnJVRFpKS1VOQVRibkgyT2szSSsyN1cwbTlvQzcwNW11WWVB?=
 =?utf-8?B?ZE5BdGZJMHIzU0lMZERTbFViZ3JwdFFTMHJTMWJyNlB4NVpaVE44dUNsTHNi?=
 =?utf-8?B?bmFmTnYvUm0zMnQ3NnF5VTY4SUJ1enFodTFHQm9qV3VhVFNTT0NTZythN3pJ?=
 =?utf-8?B?N3NNOW9WOUZ3dnJ6ZXl4aTJBc2tMdDZOUXpjdHFxeXpHYi9QOE9FMVRLbjQ0?=
 =?utf-8?B?c1lDbFJwVUIyOVpyYzR2S3JibHFrL21CelRNSmw5MnJxNkZkWnM3aXN2aDZ4?=
 =?utf-8?B?SWd6SlBlR2s0Vm5pcXNYaU1XQ2lodWRrY1l4eUFNc0RaVWU0TTc3alo1ZG82?=
 =?utf-8?B?c1dtTGE0QWI1YW1ZNEgxWFRRcUNIVlRnT3k2Z0NjMEt5cWRHanZYdXI4UEtr?=
 =?utf-8?B?NnBSVUtmekN0VHZ0ZkNocnhsQ1RrL3RPR0RLUmdIUDFnYmYrMHVCaXRNQ0Iy?=
 =?utf-8?B?TkttcWdwK1o3b29HSXhXOHdKNTRxRmc2TTBJaUJzaDkzb2o3WVFkNkkrU1Ru?=
 =?utf-8?B?bTB6akJnOXpTdE1Zc2tmYldyQVJia09IRmdKSlFZYk8yM2F5NjdSUGRmRU1F?=
 =?utf-8?B?enpPZHFWVHEwUU1ma2dWOXRpT3FqbHpDTEVNdXBpRWErUEFBeXpNZzI5N2xY?=
 =?utf-8?B?TVZYYmd2ZU9LQW1taFRhbnVUNk5Idkc1UWNFcndTV3FvbVBweTJJNllydms3?=
 =?utf-8?B?UytsajYrdVFQcWF4bk1CSlY4bFNzcXJJalp1NzZGUG5sZTE3UEhCclVOaXQ3?=
 =?utf-8?B?eldqVzVRbzRpaU42a1JKR0tsSEYyNXRTdzEzVXJvcXIxT1RERmFKUGNNQTMy?=
 =?utf-8?B?VkwrZVlWUnZnSzQxYUpVb0EwZGROVkFlZktrT1lsNXpZU0NaVUJ1ZVRpWnRR?=
 =?utf-8?B?SWRYRDRzTyt6YkRkWHUwYWM5QkJZb0J3MWxRclNucGpwZGtvK05HQlpTQnM0?=
 =?utf-8?B?K0xiYllZdkVWL2k2VUppc214eGtSbHNiQlFVUDBQL1lRUUZtZkprVHFTeVp3?=
 =?utf-8?B?UDJuSG1pUFZ0OHo2Q3hDYkhlSzhGQjc3V29XSHZPUEhQSTRpeXRHTFFNTjNa?=
 =?utf-8?B?dytSQUZCbE1KSzJpOGVPZFNGLzJnNlJ6ZnUwSk1sNnIyV3BZcGJhMnNmWmJF?=
 =?utf-8?B?TDQ4dHZ3WE1QU2diaVBYWXB4ZVYzSkl3UURFQW9vZ0FlOWQ1anlPYTRwQ1dp?=
 =?utf-8?B?UlJ0VEV0eEt5bUpGLzYzSk4wejEydEpxQlAzYmVYYUZaYlZlL2RlVXg5VlBm?=
 =?utf-8?B?aWZuckkyblg1NDNHU1RRRUlMTnRyREY4QTJpdEllRkgyRlVuMVhWaFV3QWRE?=
 =?utf-8?B?UWZDbDRSNm0wWmpyRVYzSnBuSkR1TEVoT0NEa0R4SzdaSG1hem9iekI3LzdJ?=
 =?utf-8?B?N282VnRaMmZtMkQxU0dMQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEdHTEhBSHdOTnFLZzJsdWM0UXpMTlhYVnlxT1pxV2F5MUNGckUzQjJFdEtq?=
 =?utf-8?B?am45L3JObmZ5eVJlb0ZVaXhVTktTMzFZWHUxMno2ZTJ1K2JrSzNJbW1ialYw?=
 =?utf-8?B?OVJCNUJEYzlqMmlKODlWVTBtSXdMblJrVGRFTDF2ZXhGNy9JZ05oSkhybjdY?=
 =?utf-8?B?MnVWUlJWK1dPMGl5ZWFxK0dERDRMYUJIV3hkL2h5dm9LZ2R0c2R2cHdzcnp2?=
 =?utf-8?B?MVZjL29kUmtYZUZmem9NZXJKM2luOE9pVXExN2I1VkE1S2VHT2huZmkvQmRS?=
 =?utf-8?B?VTlzVUtOd2wzSDE3TEN1VVhrOFhHOE8wbVZyWGQ1TDFQQzlVQUlvRjlwMVlZ?=
 =?utf-8?B?UThRQlU1ZnUxYXFjdU5pc3BpSkpvbUhTbGFtbzJ2MEpycTBsV0VGRkYrVnJY?=
 =?utf-8?B?NUpTMkgwMUNwSllEWm9mZitaS1pWNW5wTW5GUENWUUZ5cEkzaDRucGxhNC9V?=
 =?utf-8?B?SmFWaC9GOTVDTXhTYlRnY2tZRDFRSStWRldpL0p5K294VkxsempTWjNMTmpX?=
 =?utf-8?B?M3hMbWZ3WjFjNC9mbDVIWDM0cDVvelpqREVtWU5PTUdJWGZWTVJJZHY0RDlm?=
 =?utf-8?B?ZThXd1dhcTJCclhkTDJ5dWIyUVRCWkw2WFJOaC9SemxBenFXSEtET2MyQWJl?=
 =?utf-8?B?TUlDTzRGMTlUZjYzaUo1aHB4eUN4eGVhUE94YXErWlZBV1dLd3RObEVUeWVE?=
 =?utf-8?B?aU5yZW5jUlRJY1VNNk05TGdvN0lwdk5iaFNnQTk4VXo4NU5WeE1QcE9EdmFh?=
 =?utf-8?B?M29ZQno2K1pmbk11VDNvSzNFRHAxM2RLSkYyc1dRN21FbnBtd002NnZCNzFw?=
 =?utf-8?B?dk4zVFBmdUxpUk56MzFFaWtralBxNlJMTEFYbTBOWFBkdTNzSHdoUjVhQytO?=
 =?utf-8?B?ZWtnWWszVlBzVWM1eERveGRFRjNZV091WW5samFHRnJiM3RCUHYwOG5jUUpq?=
 =?utf-8?B?VlRMSjBhdVBMSTVvQWtMNm40UkY0RFNOTUxXTlluT3lTYXVIdEVvbmhYRFg2?=
 =?utf-8?B?QmdBV3pSaEZHZmppUURvb285ZlpPUStSVFhucEI0WGw2cXhRNndzcGZQVG55?=
 =?utf-8?B?MmZTVUVKM2tSRm1rN1B3V09JNTVCbHo3bUVzVnFRSVE5c3NuaHFjTk5vVzIr?=
 =?utf-8?B?ekFUcEc1OFg3OWEwVXZmRjFtTGRLbk9HbkNGb0UrQUdXWUpTMVo3N3Q2Ymhn?=
 =?utf-8?B?bGt5M0R0b01XMU9IY0xmNkZlVEpYTHl4NW93SldWL29RbjJjWnpzUnVuQWVp?=
 =?utf-8?B?dFJSYjBiaHVRUnJrSkEvOHg4REtuVTVUMGZMeWdPUVZJc0Y0U3U4aVhTZkI3?=
 =?utf-8?B?cmhGR2FkdjhHWDRnSUhrZk5sOFZCY2NHRlgvZnhQMjI4bWJHTVZTVkJTSTVl?=
 =?utf-8?B?SlpiUGFQbE1NbERtQXNoWWhrcjFRVjJpbkdOelpJZ3JGS3VyWTNvNXNBRkIr?=
 =?utf-8?B?aXBNb3ZsaXlwbTBxakNQNmliYXI3bVBnckpPdmhESGRoVmYvNTZxQjlIamR4?=
 =?utf-8?B?TWt5dHZNV0xwQ0N1bE42bnNiSWNITzRoMjU2V1Z6TDRBVnVod3prVjZ6UXpP?=
 =?utf-8?B?NE44QTRyVmh4K2E3cXRtY3MydWI0dk51bmo2b2U0Qi9YT21Xci9xN1RSV0Z6?=
 =?utf-8?B?NVZBQXRGeVl1cTQ3cFp6OUZuaGhrK2dzckRrekZZa2FhcEExVHhnWkd4Sy9k?=
 =?utf-8?B?d05EOW1pNGhxaU5kclBYVGprc3A4TUd6aU5aM0haQm1PUllPbDY2cW5tV1lN?=
 =?utf-8?B?aVRLWFA3WFN4b2FMSkU0MFB2NVI1MmYxMDdrV3dlN2RIS0RxbUZZNlA1cEt5?=
 =?utf-8?B?ODVqZW1iVEh6Qi9NUGZXQ0VDSHFRTFd6OWUvUDNCVXlsUmVYaVh5RFFTNEY2?=
 =?utf-8?B?RXpIaWhIbkZzcFB1aVdibnVjcWp0Ylg1S0NpaGZCWmRCVmhlUlNWSm81c3FL?=
 =?utf-8?B?OEN2UzVZdDNkTVUvc29wT1cxWmErUks3SHZsVWtBeGJoZUlRRHRVdWZMcWNy?=
 =?utf-8?B?WTM2aWhXcVJkOXR4NzVtenNxcThIYk9PQjZVUVFBSVR0ZUlqTHhNd3ZhV2FV?=
 =?utf-8?B?dUdFUGRhcmoyZVBwVy9DMU1aMms1VUNnazhZU3l4OWFVeGtQUVBSK0k5K2JC?=
 =?utf-8?B?Q2cxU3A0RC9RL0dnSkhGaEtwL21TUnhTaURhM0tqNDV5VStqODlWNHFuWTFu?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b543f48f-586d-422a-531a-08dcab638510
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 22:05:10.4181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GwvfJ7NWb861ZznDVHePbsIedMTioWKokzHvp43hEK7DBmq9phnCHvV37FvHLl4tVsHFcr+BX0iznBdUbgjB404l4kr/pGpiR4t129lpOr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4734
X-OriginatorOrg: intel.com



On 7/11/2024 2:24 AM, Karol Kolacinski wrote:
> From: Michal Michalik <michal.michalik@intel.com>

...


> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -307,6 +307,17 @@ bool ice_is_e825c(struct ice_hw *hw)
>   	}
>   }
>   
> +/**
> + * ice_is_e830
> + * @hw: pointer to the hardware structure
> + *
> + * returns true if the device is E830 based, false if not.

kdoc is looking for Return: or Returns:, please fix

> + */
> +bool ice_is_e830(const struct ice_hw *hw)
> +{
> +	return hw->mac_type == ICE_MAC_E830;
> +}
> +

...

> +/* E830 functions
> + *
> + * The following functions operate on the E830 series devices.
> + *
> + */
> +
> +/**
> + * ice_ptp_init_phc_e830 - Perform E830 specific PHC initialization
> + * @hw: pointer to HW struct
> + *
> + * Perform E830-specific PTP hardware clock initialization steps.
> + */

It's also flagging all the new functions for missing the return.

Thanks,
Tony

> +static int ice_ptp_init_phc_e830(struct ice_hw *hw)
> +{
> +	ice_ptp_cfg_sync_delay(hw, ICE_E810_E830_SYNC_DELAY);
> +	return 0;
> +}
> +
> +/**
> + * ice_ptp_write_direct_incval_e830 - Prep PHY port increment value change
> + * @hw: pointer to HW struct
> + * @incval: The new 40bit increment value to prepare
> + *
> + * Prepare the PHY port for a new increment value by programming the PHC
> + * GLTSYN_INCVAL_L and GLTSYN_INCVAL_H registers. The actual change is
> + * completed by FW automatically.
> + */
> +static int ice_ptp_write_direct_incval_e830(struct ice_hw *hw, u64 incval)
> +{
> +	u8 tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
> +
> +	wr32(hw, GLTSYN_INCVAL_L(tmr_idx), lower_32_bits(incval));
> +	wr32(hw, GLTSYN_INCVAL_H(tmr_idx), upper_32_bits(incval));
> +
> +	return 0;
> +}
> +
> +/**
> + * ice_ptp_write_direct_phc_time_e830 - Prepare PHY port with initial time
> + * @hw: Board private structure
> + * @time: Time to initialize the PHY port clock to
> + *
> + * Program the PHY port ETH_GLTSYN_SHTIME registers in preparation setting the
> + * initial clock time. The time will not actually be programmed until the
> + * driver issues an ICE_PTP_INIT_TIME command.
> + *
> + * The time value is the upper 32 bits of the PHY timer, usually in units of
> + * nominal nanoseconds.
> + */
> +static int ice_ptp_write_direct_phc_time_e830(struct ice_hw *hw, u64 time)
> +{
> +	u8 tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
> +
> +	wr32(hw, GLTSYN_TIME_0(tmr_idx), 0);
> +	wr32(hw, GLTSYN_TIME_L(tmr_idx), lower_32_bits(time));
> +	wr32(hw, GLTSYN_TIME_H(tmr_idx), upper_32_bits(time));
> +
> +	return 0;
> +}
> +
> +/**
> + * ice_ptp_port_cmd_e830 - Prepare all external PHYs for a timer command
> + * @hw: pointer to HW struct
> + * @cmd: Command to be sent to the port
> + *
> + * Prepare the external PHYs connected to this device for a timer sync
> + * command.
> + */
> +static int ice_ptp_port_cmd_e830(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
> +{
> +	u32 val = ice_ptp_tmr_cmd_to_port_reg(hw, cmd);
> +
> +	return ice_write_phy_reg_e810(hw, E830_ETH_GLTSYN_CMD, val);
> +}
> +
> +/**
> + * ice_read_phy_tstamp_e830 - Read a PHY timestamp out of the external PHY
> + * @hw: pointer to the HW struct
> + * @lport: the lport to read from
> + * @idx: the timestamp index to read
> + * @tstamp: on return, the 40bit timestamp value
> + *
> + * Read a 40bit timestamp value out of the timestamp block of the external PHY
> + * on the E830 device.
> + */
> +static int
> +ice_read_phy_tstamp_e830(struct ice_hw *hw, u8 lport, u8 idx, u64 *tstamp)
> +{
> +	u32 hi, lo;
> +
> +	hi = rd32(hw, E830_HIGH_TX_MEMORY_BANK(idx, lport));
> +	lo = rd32(hw, E830_LOW_TX_MEMORY_BANK(idx, lport));
> +
> +	/* For E830 devices, the timestamp is reported with the lower 32 bits
> +	 * in the low register, and the upper 8 bits in the high register.
> +	 */
> +	*tstamp = FIELD_PREP(PHY_EXT_40B_HIGH_M, hi) |
> +		  FIELD_PREP(PHY_EXT_40B_LOW_M, lo);
> +
> +	return 0;
> +}
> +
> +/**
> + * ice_get_phy_tx_tstamp_ready_e830 - Read Tx memory status register
> + * @hw: pointer to the HW struct
> + * @port: the PHY port to read
> + * @tstamp_ready: contents of the Tx memory status register
> + *
> + */
> +static int
> +ice_get_phy_tx_tstamp_ready_e830(struct ice_hw *hw, u8 port, u64 *tstamp_ready)
> +{
> +	*tstamp_ready = rd32(hw, E830_PRTMAC_TS_TX_MEM_VALID_H);
> +	*tstamp_ready <<= 32;
> +	*tstamp_ready |= rd32(hw, E830_PRTMAC_TS_TX_MEM_VALID_L);
> +
> +	return 0;
> +}

