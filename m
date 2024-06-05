Return-Path: <netdev+bounces-100910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A92358FC851
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 11:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6041C22415
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869FD18FDAE;
	Wed,  5 Jun 2024 09:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MlPCnwRc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CE718FDD6
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 09:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717580948; cv=fail; b=lYc2R5lU6g1//q3rT4GCo4yqCVEK1MSEUCIE+P9HJDBdZJcpKbH2t7spyJaPRKYHJ1NRFsbTo3uPLZwj6nkVSjTs5qs4mlC9fhva64ER8hxBO9jZLkcbJW7riWeKrUfnj1JSCMJpv0+azCh8abEgUpex2HsAHjj3yzZ3JAbtfkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717580948; c=relaxed/simple;
	bh=NYKX9cwhjxbHCBkLa3pAYWtS6618mqWZm5k7HcqtyEg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lT770R/0cPsFDNW0JZjSvfybY6hH2lhzUNfAX50WSFP2uDezqxi2eqLSib3mayM1/xItbRVCYlhyfT5+XJkokbpBJdr+6dCzS7meTClNhW+WHVzu9uR/CEg0vY+tYURsuuU455ui1FWP4E8mExs+mPknYQTOY7egBm9pxZsXj8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MlPCnwRc; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717580946; x=1749116946;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NYKX9cwhjxbHCBkLa3pAYWtS6618mqWZm5k7HcqtyEg=;
  b=MlPCnwRc9HMThftOtTp5fbYdkJx+K7tYvr1Y9v2e939dvDdTWRygSAf+
   aa8L46AFdPaRO+pYYV6W+Y6J48nPa8dJWsxwn5mfH1x9BFRE2IZVSQTPT
   fWPFCSQnSqT1DPuAzzHzwJLlOIP9EsCOOO9YZDWmJS1FU0edBxF+rREqi
   7W6Yn8ypdlSzEFl1lrLj7NBb2/5WlwRwxsPcgX2NyimGIoE9TCttsKqhi
   Ang/vAdLg6IKGvXA+zgKDu6OM25Wqqvt5n+VlTy8LITbG6ueSPk+wfS2/
   rjm+WCG05dr+mqveMmQESx/d6zJNgAJWeHoGv5UywTLo1NjNYM4yucfQm
   A==;
X-CSE-ConnectionGUID: eX/j4kGeTCizbMkc6skBdw==
X-CSE-MsgGUID: xm57OFNZRgSztdNJY6EsfQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="14062437"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="14062437"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 02:49:06 -0700
X-CSE-ConnectionGUID: XDu3CyN/QZydubl5ZwkUEw==
X-CSE-MsgGUID: VMbsMInaSp2Dwolr/RUo8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="41963619"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jun 2024 02:49:05 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 02:49:05 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 02:49:04 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 02:49:04 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 02:49:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYkWEiGELwp0+etB6hvsIFFLj02hba3CT0AwmyuIx2IVaB+or4zINI6HTWyGzOCB2Q01zPgcID0y6IVQSpJl/pSn68LRf/VbE7FnNJs6sirQPhhEQVaN0qYHUbmP3p5sCZ/nr1FnIiMoM7ms8QA2OfrrdkUnFAlz5jyPW6FHvoakKQjhRSPEG8kMOxZmyEbVymM3gTWupghNKfqU4uvL0wsSqb+BxMtLOSG3Q8Gra8a+KqFV58Mh/TJauU/ad7iINdBeThDKEv50OWYHPKr+vyYot5b3LQNAli+Jff4zmjGlcWeUwMXUJ6gUwPlx3rrbgh+DHJ6jwwKkWW8r98qSSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3TuPkg97YDc/zvX92hGIMWiNHvlOyg/lmuG81Koz5M=;
 b=eW6Mi5Uv+Wlvrdwkzv60p5UP86Ff2erQEE9Kzx8fmBFU5/0sq1UPP3luoV5odDnp5H2w5wL/VubCUSQ2BoaJqcVhUSrGQ3jS7MR809DaKPpfeTHZSB97tuANAbxHR326R482w8O0JAxNvAHEB5pF0FBVi9LwJRavdVxleR/Ux5WxvJ3rmPH/PRepjLgoVvRiptUlIkOr1yycAIVXpKBYvVtmLwRkzRYxix8FEenFQTZOvj+B9stpMDHw7qGSJo3B1EHfWdu8tYM4QDG+kQz3mVu/FQASTGUVGIKP+TbTaxM5GTmXCaTePG2TlNJOAyKehgExAS9eDJONKZ/Vsv0dzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.36; Wed, 5 Jun
 2024 09:49:03 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%5]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 09:49:03 +0000
