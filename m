Return-Path: <netdev+bounces-198487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9427FADC59A
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 11:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 838BA1893138
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 09:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA3D289E33;
	Tue, 17 Jun 2025 09:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c7hnMU6C"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B6628B51E
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750150893; cv=fail; b=FB6BLIJ0XCmszhZ+P9/fIxXnyyhtSXqMp1sbuZFC3P7SqdMQuz0xRgi49hOhzEHv5hqtpkL7XWe6QDXajsL2nPQYc+Cqdf6hlxuJ+vYqymMPzEblcf3+QU7pkmXuv5Io53p1/z47SUWQ9vm4EU8wXlmRyhYF+SpkLcu+xfil050=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750150893; c=relaxed/simple;
	bh=6gViJl/47PH76nrzUphpE13+fw1tbC36osfOXWtnsY8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mqp8HZ9PFlbl9uaamWZTVZHwHN5dO1qhJ+gt1Jr2rM6PNdbRMoan6c7ja4TB+RxWPl4c2ctbzqX0oQQHn4LnyJpSG5ei5s/vjYcPqmCY/+g/ZPFdbgTK8XDBYYt+3l5SCzgdUg03gvfoMJ/IL5cFA4wXiuQJMJsf2gfwB3pdDEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c7hnMU6C; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750150892; x=1781686892;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6gViJl/47PH76nrzUphpE13+fw1tbC36osfOXWtnsY8=;
  b=c7hnMU6CdC52x2OwaZ8XFm8dR1k69h/+nrQqbprfVLcXa+nvJBEidC7H
   KXf+4ChdUqyUQCEJl0tCEWRtQt6fqO7yFizYtE5mJgXqc5xebZhTCt3cE
   U/Z8W4i1CQXuo2/aBOerkpODx4JC5i1z1jTkjfbYgcn77YC+BsioZ/1Ui
   XU3qxrv+e+ckfvdmzIM3TvTflf8Pt4UtA6gkmdtfaj8fGU0+qHozcnXgT
   VMiVEJUOC9fAy+rpUT4deVI24D6yEECJKLbh/4EVVqdTrG1v+nl1DDqSQ
   pCdHVRdjq8ypUEJvG7j3tVT2zpRTYAZpc21NibrzbCf//lYW2gq8yqiIW
   A==;
X-CSE-ConnectionGUID: WzO0N7hgTeOAeOS5SjTHMw==
X-CSE-MsgGUID: lcJflEh8RaaUTx7KOZqj/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="54931374"
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; 
   d="scan'208";a="54931374"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 02:01:31 -0700
X-CSE-ConnectionGUID: pfAPE6mSTT2FYCp830QIog==
X-CSE-MsgGUID: bZmMqGbFReqRkuldFiPxbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; 
   d="scan'208";a="148572716"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 02:01:32 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 02:01:30 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 17 Jun 2025 02:01:30 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.69)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 02:01:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQgF7DtPnsq+gLJ1DM0zF31uX7NXxThjKB3efiBWVulq5QRw4os3iGmDwyYbPqOTRzZVHCqcpK+W59P2An3U+f3UYDTtGrTN28hu44hfOdBqMdsGBzQT+cv5YmNhprRKE/famWSwcWs4ntTXiykkQJ/awUHkWOyb26VNlTpj58Ql+io7hjz8Ups1hPDIRx7qcwuYEzyrs6JM2KabISf4pwB++aQtcZYmb7flsHcARGIIAF/c0HyTjkM0/5Cr3fAFpOf/S+rXyKc/kRVTehRIl+D0hI2VKNBMFFyIecm/2vUdVRc1WDbq6Bwv3HPbZ8DsdLGlHkHiDxplPac37rIREA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kUuRHJAn7d6yeSb+x7EXs99a91FLHCP3eo6hB+sqnc=;
 b=PHf+F9yP1t25d6iWui0Yn9oVEzsgl4NKBEOOpWHNuqz5VBMNasvkRYGeq9XTl7joxTcaDCN7X3tdnWB5t0eA4ceFZz+mFAXjChv9eBiiXICi/3yTMFysd/oUh11fZXol403KlltQ8J00A+gYcX7mG8doIFQWC3XOe80SP2nFGksmL4M+fpp8BiLhkza/duzsIt3T7I9vUgtFV7BAAoRr2zBEifb2qjucRl6wBiC9ET7GbwUH1nFDaiaT2EDY9Wv+Nqt9kaq8HFLTghxQeNbiWy6/UDJYMJfh1XlEIbtWRtcI6EK+FH6ZOA0ASf/S4ixnWbQkK2nLZZBy3ogYAb4DZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.29; Tue, 17 Jun 2025 09:01:25 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%5]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 09:01:24 +0000
