Return-Path: <netdev+bounces-240889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018AAC7BC4C
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 22:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB4183A2886
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 21:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C782258CE2;
	Fri, 21 Nov 2025 21:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZAhLr72U"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65FB1EEA49
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 21:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763761094; cv=fail; b=R6CRA9XIFyulOzfah4OnhmKDsd+bcL0ObnL+SgcNqejLy6ov8/cW7tBIZdT2+Y646icgtEHDgWrab7g6haR7iITJdhuaGVsNQ0hzzmUJQXiIlxxpX97+d2P5y4JguNqR/dADyyg1Xj4aMxAsqmuOtj8IfeR9yTnNBRay2HMe/Kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763761094; c=relaxed/simple;
	bh=lLUdKt8EithfZjd72gz9dMFtJASw2VhLEI6zKq4kRHE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NAYGYksRq20G5wFgysm/v8gIA+ZiPGemtUI75/VNqSxo/OQJFX47n8HtsKEWlb4V0a/qiu7Higj001bjQpYl7vxpmwK7v4ITWCMOH7PZ5JInZFucftDT5rX+l3wSRVYypRlaA/p3voqEWqWIo+bwejUfx7sMrX7L16SgYUcdbLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZAhLr72U; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763761093; x=1795297093;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lLUdKt8EithfZjd72gz9dMFtJASw2VhLEI6zKq4kRHE=;
  b=ZAhLr72UX/ljrtmcBvTb+tGMBTFgoR3UvzLdaqOIaFjLXW1k1acfk89u
   zvk+Z9bwAWyhcgUyKoSWlNvgh9Q2FKHjIQBG2Lpz34AVBzFtfyLyZcWgJ
   HTGmVOOddRgj42Pm4C4Qotw71DE/ul1mMLhMHVHDXF5gskK9iAY0kwS5Z
   rqidEviM0nkfXZ1+xFn6JFnF7qGIrueuCv/6xjGqMzMmhWMVEk/JMO/Xd
   2wmJgPS2SNKLfo1C2B4sD6rQjNaIpWSnr8Ei+7tZIsRMH/10kGZ8ENpxM
   WNmIwELCZpcrSlwZiU/pIs8ygvekeEyXSAA0TqUUguuWJaaEapYFCLST3
   A==;
X-CSE-ConnectionGUID: OK73F0coTdKMzorMwjGHVg==
X-CSE-MsgGUID: Q34AWALhQqq2fbawy4ENRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11620"; a="65798892"
X-IronPort-AV: E=Sophos;i="6.20,216,1758610800"; 
   d="scan'208";a="65798892"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 13:38:13 -0800
X-CSE-ConnectionGUID: Gop5G0QKQeeI0TV3KhU/uw==
X-CSE-MsgGUID: M1q8gICzRgaFxMwda3ZDhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,216,1758610800"; 
   d="scan'208";a="222744823"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 13:38:12 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 21 Nov 2025 13:38:11 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 21 Nov 2025 13:38:11 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.40) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 21 Nov 2025 13:38:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHS1Zuue3cThTQC2Y79vZpQL78KXVILwkURE8xeIvp120BfUeEb/PaEeXiaIHTOibo2qXsWD3ez9ULxsZem1nDgaXbi4vVeDR3UQJmo9/s3atk5zMBrcmGtLhARyquL3v7lrI24J+hWexYjBUN+48F+s4Zus6C1nrXL3bKFyu3ar2029lqLr4vmjdvxc0IgTXePJ4jTNrfrpThZH/vZwov9YZsyji5LMpbJUFjTUX9AKjn3pWszV3qHRobMtZu3wXz10Ciu9jjVi1xKzPu/X4K2hleRA+lfBTgcfeguZ/m65DIEU66O7HJ2xK04gb54BGnmWzvn25w284y7EBdEQDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9BJdIW4Df8vaOxpxrlT82q6tUpH3OCqX1+X5OafzBA=;
 b=JerT6AEcO/KkshfCp0NGr7Lvp7d6EpuObCzsEhs97f0GclS7v+HrZTK5wjjhGIBzvDgvlkmv/LEE6/4CfpHhxOqmMNROCk/OaghsyAMPS5Ovktpd7EUpw8tlm78yRNe5sITdG4KDoJQLVfaGwF/wS1K9DnrUKZYaim1uq4hJ3Yek2keSLDVHdSW4ot+3Gt3dr17Yqdz9AYtGmApnRtCtTMZDBkYZlg5lA6gZpZG7UbbaeIqrmk2dCAdjK9RnoEYuC/GIbeJKv6HcCv7JRj/OFqzfyblsDWwNK0CtzIAg/yrB/9sK/0QLjYb1JCFBBXw94d3TtMOFUrebBT+fS9joHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by CY5PR11MB6186.namprd11.prod.outlook.com (2603:10b6:930:26::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 21:38:08 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21%6]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 21:38:08 +0000