Message-ID: <15e98930-d026-470f-8e28-d24aa19c0aa8@intel.com>
Date: Wed, 5 Jun 2024 11:48:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 6/6] net: txgbe: add sriov function support
To: Mengyuan Lou <mengyuanlou@net-swift.com>, <netdev@vger.kernel.org>
CC: <jiawenwu@trustnetic.com>, <duanqiangwen@net-swift.com>
References: <20240604155850.51983-1-mengyuanlou@net-swift.com>
 <0511A7C37BEE5C15+20240604155850.51983-7-mengyuanlou@net-swift.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <0511A7C37BEE5C15+20240604155850.51983-7-mengyuanlou@net-swift.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0148.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::23) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|SA1PR11MB8393:EE_
X-MS-Office365-Filtering-Correlation-Id: 13551e4d-bd81-406d-19a6-08dc8544bb77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0NUQW9yc05LMlJmTVY1V3IvcUhJcVpvUjY2OXBxQUt3RXNWVkp6Nmpyb0lT?=
 =?utf-8?B?Z1c4SVIwa01ubTBvUVRwMGlQL2hmTG1HamdXZGJEMEZSM20yK004STd0TTQy?=
 =?utf-8?B?UzIwQkRZRURWS3FBamRYVjgyOC90dEZkaDB3T0crTlJabnJobkhZbGpoOWl4?=
 =?utf-8?B?d0Y3cTY2RzFKS3ByTDJqTXF2Vm1QNjZGQm85RWh0V0w5clJWUjNUK2VvRlBx?=
 =?utf-8?B?aHBJS3AxcUZGU0xMS0JTNXdTNlFnWUhiQzBBQ1plLytGL3JTY21KNjhRMHBk?=
 =?utf-8?B?MzA1UGMwSTFvY3JqaFJONk5zNWhPR1ptT3RrakdMS2wrYno3R1BZRFVPWGll?=
 =?utf-8?B?QUZ1QzNnM3BVaGgxOFVtamVTVXpyUXBRYlROVmI4U0MvMjVzVjA1UlNlaFpM?=
 =?utf-8?B?VHhIVy92TXZaN3ZTUGNaamw3ZVJBTldXK0Z5bHFjZlJiNU8xaDh3bzRjeUJq?=
 =?utf-8?B?WE85bDZYbU9EMWxrWm81Wk5zd05XWVUzNzc4bHUwODdRVmtEc1R4ODhrSlFK?=
 =?utf-8?B?Z1l3WEhvSXpWMzZ0S2FJSWcrUHB4MzdmL3lMT0FLL1R5TFB1czg2dnlsd2NX?=
 =?utf-8?B?WlhlbUdDcTJESHhJOG9ZamxIanV1Y3ZYbUs0czNaK1lQdjVhZ29MUnEyVnhQ?=
 =?utf-8?B?Mnl2c0V4U2trTWJDOUN1RFRnN1BMUUFKeHVFOVBOOEVVNEVmR25NU09WNU02?=
 =?utf-8?B?eGM4dXFjUVZmeTlITW4wM29od0dxZVRhSmlaT3h3MG9QT0lQZTJTVEgrV0pJ?=
 =?utf-8?B?STR5UFpPZWxDSWFIdWNoMWt5TzNRekpwTmF6YnhBZXhjTmlmOVB4bTU1Yk5K?=
 =?utf-8?B?VjQ5Ry9VTGdnMjBDMmFMc0tFTzUveENpV3NIbFpJK3hiTk5ZZlFwM0c5YTZS?=
 =?utf-8?B?d1FlbGc0VVlKUkw3cjB6SVFpcGVTVDVoME1XeElWOUdIRkdxY0NZbkZGVVQv?=
 =?utf-8?B?R1JXOVZGRURxcGNCTXByaFVtdUZPRGZ2LzZ4R2RxcmVCTHZDck1abzBOcWZa?=
 =?utf-8?B?aURCY1U3SjZZWXltZFRmQUFYUk8rdDhDSVh6TVRhOHMzS1owV2ptUXFPZXVY?=
 =?utf-8?B?Y1pRRnY3Yml1ODNBWWgrdFNIVmZ5aFhIejNCcFQzSmNha0xiTFQyTlUwMXQx?=
 =?utf-8?B?WjlQWDNlYlVoZHFjUXVBbXJYcHNRNnJ3UHk2cXNrNHdqNk8xRUdGZTR4akQ0?=
 =?utf-8?B?NVJkY05IUGg1U3EwVmxlTXZqV0RJSW9SUUI5aGN3MkpMZFlSMTdyQzRiN3h5?=
 =?utf-8?B?RDlzYVdQZk9nTExUeUE3anZsZUFNTC9TVGNYMWVMSFhpTUJxNGluQ3IwOGRK?=
 =?utf-8?B?Rk9qSjJCa1pNUFdOOEMyckZEMGY0a0JpVEpGSlo4MFVNUUN3QkpMbnY3Y0pJ?=
 =?utf-8?B?NW5UTlk5ZVFaa1BqMzhVSkh5NlBrVkxDYkk5bFlKMlVMcVZ4NHJ6bzBwanc3?=
 =?utf-8?B?bEZuYTVITXpTN2t1V25JTndLZ1hsbGhzenZnaEp0ZmtwdTNwdGN0S1doRWxy?=
 =?utf-8?B?RjFiNkU1V3ErcXM1UVcvQ0NCTi9IOWY0ZnBLalpKUW04U0JSbE53bnU1Ty9m?=
 =?utf-8?B?a3dybER2Y2l2WGNWQXh5OUt6bXlmbStvRng2SWlXWk1yUzRoSFQwcU13cFk0?=
 =?utf-8?B?M0J4NlI5QjQyNlUraTZHRzNvVXhWZ3o2dldZNjBNU1dHclowZm13VmdabHll?=
 =?utf-8?B?RUtoT2wzcVZ1YzNlazh5dXVzUEs5N0xJazJjQWRPZmFjWVFPcm5jYWhILzlP?=
 =?utf-8?Q?lP8UObw84usgYgSkSHkdZRa3g7vuyJyYGcL7upc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1lXenF3U2ZnNklVNEdCTk1lSUZZYmtJSndxR2taNTJFdmRWZHEwcHdJcDY4?=
 =?utf-8?B?cUU4dk5YSjd3K1NkaUZVYS9MM3JvR2Zxa3BCYlpCSTZLN3NHSHlRckJqM3I4?=
 =?utf-8?B?Q2E5Vjhnb2J3QkpyUUVBNWVMRkgxOHFEREdnRlZlRVNsRDh1NTI5am9mZHU3?=
 =?utf-8?B?V2EybDZLSDVHbk1rTmJVTjZEbFFXSStkYlBXYUpOaW5oalNLeDBCaE5hRit1?=
 =?utf-8?B?WHRHQXB1QUFaVWpRallhYWpuMEMvKzl1WnV2Rlo1WFludXVmRkhtc25rNU52?=
 =?utf-8?B?OGFsazQ1bGNUNWJxbURTSlRDc0lONnE0aFR6cmVvK1lQNktCUkYySUp6a0RC?=
 =?utf-8?B?YWEyTWhDemk3Z0lVWDlmNUxRRm5SYUoxVWdtN0EwYmZ6NDl1blVlWWZRakdL?=
 =?utf-8?B?ckg3ZVI4bnU1KzRGa2ZkUWh2STY2VitKQVRmVzl4NE56YzgwUXdLWk5Xb1d1?=
 =?utf-8?B?bHF2S1BlamsrR2RyQ2pBcThUVDdNaVZ0VGxLaEg2Q0FEekd5Zlh6T3dWR204?=
 =?utf-8?B?ZTBWUm5STzZtNjQ5NkJ0L0o0T3Jkam04WnhhY25YQVc0MFFJU2xGSGJKZ1Ny?=
 =?utf-8?B?d3hHSEViN3hVcUhUbkllU2prcUtINmpSelNJdXFqL05pMHkvcGJMMjdwampi?=
 =?utf-8?B?VVpqVnZrd3NJRHB5NTdwb3FpSXRNRFE3OEYvcktOUE1Damp2RGVsQnk1MDhV?=
 =?utf-8?B?VFpsRUQwQXZLZ09jYW9SS1BLM0pIbFIyRGlONmxlVlZXelNpNFBId0x1ZVJZ?=
 =?utf-8?B?SmJVMU4rVTRhcUZSeDd4bXFBdUJ3UnV5ejZrVk56QTlDVHhxSmg5bzJqZnVB?=
 =?utf-8?B?Q0NrV0FTeHIwVDhZelArZFN5ZWtPTVdzTEh2d0hLS3VpMGVYWGl0VGtlRFJC?=
 =?utf-8?B?d1lheUh1NklOV2EzblhwUk1VRFN2VDVQMm9QcEVETkt3b1JhTVpwcTdndjhy?=
 =?utf-8?B?MWxGdnNCRm9pbVMzTjB6VHlBQ0oxMjQ1cXI0SDRxQmlKWDB5SGttU2h1UHRq?=
 =?utf-8?B?c2dzYVBlamprQkgyUldkQ2s5eFk0QWhmTmZmbEVadEgxbzNydXRRTWdMcEE1?=
 =?utf-8?B?SFVhL1VKcTFVRkhWS29SUVRReGlsME5hNUlUcG1xV3drcEtOREtzL29XVlJB?=
 =?utf-8?B?M2hoMDFraWJzOGZwWmU3eGpOcTY4Y3FaM2R0NkE5M2Myb0xXZVFuZE1rVmN6?=
 =?utf-8?B?VFJ6RXJDaFZidEpnWXMwMktjNmZINU9qMk82Ung0Y3BOakNIUklHVWttdnd2?=
 =?utf-8?B?UUk4UGxpTXE4NEEwYVRwT3dybXNUbDUyWUVobVdOdGF3WGcwQmJ1cDMxUEto?=
 =?utf-8?B?U0IzYW96MVRLSC9PaDlrdDRwczEvNi9xTDZCMitnVis1eFpjMEtzWDRTU0Rn?=
 =?utf-8?B?ZjZrbTMzL01YV3ZtWkZCZndzMXluK01tVGZWUkx2RTBKcTdyY01GbXdoTzBt?=
 =?utf-8?B?RVpMN2wzZy9LTm1iMWY4L3F5U2JkWTloM3dJdUlqK1JucVplSENuZFFHYlVQ?=
 =?utf-8?B?b0llRkJ0V2FwTFF0dUpkRnNMazRWTkNwQkRFbjVLMS91dEFMTzZuNStZRmtr?=
 =?utf-8?B?VnRxVVduaFhwZXZNdWlGM1NnMU4vSXcwMm9RNjlKM0lZbTQwZFFRNUZXZEpy?=
 =?utf-8?B?aWpvOWVRVzcxVW9UKzZaaFRCT0xmY3BOR004ak1adytlaVE4dS8zYk45R2ha?=
 =?utf-8?B?WlV0RDBFTlJudFhaV1RPTU92WGtqeGdNNTVRb0Y0RVJINzJ3Z3dzYzNKZ25m?=
 =?utf-8?B?UElDSmgwU2V1dHNHTXJBMGtHM3FZRDRSbUJkTnFjOEJXaWZTMUVzL00yMlow?=
 =?utf-8?B?TnpGbUJFTmtGMytMSW9pV2FpNUJyMHBsbTFGZnJ5SEcrNkxqK0s2SEh0MHA1?=
 =?utf-8?B?SnFTdTJlVllCbGd6Rmg5eWt6TDVVdjk2YnNNbjRCZjBaeXo3T3FBdXJEbE1q?=
 =?utf-8?B?Qk5pS0U0RERROWpoSHFTbWw1Q1ZlWW53ZDlveGZpaHVFaWdMQTBRTEY4M293?=
 =?utf-8?B?Z1lMMWxXT1NTSlVVZDFXWmR6amZJcDhMbmtyZ05vTVhvdmNLMEd5M0Z2OEhN?=
 =?utf-8?B?bGlseUo1ZkNqank3R0g5NXVuM2Q0T0dOTDJOdUtIckpYRy8yd2xXVWxNZmlR?=
 =?utf-8?Q?I9xkowNDPM1i3SoU7LRGBezv4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 13551e4d-bd81-406d-19a6-08dc8544bb77
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 09:49:03.1385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FRbPgMmIIDZqs5lEcHMa3wpizhgESXlMjxc9bh7T7a/zvfj0WeOJfF25Mnh4w4uP3MkN0mPkDH6CBYgLqHU3knW+Uf+zce2OarUlY3HCOec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8393
X-OriginatorOrg: intel.com