Message-ID: <59faaf3b-d75d-4405-a7bb-a137918617e3@intel.com>
Date: Tue, 17 Jun 2025 11:01:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] ixgbe broken after devlink support patch
To: "Kaplan, David" <David.Kaplan@amd.com>, "jedrzej.jagielski@intel.com"
	<jedrzej.jagielski@intel.com>
CC: "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "horms@kernel.org"
	<horms@kernel.org>, Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Bharath R <bharath.r@intel.com>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
References: <LV3PR12MB92658474624CCF60220157199470A@LV3PR12MB9265.namprd12.prod.outlook.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <LV3PR12MB92658474624CCF60220157199470A@LV3PR12MB9265.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2P251CA0019.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::26) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DS7PR11MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: 3823d78d-617b-46f3-bbcb-08ddad7d8993
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?STM0ZGtON1NSSDNIL2FOb3krOXBTNlhRUlpkVm1Uc296dDlCMUYvRHJHd0dy?=
 =?utf-8?B?b09DaWRyWElYbGkxdkl6QnJ5Q25jQ2Rhd0RRb1RheEM5amJlMGtnVXBtMklO?=
 =?utf-8?B?Qmpadjc5Y29BWHpWY3pPczVoSkQ1TmZyblhMZ3JHa2FLeUR1MStabE1aaCts?=
 =?utf-8?B?ZS91R2dTa28raXRndmNvWElyb3QxUysya1p2dlRkL0VoVkhxRE43UzkzdVN6?=
 =?utf-8?B?Q1JadEJOSFV2K21XdGlDVmNuWXRnYXRwaUk3dTdZZEVOK3dXL0RBQ2VMREpV?=
 =?utf-8?B?em1WcjU2NytlUFhtQjBzbmppNC9iWUYwTjlzK2ErTWQrNzlTSElFQzhpdUR3?=
 =?utf-8?B?bktidFUwTFEyZDFubWhmOC8ydVk5RGdMNXB5K2dMZGxuOFNTNTJKSTh1NVc0?=
 =?utf-8?B?cTNoV05HN3dXRDJndXBpVnNuVytmQ0ZabHlBNUQ5RjNFY2tXSWhjcXZGZ3Nw?=
 =?utf-8?B?c2haQU42UmZjNndXZ0gzS3RJaWVJbUw4bW4wMWJPZUNTU2kvMmVjNzdCeWpq?=
 =?utf-8?B?S09JOU5CcnpjdUhaR29SVkRtM01iY1poblZ0am9KSllrbWdDRUFPdnNqc1Yz?=
 =?utf-8?B?WVBoQWdHN0lTcnVaRUthbk5lMlBQTkY4ZWJEZnZ5TytwU3RYNUxYU1BhY2Ni?=
 =?utf-8?B?OHlyMTExMFY5a1BHZ3psQzR0cjVLOVMxSzlXaTFjQWg0QUlRNEdFbnVQdExN?=
 =?utf-8?B?aVQxWGhPRzEzbHpPcnFLc2pDYjFGblRZYXVyRnp2TVhmWU5Md0ZEUVdpeDdF?=
 =?utf-8?B?Ync0dkFOeHNTSG1KblU4ZHBJb0U5d3BkZzlZTjQ2YlBCY3BRWHpxSXhHZnll?=
 =?utf-8?B?dGJEbk52MUFpQWdmQUlrdGdYZWFuWXVDc0c5MXB5VllYL3RDRFNOc1gwbExt?=
 =?utf-8?B?TUMrVCtNelBJcnVlRG1TQURTRzQxKzYwUTQzSVN5NkxsVVpoaUE2b2ZEWG53?=
 =?utf-8?B?U0N2Y001YlJKS2ZkY3BrcUJpbCtxekg2QUhqU3NFZUdsbzExbFJaTFdDVzZh?=
 =?utf-8?B?QmNGdWVlNGpkSWRTQVpCV3AzaGpvQ2RYd0dScTFhRDhud0lnQ1VUbVRseDJ3?=
 =?utf-8?B?ZVg4WWMvbWl0MVdIU091Mk5FeENCdDFZZUFLZ1RkZUcybVI2VEdRTUFua0NJ?=
 =?utf-8?B?WGYrVVdIazEyM2hZRFRuVzQvRnpwK1RENm1jVHFXTE5idWo3L215TWgrQVI1?=
 =?utf-8?B?K2l5UFJwTGI0d0tKOEs1YXZ4d3RKSkJaNlo5Q1FXUEFCRjBMUFhTQ0hTUlRx?=
 =?utf-8?B?bW5rWjRCMEZwcGxOa3JRdGRmemhQYmZJUGQ1YlhPeTVYWkQra1p6d29qdHVv?=
 =?utf-8?B?eFFZaTFQUlJBVndDSTQ3RjJOM2VWS0pYT01UdTh0YWU4Wlo4WHFxS3k3bk9j?=
 =?utf-8?B?VmJiSGQvRWUybHovaFEyV0VjSllQQm9qZVlCak9aMHJ1NnRhbnJaaVR6dGRV?=
 =?utf-8?B?RWFwT1ZEY0diNWlDVWYyR2Jyek5nRXQvMGN0NytDa2xscCtLdUFmdXQyUXJH?=
 =?utf-8?B?WlNFK3dMaUZuaS9QUE92bXFhUGhnNlNYdkJocjhyTU03RG02cEhyMkZkRjBy?=
 =?utf-8?B?bGtNYmU3SlNLekZ1TzBUUExOL2M3VWJJWURZclB4VFQ3QjlVM2JIZ2xkRXdV?=
 =?utf-8?B?V054VXk3OUhJdTVwRTRrN3lNZzJpb0ZoMVdsUGZwSURPSGtvL215d3J2UzVa?=
 =?utf-8?B?bDdPZjF0bkxpdUxzMnlIa3UyMXdCa0gyTG44K1I4OVlLLzhFZm5sbmF5WENl?=
 =?utf-8?B?S1pNQ3B3MzlUa0FNaWFFeEpSTmNUWXpmL2tsRUhxLzA1ZG04dng4anltM3BB?=
 =?utf-8?Q?hVKbiS7Wmiu7XcMAgKina6ryQ3r0VyaHbfZdE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEJTUllqcGZQQm9EM3NGM1NLdCt6VldUNmVRSUNXTXVBWmkzRE4zUmVXQ1lS?=
 =?utf-8?B?aXBPcjZpelhnV0xlM3BvQ2Nob1hqS3hlM1BnK2lFOFBpV0U4Q09uMTYxL2tC?=
 =?utf-8?B?ZklRME1kNGhWS3VqMHpLMW9rZStNelZpc1kvZkVjRURUTTAyMG5DQnZoRm9o?=
 =?utf-8?B?by8yY2pHZHlTeVhSUHN4dE5JcUtSeWhmdkJpT3lXcGEwZHpLbDZORFUrMGh5?=
 =?utf-8?B?WE92aGlhVTFnbVoxbVAxSi8yMHJ4M2lxRWRTMmtGa2RpRjF2U2tWbnZ4Wnlk?=
 =?utf-8?B?U3pUOVN0STJyN3Y3SnI4VzEyRTFTVnMwb05wVndlMmkxaTJOY01PZit1NUsr?=
 =?utf-8?B?V0pocUt1NjJxY3k2aVY5bEdGeHlodU5maFVkUExtOFBRN3BPZW91ekMrNnJW?=
 =?utf-8?B?LzdGSlcydWpxeldjYmN6cnFGZXR0M1pwMjJTNUJRUHp0emM1b1ZEakJvTlpK?=
 =?utf-8?B?bXBjUXJuSGR6TmJPZTZvU3gyRU5GV1BmQ1NKSWM5cERxOE5oK0pSLzVtR085?=
 =?utf-8?B?ZmxRQUlVRFNnQmw5SGxYTXNEejNpWCtoYmhacXlxeWU5V2RqdDR4VU1KV1RR?=
 =?utf-8?B?SGxYUzkvZFdVUFNyWjJraEZ3b0grZHJ6blJTKzMvdXIyTTlGRlNmc2JQWGFl?=
 =?utf-8?B?Vk5FbDJiSjdxSGZUNDRXbmQxOG9vU3RGZmNXSnBTeGlzM240RXNtOWIxRHV5?=
 =?utf-8?B?NGR2RjNHZVI3bXR4UFMzU1NPQ1ZVV3FkaHRXdHBOTTUyMytiV0l6UDJvbElK?=
 =?utf-8?B?NC9LaElnS1E1QU9jMjV4VWt1T2EwVDNkQVF2Zmc3UG1iTDZCaHlmbGpiZGRk?=
 =?utf-8?B?cmFkVHZKVkVwaitlVmhuNGQzMjc2SFdRVDlGd09ZQ0U2NXh2YXBjcUhIdUw5?=
 =?utf-8?B?VUlDNThqeUFYaThYYytacjZTcTFsZ1JWU2VQdEN6UVFMN0wwNHhlVGVuV0Y5?=
 =?utf-8?B?clduaU5QaXNYYXFlQitsRU9DRXVBeURIaStKbWZzN3QzeGZweklwNHE3Yk1Y?=
 =?utf-8?B?QTdDeFZ5QlgwYlhzejBQWTk2QzJjOFBzQkZTQ1Q0TUt4bGhOeHRPY05RSUdX?=
 =?utf-8?B?U1Fwem9La21qYURKVVFpRG9NS0pCazBRY1RvYU1TVUhFb0kvNzZtRlg5MmJa?=
 =?utf-8?B?U0g3RDJadFFhb09ZaVRkTFpIWE4rLzdmK0xSbFo0cDBIQ2Y4ZEQrcUhnam1n?=
 =?utf-8?B?V3owQUpFTWIyczQ1MkNZUW4rOWlUckJaYldtZ0FuL3Brd01BOW4zS0ZIdi84?=
 =?utf-8?B?TVZXTUFCMnlPZkwwZk1iS2twWFZKV2tSNi95S05OaDdKeGhESWdnd3hQaFY0?=
 =?utf-8?B?VVJuYnJ0UE85ZUxGd0lEdmFHTkZMVVNQSUtlVlo1U1UvZHdqSzhrM1JONlpS?=
 =?utf-8?B?aHZPYXlKMmVVZ244SkJSZ2hxV0dEeW85cDVqSXhZVEUwSFZqbGw0Z2U4Qndj?=
 =?utf-8?B?WHloY0hCdDRQaFVndzczWkNHbTJLUGhYS3B5bzB1TlJnNHBhM2w5a3ZqRFRO?=
 =?utf-8?B?UzJaZUJDQ1lWS29hRXNYanNDK3hVRDMwalNHYmdnKzUxV3JOdXBoM0R2NEtP?=
 =?utf-8?B?YVpvQ1ZVZWx5SkRnQmovdmdZNTlsaUp4RFFSNmNwUFNUVUxZTkNESjlRRU15?=
 =?utf-8?B?WkVrTGNRVVkvU3kzTlVYNFRXQlM0eWZ1RDRyR1VDY1hvcHZkSTZ3Q0VqdC8z?=
 =?utf-8?B?ck8rTjRVaS9NR0I2dnZjTCtVb1N0RTdydHBHVExRbng4ZGs3eW9sSnpFc1py?=
 =?utf-8?B?TmFRODdRMlhMekRxLzdhYUIvWWJjNmZYMXBrQ0FaVnV5SkVTcVNRaTBIWTh5?=
 =?utf-8?B?d2c2b3J2UStjV3p5dkdxUXo2Sm5KSEg3YU5XT1lqcDNMSUt1ZHdPV3RhYUF1?=
 =?utf-8?B?NmNDV1RTNzMzdmVtYmw2WUpEUEtkVjZYSW5RRUlHWFp4dmxja3lwVVFwUGk5?=
 =?utf-8?B?a1RKZWtveCtUN1dybDN6UTVWd1hxemJJOXlIRlJSSWZwdkY3YlBoRmg4d0tG?=
 =?utf-8?B?QjQxcUNENVJvOGVvemlYTTYva2lxWTZiREZ2SGpvMGpGWmZzQ0hvTFdLdUVL?=
 =?utf-8?B?dW5hMHFDUkhWUXZiczZyV1RIMStFeEUyd2VFWncwNGJvZlBZUWJZMGhGcHR5?=
 =?utf-8?B?dmJYd3VEdG12LzFGbXlyaUxkMXREQlN5a0NnY21iRDJsczBjUkhBb2NPRTJN?=
 =?utf-8?B?ZkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3823d78d-617b-46f3-bbcb-08ddad7d8993
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 09:01:24.8547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XOklF8Karztuz23Wj4Lc7ktZyJvdybt3b9hm12E+WAp67qOKYJrCB122L+tDr+ITZCOzeZyGCuyJ1gWvD3RLfCD/9O2hiQenY3rObQRqr3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5990
X-OriginatorOrg: intel.com