Message-ID: <84d7bbbd-5902-4b9d-9bc2-eb1704b81d57@intel.com>
Date: Fri, 21 Nov 2025 13:38:04 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-firmware] ice: update DDP LAG package to 1.3.2.0
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>
References: <20251118121709.122512-1-marcin.szycik@linux.intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20251118121709.122512-1-marcin.szycik@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0285.namprd04.prod.outlook.com
 (2603:10b6:303:89::20) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|CY5PR11MB6186:EE_
X-MS-Office365-Filtering-Correlation-Id: bdd0f167-6802-45fc-16a4-08de29464307
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MVljN05tVFl3UzFKaTVXcUwrQlB4MFBwMU5QcDRucUFwcVBtQlFoSGF1WkI4?=
 =?utf-8?B?UktVL1h0NFQzdmxpMkhmZWNHZWxlQkk3Y09qT1IxSlNpZHNLNW96V0ovOGl4?=
 =?utf-8?B?ZHBGQXdVekxEak1jdmR6N01BNE5jWVJUNUR0OWVGZWV2c2pLdDdZR0FnZCtM?=
 =?utf-8?B?SzJTWkF1dWlHdWZBUDJBd3FISUxXejJaaFI2bmJjQkU2L3Q0cEc3N0MxV3FR?=
 =?utf-8?B?OFRJb2gxU1VVWlZacUQxNmJvelU3bkVnOXdObHdLTEtweVpaQncrNUhGT2xm?=
 =?utf-8?B?Z0YzMmxrVUY1UTdRbHdTeHRxUFdZanhUaThDUmpLL2QvMWRJY052dmJBMG9s?=
 =?utf-8?B?Q0IySTh3OFRrS3YxSzFhUHptdHcxMDU1aTRNOWZFQzh2TEk2MnZ3Y2k0aGtW?=
 =?utf-8?B?UXd2clIxMWd3MEZqTHdxS0pMM1MyRDlSdnpIUTM5UWZMZk1nZ2NKVmZNcXUz?=
 =?utf-8?B?YVFFVTFVMWZEa0IrR3VmU3lKZXJVQ0NoUnJqaG9XSVY1WTNDUUM2UDdFT3Bj?=
 =?utf-8?B?NEFsOE5yVGQ3N0JxMU1pUU1aSGJEUVhvVjQrd2hjQ1MzeXkyZWtadkZQdkp3?=
 =?utf-8?B?NjJkR3RRYnZGODFnOHBZMnFpUnRuSmkwUDI1V3dXTmFFemlOb1BodkljTE90?=
 =?utf-8?B?b1dueGlQcnROMStkV29udGpBMWQ1TFBEYmRqOTV0VUU2a1Foc0N6VnlOTzVG?=
 =?utf-8?B?R0ppRitjSktkMVZzRDJDTjZkS2pxYVNWTVcwVytWSTJrdDZOcU4xaEVPMFZ6?=
 =?utf-8?B?bmhpQ2QzSUQ2RGFQTlhjYUdHTG1NajRDcDZtWW9URHNZTXBYaExySmdnTmM4?=
 =?utf-8?B?Y0V6ZThzZjlTSW1hTUFqTHA2Y25xVTR6Nng2N1RwTmhBVkorQzJteEhwTEJL?=
 =?utf-8?B?aWpCd0lqNGlJN3VJTlhEenM2cCtGMHJTMVJpNmVEYTN1N0VRUGV3QkV1TnQw?=
 =?utf-8?B?NS9oY3puNi9qZ2gvSjcvZWZJUXZneC90RC9ZSndWVTF5TUtpeHZ2MGdoOFRC?=
 =?utf-8?B?SnhiMzhZZXJGWUpSSXZESmRiM3RMSUN0NENnSjc0dTdCdDZVZGgwUmtLVC9U?=
 =?utf-8?B?YldmZ1FvVU96UG5xK0h1ckpVYkVLR2QveUNDRzk1bk84QjdPQUt6SlpidUFn?=
 =?utf-8?B?RXA0SW5OdThwcW9qUTlvQjIxR1IxRE45cldOc3R6bGxJTXBBeU53VjBkd0hN?=
 =?utf-8?B?NTlOejlvRlZBU2I3WWJ4OFUzOGQrMWNTb2FyNVRTUkxkaXlXMGEzN2hYMVMv?=
 =?utf-8?B?eS81UW5DNkpVTU9tS2EvdWc4RjkxSTdzUi9KYkVLa2JQRFNNMDhFOTAwMEtJ?=
 =?utf-8?B?SUxSUVVvREl3WlhNVUJrbGRVbWw4ZlVqdi9LZDBFaG8vYXZjZXIybi9QeUwr?=
 =?utf-8?B?MU45NGI1a3Q3RDJNZVZvcEhIRVNsZERnRzl3dVdEMkkyc3JQUDBmUmt3RVBL?=
 =?utf-8?B?NWpNakZsMG5nOS9rRGRRTE9NVkt3MThFUXV5dDR1WXRqWlRBY1VaWVJxT2Er?=
 =?utf-8?B?V25rWHpITXoyY1pBWDc3YWM0SXpkMm82aytLS0RKSmttUTFmekVXMllMTWhm?=
 =?utf-8?B?QlhKN2J3QUZVbXo3ZkZxOUxYTFlFaDErRGovSW5uNG5MdlRvaDJhNUhreFlK?=
 =?utf-8?B?bnVwRzBLWUN6djRnQjY5bDJpMlF2a1pTZkQvdWxya04vSGdYUjRWM2NOSW9Q?=
 =?utf-8?B?U0pzTjVVUWlHdldhbHF1MTRqajVuNDhJVk9INUIyT043cnZ4TDBoTmlvRGxY?=
 =?utf-8?B?VG8wQTloL2ZkRnhNS0k2eENZYXl0RTdFZmY1V2srR0V6bnQ3QURibjVjL3M3?=
 =?utf-8?B?RHFXY1BWN1Qwakc5Um45UFhBMm0xWGowYWZuUG5sSWdKZVdUS3h5dG9JMTJh?=
 =?utf-8?B?VHdhclRwWmIxQlRLbHRGZ0JubEZ5SzEwcGk3c0paaWFQaERhekZ1K3lMSjlC?=
 =?utf-8?Q?p4ySa8mPph56juTgmR4EDZYkL2pkLYXz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHY4Y08zU3NYeW8vaFRuSXJQODJmV1dmWENBc0kxNmwybE1nUHRtb3p5MEFL?=
 =?utf-8?B?Wm5SNXVXUXVsNTZZUzN5ZHVSQTd4MHFxcURPcldTTXZ3YkUyTzV3Zm1Sc1pn?=
 =?utf-8?B?MDNVREhjQlpmZGdOK1A0TzAyR2VLekZqQmJpQkpsU1BFYWpveUthSDhTWmVm?=
 =?utf-8?B?czk1WXdRVEphS0g5NUlBYjRHdFR0TCtha2VPdld0SGoxNllicEpRRVlFdXlF?=
 =?utf-8?B?SlFRVG5yN3A3UW9xNHVZS1ByUktZZloxTVlkeW1OeE8zRjVXK2JDOExMVlc5?=
 =?utf-8?B?M0lVQmdDUUFQQ0puejU5YW4zZ0lDY21nYVZWK1VTQUdvUlZqQXBJOUNBN3Jk?=
 =?utf-8?B?MGJXS2p2Y3JadTQ2cVhhRjJUaVhsK0VqNlZNSTFBeWlubGpnbWg1YkNlOG1W?=
 =?utf-8?B?Y0lnN1JhN2YyTHBkaG8vOFNKVlJJL3lidVZhY1dvTjJPWEtsNnNIMzJ3VFlM?=
 =?utf-8?B?WWpOUUx1a0JmUDVYWXNpaUkxdjkybVlBTFRud2xBa3Mrdk8wZVd6UUdENFA1?=
 =?utf-8?B?YmF2ektRbXY5SjVKWlpGT2tIZDJqSU0vMEs3Q0RIbFNLZzJJaERLMlU5RVBW?=
 =?utf-8?B?K0NhQVV3S1ZLdU9PVi85ZzZSMmhZOExUeXhBUEppL0hydHFJL2c3citocHM0?=
 =?utf-8?B?SnFpVUdYdFBsdyt4WVh4RWEwcTE2TFo2SEFJQitBdE5PcHRKTUFmLzFud3Jm?=
 =?utf-8?B?R3BhVkNFMS80Uk03d1gvdWwrazBEQ09qZ1JuZXdkQ1U3ZlJKQml3TmViaDJR?=
 =?utf-8?B?dTNuZGpIOEtFZ2VoWWh6M1VuYytSMGpiZVMzdVFEQ0ZDSjlvODlwbUVjTE1F?=
 =?utf-8?B?VzY0Z0FQaENNTHRHUVdqc0pkdWhWZUYrMjQ5ODRpOHpNZFp1UmNwandDeHNl?=
 =?utf-8?B?bURLblhXR0VNRmxIZkUyTU1TTG81WDB0emIrWG9rZ2tkNDFCcEJYVUtTcTEr?=
 =?utf-8?B?YlpBSlpEMnJkSFhHOXUwWVlMUkRvc0d5a1QxZDVVekFJR1huYTEwNE14ZDhx?=
 =?utf-8?B?a2VQWWhGUkVMZ0VydUxhRCs5WTMrN2VWWnpDWjZuQmw3bGM0VllNcDNFQ1Zj?=
 =?utf-8?B?YUh5TXJhNm9Ka2lPWTNFUDRONzd3OUZUMGpkMUZwQWlNYTlqN1R3cEtpYUgw?=
 =?utf-8?B?VUV4bnVJMEppNzdMcWppamcrMldGQVNKMkdlT1YyRHFYK0NmejRaclU1MUph?=
 =?utf-8?B?YjFJVnVlNnBCNnJUSERJN25hWkZ4UFA2aUFDOGhsL1lXMmd1cmlqTEdoRXRN?=
 =?utf-8?B?bHVoSG5XYXgwWUlURG51T1c5TWtuSnhvWjdrUGVqUjBCbVF2SFZ0MDNDdS9G?=
 =?utf-8?B?ZXI2eHNFck9tQW8wczdkQmZCY3g0UGJSMXlSYzBlelhPUENROXg3UTVZd1Zn?=
 =?utf-8?B?U1N1RHh3TGMwYnpNWm9waXJBcFhUOVpYOWhpd2JvVUQvOVVKNkkrUVRlSTZ2?=
 =?utf-8?B?MHN3REF3czRLb2E4V25lMjQ4bDRPeXpkNkdLN1pwVVN6Mzh3WVIzc1pOK0t4?=
 =?utf-8?B?aDVzdzBtblBuSDdiN1QzTC9VWGREUm5ZT1RVNDVDRE9ab0lNU2hCOXc2b3NU?=
 =?utf-8?B?cURyRmlMaWJlaTlkd2hsOGkycjJJUm9EZW5zV3VjZ05TcFRWQWs4a3lMV0V4?=
 =?utf-8?B?emZ5THFxUFpHNVg1ZUxoRnpkVFZ3N1JYRnNtaURUMmVjTDR6N2UwNHRpLzBn?=
 =?utf-8?B?Tk5VY0V3WmlCbktJUFBZYW9Xc2tBd2tRUnV6TUNOeGt5bmNmNSszeWhpQWFt?=
 =?utf-8?B?N3FrdEFvbEJuNUw2eGpxUzhzcHZVYk4yWHNuM2hQV0t0MkNKbGQ2Nk1MN2RI?=
 =?utf-8?B?c1dndUF5Wm5zSUNyK0hML3REOTZOc2tieHNjb1J1R1pCZnpPblcvUTV6TTdC?=
 =?utf-8?B?T1BWNWE5MEc3UjR5MEY0eDhpOEQ1ZThhNVFmU1VlTVpmbjREYmJuVEozb0Zk?=
 =?utf-8?B?akt5c0hCaEhXQkZXWnEyRFRDc21tMFljUUhPWG9GTnFSRTFNdHh0OWEvd2tl?=
 =?utf-8?B?ZXFsZ0VEZjJ6amx5V0tqcFowdkVJcVgvVjZzSjlTQWY1Ymo0bDlQb3NIeUpu?=
 =?utf-8?B?cmhWRGpyWm9xcVhCbWFCN3NtTGVGL3I5Nkc3aUwwNjRXWDhBbFZycE9MbkZF?=
 =?utf-8?B?NHQwcUVDZmk2cUxJVzZYYi9NalJ5Y003em9iS2FZQW5YcG93eHhlWGthNldX?=
 =?utf-8?B?R2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd0f167-6802-45fc-16a4-08de29464307
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 21:38:08.4991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KAn9/W9yoC4fq18K2FZkoHo3OmkgSbd4Mf1eSmjnZClJ4GlpbX13Io98SXbh6RafANKnY0fGPdHzbr92D7CaKPKJncMEFqtlnwQhK+8Bxl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6186
X-OriginatorOrg: intel.com