On 04.06.2024 17:57, Mengyuan Lou wrote:
> Add sriov_configure for driver ops.
> Add ndo_vf_ops for txgbe netdev ops.
> Add mailbox handler wx_msg_task for txgbe.
> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 42 +++++++++++++++++++
>  drivers/net/ethernet/wangxun/libwx/wx_sriov.h |  1 +
>  drivers/net/ethernet/wangxun/libwx/wx_type.h  |  1 +
>  .../net/ethernet/wangxun/txgbe/txgbe_irq.c    | 25 +++++++++--
>  .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 23 ++++++++++
>  .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |  8 ++++
>  .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  4 +-
>  7 files changed, 100 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
> index 6d470cd0f317..375295578cff 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
> @@ -302,6 +302,15 @@ static void wx_clear_vmvir(struct wx *wx, u32 vf)
>  	wr32(wx, WX_TDM_VLAN_INS(vf), 0);
>  }
>  
> +static void wx_ping_vf(struct wx *wx, int vf)
> +{
> +	u32 ping = WX_PF_CONTROL_MSG;
> +
> +	if (wx->vfinfo[vf].clear_to_send)
> +		ping |= WX_VT_MSGTYPE_CTS;
> +	wx_write_mbx_pf(wx, &ping, 1, vf);
> +}
> +
>  static void wx_set_vf_rx_tx(struct wx *wx, int vf)
>  {
>  	u32 reg_cur_tx, reg_cur_rx, reg_req_tx, reg_req_rx;
> @@ -975,3 +984,36 @@ void wx_ping_all_vfs_with_link_status(struct wx *wx, bool link_up)
>  	}
>  }
>  EXPORT_SYMBOL(wx_ping_all_vfs_with_link_status);
> +
> +static void wx_set_vf_link_state(struct wx *wx, int vf, int state)
> +{
> +	wx->vfinfo[vf].link_state = state;
> +	switch (state) {
> +	case IFLA_VF_LINK_STATE_AUTO:
> +		if (netif_running(wx->netdev))
> +			wx->vfinfo[vf].link_enable = true;
> +		else
> +			wx->vfinfo[vf].link_enable = false;
> +		break;
> +	case IFLA_VF_LINK_STATE_ENABLE:
> +		wx->vfinfo[vf].link_enable = true;
> +		break;
> +	case IFLA_VF_LINK_STATE_DISABLE:
> +		wx->vfinfo[vf].link_enable = false;
> +		break;
> +	}
> +	/* restart the VF */
> +	wx->vfinfo[vf].clear_to_send = false;
> +	wx_ping_vf(wx, vf);
> +
> +	wx_set_vf_rx_tx(wx, vf);
> +}
> +
> +void wx_set_all_vfs(struct wx *wx)
> +{
> +	int i;
> +
> +	for (i = 0 ; i < wx->num_vfs; i++)
> +		wx_set_vf_link_state(wx, i, wx->vfinfo[i].link_state);
> +}
> +EXPORT_SYMBOL(wx_set_all_vfs);
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.h b/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
> index 7e45b3f71a7b..122d9c561ff5 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
> @@ -9,5 +9,6 @@ int wx_pci_sriov_configure(struct pci_dev *pdev, int num_vfs);
>  void wx_msg_task(struct wx *wx);
>  void wx_disable_vf_rx_tx(struct wx *wx);
>  void wx_ping_all_vfs_with_link_status(struct wx *wx, bool link_up);
> +void wx_set_all_vfs(struct wx *wx);
>  
>  #endif /* _WX_SRIOV_H_ */
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> index b8f0bf93a0fb..1a4830eab763 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> @@ -1053,6 +1053,7 @@ struct vf_data_storage {
>  	u16 vf_mc_hashes[WX_MAX_VF_MC_ENTRIES];
>  	u16 num_vf_mc_hashes;
>  	u16 vlan_count;
> +	int link_state;
>  };
>  
>  struct vf_macvlans {
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
> index b3e3605d1edb..e6be98865c2d 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
> @@ -7,6 +7,7 @@
>  #include "../libwx/wx_type.h"
>  #include "../libwx/wx_lib.h"
>  #include "../libwx/wx_hw.h"
> +#include "../libwx/wx_sriov.h"
>  #include "txgbe_type.h"
>  #include "txgbe_phy.h"
>  #include "txgbe_irq.h"
> @@ -176,6 +177,24 @@ static const struct irq_domain_ops txgbe_misc_irq_domain_ops = {
>  	.map = txgbe_misc_irq_domain_map,
>  };
>  
> +static irqreturn_t txgbe_irq_handler(int irq, void *data)
> +{
> +	struct txgbe *txgbe = data;
> +	struct wx *wx = txgbe->wx;
> +	u32 eicr;
> +
> +	eicr = wx_misc_isb(wx, WX_ISB_MISC) & TXGBE_PX_MISC_IEN_MASK;
> +	if (!eicr)
> +		return IRQ_NONE;
> +	txgbe->eicr = eicr;
> +	if (eicr & TXGBE_PX_MISC_IC_VF_MBOX) {
> +		wx_msg_task(txgbe->wx);
> +		wx_intr_enable(wx, TXGBE_INTR_MISC);
> +	}
> +
> +	return IRQ_WAKE_THREAD;
> +}
> +
>  static irqreturn_t txgbe_misc_irq_handle(int irq, void *data)
>  {
>  	struct txgbe *txgbe = data;
> @@ -184,7 +203,7 @@ static irqreturn_t txgbe_misc_irq_handle(int irq, void *data)
>  	unsigned int sub_irq;
>  	u32 eicr;
>  
> -	eicr = wx_misc_isb(wx, WX_ISB_MISC);
> +	eicr = txgbe->eicr;
>  	if (eicr & TXGBE_PX_MISC_GPIO) {
>  		sub_irq = irq_find_mapping(txgbe->misc.domain, TXGBE_IRQ_GPIO);
>  		handle_nested_irq(sub_irq);
> @@ -226,7 +245,7 @@ int txgbe_setup_misc_irq(struct txgbe *txgbe)
>  	struct wx *wx = txgbe->wx;
>  	int hwirq, err;
>  
> -	txgbe->misc.nirqs = 2;
> +	txgbe->misc.nirqs = TXGBE_IRQ_MAX;
>  	txgbe->misc.domain = irq_domain_add_simple(NULL, txgbe->misc.nirqs, 0,
>  						   &txgbe_misc_irq_domain_ops, txgbe);
>  	if (!txgbe->misc.domain)
> @@ -241,7 +260,7 @@ int txgbe_setup_misc_irq(struct txgbe *txgbe)
>  	else
>  		txgbe->misc.irq = wx->pdev->irq;
>  
> -	err = request_threaded_irq(txgbe->misc.irq, NULL,
> +	err = request_threaded_irq(txgbe->misc.irq, txgbe_irq_handler,
>  				   txgbe_misc_irq_handle,
>  				   IRQF_ONESHOT,
>  				   wx->netdev->name, txgbe);
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> index 8c7a74981b90..fbfd281f7e8b 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> @@ -14,6 +14,8 @@
>  #include "../libwx/wx_type.h"
>  #include "../libwx/wx_lib.h"
>  #include "../libwx/wx_hw.h"
> +#include "../libwx/wx_mbx.h"
> +#include "../libwx/wx_sriov.h"
>  #include "txgbe_type.h"
>  #include "txgbe_hw.h"
>  #include "txgbe_phy.h"
> @@ -99,6 +101,12 @@ static void txgbe_up_complete(struct wx *wx)
>  
>  	/* enable transmits */
>  	netif_tx_start_all_queues(netdev);
> +
> +	/* Set PF Reset Done bit so PF/VF Mail Ops can work */
> +	wr32m(wx, WX_CFG_PORT_CTL, WX_CFG_PORT_CTL_PFRSTD,
> +	      WX_CFG_PORT_CTL_PFRSTD);
> +	/* update setting rx tx for all active vfs */
> +	wx_set_all_vfs(wx);
>  }
>  
>  static void txgbe_reset(struct wx *wx)
> @@ -144,6 +152,16 @@ static void txgbe_disable_device(struct wx *wx)
>  		wx_err(wx, "%s: invalid bus lan id %d\n",
>  		       __func__, wx->bus.func);
>  
> +	if (wx->num_vfs) {
> +		/* Clear EITR Select mapping */
> +		wr32(wx, WX_PX_ITRSEL, 0);
> +		/* Mark all the VFs as inactive */
> +		for (i = 0 ; i < wx->num_vfs; i++)
> +			wx->vfinfo[i].clear_to_send = 0;
> +		/* update setting rx tx for all active vfs */
> +		wx_set_all_vfs(wx);
> +	}
> +
>  	if (!(((wx->subsystem_device_id & WX_NCSI_MASK) == WX_NCSI_SUP) ||
>  	      ((wx->subsystem_device_id & WX_WOL_MASK) == WX_WOL_SUP))) {
>  		/* disable mac transmiter */
> @@ -268,8 +286,11 @@ static int txgbe_sw_init(struct wx *wx)
>  	/* set default work limits */
>  	wx->tx_work_limit = TXGBE_DEFAULT_TX_WORK;
>  	wx->rx_work_limit = TXGBE_DEFAULT_RX_WORK;
> +	wx->mbx.size = WX_VXMAILBOX_SIZE;
>  
> +	wx->setup_tc = txgbe_setup_tc;
>  	wx->do_reset = txgbe_do_reset;
> +	set_bit(0, &wx->fwd_bitmask);
>  
>  	return 0;
>  }
> @@ -725,6 +746,7 @@ static void txgbe_remove(struct pci_dev *pdev)
>  	struct net_device *netdev;
>  
>  	netdev = wx->netdev;
> +	wx_disable_sriov(wx);
>  	unregister_netdev(netdev);
>  
>  	txgbe_remove_phy(txgbe);
> @@ -746,6 +768,7 @@ static struct pci_driver txgbe_driver = {
>  	.probe    = txgbe_probe,
>  	.remove   = txgbe_remove,
>  	.shutdown = txgbe_shutdown,
> +	.sriov_configure = wx_pci_sriov_configure,
>  };
>  
>  module_pci_driver(txgbe_driver);
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> index 5f502265f0a6..76635d4366e4 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> @@ -16,6 +16,7 @@
>  #include "../libwx/wx_type.h"
>  #include "../libwx/wx_lib.h"
>  #include "../libwx/wx_hw.h"
> +#include "../libwx/wx_sriov.h"
>  #include "txgbe_type.h"
>  #include "txgbe_phy.h"
>  #include "txgbe_hw.h"
> @@ -179,6 +180,9 @@ static void txgbe_mac_link_down(struct phylink_config *config,
>  	struct wx *wx = phylink_to_wx(config);
>  
>  	wr32m(wx, WX_MAC_TX_CFG, WX_MAC_TX_CFG_TE, 0);
> +	wx->speed = 0;
> +	/* ping all the active vfs to let them know we are going down */
> +	wx_ping_all_vfs_with_link_status(wx, false);
>  }
>  
>  static void txgbe_mac_link_up(struct phylink_config *config,
> @@ -215,6 +219,10 @@ static void txgbe_mac_link_up(struct phylink_config *config,
>  	wr32(wx, WX_MAC_PKT_FLT, WX_MAC_PKT_FLT_PR);
>  	wdg = rd32(wx, WX_MAC_WDG_TIMEOUT);
>  	wr32(wx, WX_MAC_WDG_TIMEOUT, wdg);
> +
> +	wx->speed = speed;
> +	/* ping all the active vfs to let them know we are going up */
> +	wx_ping_all_vfs_with_link_status(wx, true);
>  }
>  
>  static int txgbe_mac_prepare(struct phylink_config *config, unsigned int mode,
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
> index f434a7865cb7..e84d10adf4c1 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
> @@ -71,12 +71,13 @@
>  #define TXGBE_PX_MISC_ETH_LK                    BIT(18)
>  #define TXGBE_PX_MISC_ETH_AN                    BIT(19)
>  #define TXGBE_PX_MISC_INT_ERR                   BIT(20)
> +#define TXGBE_PX_MISC_IC_VF_MBOX                BIT(23)
>  #define TXGBE_PX_MISC_GPIO                      BIT(26)
>  #define TXGBE_PX_MISC_IEN_MASK                            \
>  	(TXGBE_PX_MISC_ETH_LKDN | TXGBE_PX_MISC_DEV_RST | \
>  	 TXGBE_PX_MISC_ETH_EVENT | TXGBE_PX_MISC_ETH_LK | \
>  	 TXGBE_PX_MISC_ETH_AN | TXGBE_PX_MISC_INT_ERR |   \
> -	 TXGBE_PX_MISC_GPIO)
> +	 TXGBE_PX_MISC_IC_VF_MBOX | TXGBE_PX_MISC_GPIO)
>  
>  /* Port cfg registers */
>  #define TXGBE_CFG_PORT_ST                       0x14404
> @@ -196,6 +197,7 @@ struct txgbe {
>  	struct gpio_chip *gpio;
>  	unsigned int gpio_irq;
>  	unsigned int link_irq;
> +	u32 eicr;
>  };
>  
>  #endif /* _TXGBE_TYPE_H_ */