On 6/16/25 21:42, Kaplan, David wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi,
> 
> My "Ethernet controller: Intel Corporation Ethernet Controller 10G X550T (rev 01)" device stopped working on recent kernel builds (fails to show up in 'ifconfig' or to get an IP address).  I bisected the failure down to the following commit:
> 
> commit a0285236ab93fdfdd1008afaa04561d142d6c276 (HEAD, refs/bisect/bad)
> Author: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Date:   Thu Apr 10 14:59:56 2025 +0200
> 
>      ixgbe: add initial devlink support

[..]

> Normally, the device is given a name like enp194s0f0 and connects to the wired network.  

now the name is likely to be different, please see this thread:
https://lkml.org/lkml/2025/4/24/1750

Is it possible that your network setup script has some part of interface
discovery hardcoded?

> Starting with this patch, it fails to do so.  I'm not familiar with how to debug this particular device, so please let me know what other information would be of assistance.
> 
> lspci -vv information (on a working build):
> 
> c2:00.0 Ethernet controller: Intel Corporation Ethernet Controller 10G X550T (rev 01)
>          Subsystem: ASRock Incorporation Ethernet Controller 10G X550T
>          Physical Slot: 0-1
>          Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
>          Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>          Latency: 0
>          Interrupt: pin A routed to IRQ 77
>          IOMMU group: 12
>          Region 0: Memory at 18020800000 (64-bit, prefetchable) [size=4M]
>          Region 4: Memory at 18020c04000 (64-bit, prefetchable) [size=16K]
>          Expansion ROM at b6000000 [disabled] [size=512K]
>          Capabilities: <access denied>
>          Kernel driver in use: ixgbe
>          Kernel modules: ixgbe
> 
> Thanks --David Kaplan
> 
> 