On 11/18/2025 4:17 AM, Marcin Szycik wrote:
> Highlights of changes since 1.3.1.0:
> 
> - Add support for Intel E830 series SR-IOV Link Aggregation (LAG) in
>    active-active mode. This uses a dual-segment package with one segment
>    for E810 and one for E830, which increases package size.
> 
> Testing hints:
> - Install ice_lag package
> - Load ice driver
> - devlink dev eswitch set $PF1_PCI mode switchdev
> - ip link add $BR type bridge
> - echo 1 > /sys/class/net/$PF1/device/sriov_numvfs
> - ip link add $BOND type bond miimon 100 mode 802.3ad
> - ip link set $PF1 down
> - ip link set $PF1 master $BOND
> - ip link set $PF2 down
> - ip link set $PF2 master $BOND
> - ip link set $BOND master $BR
> - ip link set $VF1_PR master $BR
> - Configure link partner in 802.3ad bond mode
> - Verify both links in bond are transmitting/receiving VF traffic
> - Verify bond still works after pulling one of the cables
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
>   ...ce_lag-1.3.1.0.pkg => ice_lag-1.3.2.0.pkg} | Bin 692776 -> 1360772 bytes
>   1 file changed, 0 insertions(+), 0 deletions(-)
>   rename intel/ice/ddp-lag/{ice_lag-1.3.1.0.pkg => ice_lag-1.3.2.0.pkg} (49%)

The WHENCE file needs to be updated to reflect the new version.

> 
> diff --git a/intel/ice/ddp-lag/ice_lag-1.3.1.0.pkg b/intel/ice/ddp-lag/ice_lag-1.3.2.0.pkg
> similarity index 49%
> rename from intel/ice/ddp-lag/ice_lag-1.3.1.0.pkg
> rename to intel/ice/ddp-lag/ice_lag-1.3.2.0.pkg



