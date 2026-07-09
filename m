Return-Path: <netdev+bounces-306042-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id abdhEJIuT2rnbgIAu9opvQ
	(envelope-from <netdev+bounces-306042-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 07:16:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1D372CB6F
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 07:16:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=nL47WXmX;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306042-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306042-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C89113015CB5
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 05:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F4C33121F;
	Thu,  9 Jul 2026 05:15:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309511F91E3
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 05:15:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783574157; cv=fail; b=i8PODMNKmzLRetCFD8vnesWPv8t4T038LAk+6AI75zSrOKT7pz0lHL60PIXiRrS/JLbS8JkG/SH/FbuGAeC34sAvWO5IlP6NK3pYBGCj5CWWVQhmKJ/Ob7AOyVI7awSdjX5KnzL1qSRL/rGe2za48SUZh6SsrpSds3eZ17Qt6y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783574157; c=relaxed/simple;
	bh=2zVa0o+sSQr+l6bZOVmGw5u413sl+ZhoPQUiyh1Qyfk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MIP1eZkpcb3FawNkEODAxpDtNIctwM3uF/1I3lARzTRT6ztPNhtct83exNQhwtoSEH+9eHrp5dPr0DFYfYIHQiJi0R1DXoIAHEGIrY6dGZ+rHUoQedqa4Axw8OHN8hCtyvjuehQSnXE0CkM4Cftn0ajrlTF+aqXjKb2nyvHJ5iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nL47WXmX; arc=fail smtp.client-ip=192.198.163.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783574155; x=1815110155;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2zVa0o+sSQr+l6bZOVmGw5u413sl+ZhoPQUiyh1Qyfk=;
  b=nL47WXmXqLILuEDfvwO4EjpwIaoBEarqjnjSYmtns8mFP5MoXWvt7f9n
   IL9xTTebpKfeLmoZOIEJd/tQm0d9xsiRfG0rVRF9jCI7rwGorOkJnRFkS
   mTfin01b+DPhvyFIorHSGWFTqQ127pZPV+tJFoJzcJ+ck9h+V/F9KR9Db
   jrsW8ONzIe5lVn1Ym2SUKEw/HVkxGodTd2gpknQAWOGRVxZUOdYTWGTBA
   Hi01CNV6LcbFFcVQMaGbGIAmChrWjp70PXqMb8EQAukV0dZqhcH1tGaqP
   i/UoFGsLeMEf9ywEIC1dZPwJvIeGj9Wdq5Y/EZDXKuphNJc3ZaM1snakf
   w==;
X-CSE-ConnectionGUID: QQ2+I0LkSsSRH8UH0bW4ig==
X-CSE-MsgGUID: KPhxfp4yTH+SClhyEqJzrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84359961"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84359961"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 22:15:52 -0700
X-CSE-ConnectionGUID: 5hVdYoIAQ9yJnfgTJHCDsA==
X-CSE-MsgGUID: Dp+AsZASTb+mKADGJEA3oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="248115268"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 22:15:53 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 22:15:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 22:15:52 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.18)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 22:15:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/bRldOCYkg1UQTWxbQmCiBXdZCk5Q3PJ6GdGZX+3XV2x3sPQqicDQWhQ9lNNkmxriTMKOCv3REZv/L5TYX/XHRT50FopnBrbIiuJcuKlGgXW6bAa2M7nXIyp3SfTTXjuNyUOD31HANEAGRorGnLCXG8ctQes8lY6Q3pupMSTiPZXvMfCCuGGL/gXEvNWM5U/kOcUfJneK1vys+SWhk9oUBk95SoCmWW0J/Z8qeJk5vEyY7QCZRhBVqYvWzJser7FX/DqUoh+zfJSUY5zsB4AhFQtX2eQuN+lJblUKoyCWi0H+3ZRPaYwet794BY91+SWS+LncOlVr0N/EEjvS3wRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDN/KQQsxUXg+JHS38DFB1BtgNu8Nm7TIDlQsTyiR8Q=;
 b=KRXQX6t8/FjOm2PF3AS415bW6DRDFW8UyaKFLvxWcpMM/FwKNmjT5/qQl2s0BtKxir37zOk6lD1cpEz2vxaQS/anNFTb7M9qeMpQI3hfzKal6n+K8qHuw3l61tVc1wvVxBGcyTI9MU3aFn0KZ6F5dQKjenEWEAQxkGTFvMHWlckw74owwLjsJ0xiEFtbh6zIO8KVcEYpZlaIJp+S7zcvwyzCYcUnP4DsXsEXOyPMPpg8VhxYIDh9EzhbAqC8NCalcp+M1NTLzxjtEYsA+EWFw0vgW+PqBHhhlljZpnWZjwyqW9SdDk9n93lB39Px9xkYCA5eGIHUj+wduVKxB2MTZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 SN7PR11MB6923.namprd11.prod.outlook.com (2603:10b6:806:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Thu, 9 Jul
 2026 05:15:42 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%4]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 05:15:40 +0000
Message-ID: <d96a4c3f-e0e7-42d7-bb8a-994b2f408dea@intel.com>
Date: Thu, 9 Jul 2026 10:45:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] drm/drm_ras: Add drm_ras netlink error event
To: Rodrigo Vivi <rodrigo.vivi@intel.com>, <raag.jadav@intel.com>,
	<kuba@kernel.org>, <aravind.iddamsetty@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, <anshuman.gupta@intel.com>,
	<joonas.lahtinen@linux.intel.com>, <simona.vetter@ffwll.ch>,
	<airlied@gmail.com>, <pratik.bari@intel.com>,
	<joshua.santosh.ranjan@intel.com>, <ashwin.kumar.kulkarni@intel.com>,
	<shubham.kumar@intel.com>, <ravi.kishore.koppuravuri@intel.com>,
	<maarten.lankhorst@linux.intel.com>, <mallesh.koujalagi@intel.com>,
	<soham.purkait@intel.com>, Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
	Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, <dri-devel@lists.freedesktop.org>,
	<netdev@vger.kernel.org>
References: <20260701094409.129131-5-riana.tauro@intel.com>
 <20260701094409.129131-6-riana.tauro@intel.com>
 <202f6d3a-c29b-491b-979f-1d8223f59108@intel.com> <ak6xThf9qeB0wqgK@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <ak6xThf9qeB0wqgK@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::18) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|SN7PR11MB6923:EE_
X-MS-Office365-Filtering-Correlation-Id: 0417d9d0-1c23-4f17-1fc6-08dedd791e22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|7416014|366016|56012099006|22082099003|6133799003|4143699003|18002099003|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: gKze6Q+4LyEVenWpSp3DYtlPD0f8okCHBQK+D148QTyoFOSIQ6tuNA3WkztcUCdZMZYlUvPlZVm6kMf7baGNTuTGU/y9M4aBcMdzwhUOn79eoSg7+zscMzL1tDodzWhT8rzkbqhJcgxDB+cUUUGhFPRmXA4IknDvAg57Hu1fiOnOYk6HPWkHXHQ4N/iql7/vgcGUuRMWIKkXCwOTEhFTME5h/CiUhboa4k1qarU/8p2v51b+lo0RoK0yZNbyRvDoLtGOEDHXUWfQ0NsW+YivHAFG4CHeZrZbqya433fPyqDTwjpuRhqh87lT1p03b6Ouncw9Qi8CEIZSkSXzkWqh4+i9NcqCqbHbcyFtzh88FTH56WPMeMZrAKxnMkg+nsPvjOACBXpH237Ai9PPaeFEPjYzYMvM9WuV1qkVWwZpJipL+0wQdWoGxJ4Jv3F+2zEPmx+/nlozLOkXJXG6+W63jcpHgpaiEex4C8wjgCAFpiIfUGhQf/4C7h7c9/y9slbsZGq4+vDUpQznj4ARaLVCJH4Qpe5SiB/oA9cG/Q/i0Fo2ROiTHVAkf52C3sHkbxea817Hjqtj+5cj83mmVzXQXl02RHkR/3S9JkUOsEW3dBmL094r7ARJQSAoChZWDr9V9oxP2hcuMq2+zAAzGlQxoy2KgKA+TNj5XC54PXnczaM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(7416014)(366016)(56012099006)(22082099003)(6133799003)(4143699003)(18002099003)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGV5K2s4ZmcySi9BT21DQitNdEwwbitUa3ZhSFlEdUdCUnViVFJKeFVTQmo2?=
 =?utf-8?B?NGNEOWw5VFl2dWhUM2dQOFNmZys3RGN4Vk9GV2ljLzFvMVRRQTlMdXpGMlpZ?=
 =?utf-8?B?ZlljZVR0VmlJYnhXeEFjamNmOWk2QUJaYnFZSnRYam9yMDhrK0Y0Z2drYjF3?=
 =?utf-8?B?SjJFUEdFM0cvcThLWkFpWDlEZGhEQmxtUEtOZ002Y0N2WWxQWThFWDRScklt?=
 =?utf-8?B?Z2V1NGVCbnBjY0g5TGFiZlBGeFlSSnpWcVdoclhYa1QwVkZ2a0daZnhsYzJK?=
 =?utf-8?B?ejk2RzJwczVhSVMzeWI1RDZGVU1ObjJPQlA5eG80VXU4NURwcjJmZzg0NEli?=
 =?utf-8?B?OEg4SkZlazg1enArZUxPWlpXRlZXUnF0R3FXS1J2WDNRL2tPMEpvbFFwb1Za?=
 =?utf-8?B?VHNhWmlSa3NVNlg2aFVoNDZyY0Q2VTFmVWRWOCtmMEZ3b2Z0eUgzN2FFVmRk?=
 =?utf-8?B?eExTTGxBc2YyVlYxQkpOdHQ3NjQvZzdHSnpoTGQ5emhQblczbzVNb2llVmlO?=
 =?utf-8?B?eVJ3eXNqR3VPV1N0VXk1NzdSSTRVQ1hTYUhmTFA2VFV2eEN5cFRPQnBubjVi?=
 =?utf-8?B?OFFHak4rNUNzSzI2MEMrcVdnRUdzTFoyOWt1eE9pV1VLT29PVGtsSTJ5U3dl?=
 =?utf-8?B?QlA3dEFZNnBkcDFZTGIyeGdzQjlQdTBaMyt0SUtxa3ZYSVA1alJJazlGNFVh?=
 =?utf-8?B?YkIxWkZWc05xTXc5SVVuWGY0ZzZHOWQzWEdZVGJILzZKaTJaL1NxS3Bvckp2?=
 =?utf-8?B?R2lUN1p5MTVrK1N3cnVWNE5UUjdUclpxd3dtbjBicFkyTTE4UWZKZThEWk9l?=
 =?utf-8?B?M056a1hycW9pdjJ1ekJSbkZGOENkb2N2bWJwMnpGVXZRRGxwWlg1NlFtcHJJ?=
 =?utf-8?B?MVVHNnlGZ0s1ZFpJVWNyMUl5UFlmL0duS3JsWGQrNE5sb3daUXBueWdOMmlW?=
 =?utf-8?B?UHZDdldhaVdBN1ZrZHFMWVg2VjMvdW9KanFqSEFSY0V3ditRT05oRXNURU1F?=
 =?utf-8?B?MllrYUpva042elBTWTlQQjhoaUVZUWRZUCtEZUo5UklDUktocTk3aXNtVGFt?=
 =?utf-8?B?eUxOeUZ2VFptUysvTklVNVp4Z1l4T2tkdzVab2lNOGtDQXg3bUhqYzhsSk5o?=
 =?utf-8?B?V2l1UFFNNFBQTkw0N00zNDhnQ3FjRVI0SFBURGQ2T3NCUzlJYnFWYnc4Rytm?=
 =?utf-8?B?U24xaXBaaE16K2pkN29RWi92NEJoVmVaMk9xcG9JTHlQNHU5VmJQcnFTcVNX?=
 =?utf-8?B?MkRsQVhhWWlSVzhhUkV1dFRFMHpWNVJSVHdRejB2U1E4U0gvTUxGZXNyNkgz?=
 =?utf-8?B?WFZiUmQwa2licWFlYUtrdDYyZ0VIT3BDL2xxMkNxK3ZNOHJWMzQxQUFhbkZC?=
 =?utf-8?B?VmtxVEh5L1RkaWdIMUljOHdJbFlUOWZPSUUvb2h0aHBDRjNoZHRYdG9CaGxa?=
 =?utf-8?B?V3pHbndEYngvS055bUVyN1VZVDFpcTN4UkZjVTVxUXB1bk95T295UFhYTFVx?=
 =?utf-8?B?anAvYkw0T1dCeG1rV291RW5TMStZM0o0WmlZY1hzOWpkbWRkb0hFUzY4WjZa?=
 =?utf-8?B?Tm5XdkVXbERYN0tBVlBPTHlzeE5lcXVqUHVaczczL0VZV3BFZ0RZTDhpeERY?=
 =?utf-8?B?VTdhUHA3aUlqSGdseWNaNy9jMytwb1VaUG45Qm9Jc202UkFqdS9oQSt4VHVu?=
 =?utf-8?B?SzNWeFZkNldJeUdUNkRJTXo0aVJaOFlaUmZrMERtMkJLOGVJYnpGYXpUOXRH?=
 =?utf-8?B?Y25vVkloSXdHVVFRZW15YnZDU01mUFVuQklJWTczNmg0N2lGbWx3YXFOWDRB?=
 =?utf-8?B?TEgyODgxcVlWdmRodkUwZ2U1VnExZ2hBTjZmRTdFZ2xXV3ViaFdoblplN1FW?=
 =?utf-8?B?cjJBRU1sTTY0ZjZxQ0UzY3BvcDRROHBoeDV6UUhpUnlsRFgzeUh3QjJnSkIw?=
 =?utf-8?B?TXhLaU5oaTMzemZkZ2ZqaVNGM2RzakEwWm5jSFRTNklaZGdzRGEyQ2NXUnJU?=
 =?utf-8?B?Ym94eC9xZy9jelBHMjdLcEVrMEJ0czErWDZ1czdKbWhYUnRFU2RqU2hXRkpy?=
 =?utf-8?B?dURGQVpCeVFNWW1VTkNwY0JtUnJJcStFVFdReVB3VE5XVVpUV0pYOXR4dFNG?=
 =?utf-8?B?aDh3VytvUUM4Zy9UWVEvV2NTalArWTNYRHZpUWRkbHI2WmwwaTkzMy9zb2Z1?=
 =?utf-8?B?MFJkQXZzTjNXdmZleTZXUDF3UmxIaHd5QlpwUHB3QlViL3pUQno3U2Y1aCsy?=
 =?utf-8?B?UGwrNmNwZGoybzZCMW13cm8vRTBBUnRyME03ZGk5c0c3Z0JySUxTMXFZVzRF?=
 =?utf-8?B?SmIrYTVvQnhoMmFMeE0vdTY0R1BLL2RSM0xpcHZSYm5hc3QvY29XZz09?=
X-Exchange-RoutingPolicyChecked: p8UKEpamDOuCSeyF6cvCGaV8zlqYgoojfXihfNb9P2sgh5/hCHr9g1SqXSU9e/wXPdp6dbUv6Wf8I2HX0eFkj/y6AXWp14S2czcN+HGiIyTmWl7mB54Zqnwa+jg6KEmov30Hz5z/avATeUg/dpwdbDYgY/kamc8GnirjO9925TwZuGHQvzOb9kRyylmSgRArbTVeJJDmyKpR6Yqou5JIgDNW5qhNprSmxBkzOqlYiRLIDhFFNXmVEmhVx0OL2LLsRbpMExckeNbVlJkhaBeKTFw4DOau4hx67r0tQYBmyMndAy3qayPR5jGVo7yiJDvZAeLZrZUs7rHf1xc5erCQQA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0417d9d0-1c23-4f17-1fc6-08dedd791e22
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 05:15:40.5942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fBYuqyxTpow3eiE5dSd1GpyFieEVs0cg/nyAddiYczH4aQHIhNW9m9VIeqMTWasNbHMaFOLIYTHLpWkoX5PEWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6923
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306042-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rodrigo.vivi@intel.com,m:raag.jadav@intel.com,m:kuba@kernel.org,m:aravind.iddamsetty@linux.intel.com,m:intel-xe@lists.freedesktop.org,m:anshuman.gupta@intel.com,m:joonas.lahtinen@linux.intel.com,m:simona.vetter@ffwll.ch,m:airlied@gmail.com,m:pratik.bari@intel.com,m:joshua.santosh.ranjan@intel.com,m:ashwin.kumar.kulkarni@intel.com,m:shubham.kumar@intel.com,m:ravi.kishore.koppuravuri@intel.com,m:maarten.lankhorst@linux.intel.com,m:mallesh.koujalagi@intel.com,m:soham.purkait@intel.com,m:zachary.mckevitt@oss.qualcomm.com,m:lijo.lazar@amd.com,m:Hawking.Zhang@amd.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:dri-devel@lists.freedesktop.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,intel.com,linux.intel.com,ffwll.ch,gmail.com,oss.qualcomm.com,amd.com,davemloft.net,redhat.com,google.com,vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E1D372CB6F


On 09-07-2026 01:51, Rodrigo Vivi wrote:
> On Tue, Jul 07, 2026 at 12:02:11PM +0530, Tauro, Riana wrote:
>> Hi Rodrigo/Jakub/Aravind
>>
>> Please let me know if you have any feedback for this patch or can you please
>> ack this if it looks good to you.
> I looks good to me, but could you please double check the sashiko's comments?

Sashiko has a comment regarding namespaces

[Severity: Medium]Since the generic netlink family explicitly supports 
multiple networknamespaces by setting .netnsok = true,
  will hardcoding init_net hereprevent listeners in non-init namespaces 
from receiving error events

.netnsok = true is auto generated not explicitly added in code.

But from what i see, drm device is present in the host and not 
replicated across namespaces
and most of the non-network implementations use inet.  (ex: Binder)
If this really needs a fix, we can drop the has_listeners suggested by 
raag  in previous patch.
I don't think in an error path, allocating a new buffer would be a big 
overhead if listeners are not present.

@Raag let me know your thoughts.

The 3rd patch can be floated seperately, I can drop it before merging 
and resend if i can get an ack for this
patch

Thanks
Riana



>
> Patch 3 still needs review I believe, then we get Jakub and drm maintainers acks
> to get this through drm-xe-next.
>
> Thanks,
> Rodrigo.
>
>> Thanks
>> Riana
>>
>> On 01-07-2026 15:14, Riana Tauro wrote:
>>> Define a new netlink event 'error-event' and a new multicast group
>>> 'error-report' in drm_ras. Each event contains device name, node and
>>> error information to identify the error triggering the event.
>>>
>>> Add drm_ras_nl_error_event() to trigger an event from the driver.
>>> Userspace must subscribe to 'error-report' to receive 'error-event'
>>> notifications.
>>>
>>> Usage:
>>>
>>> $ sudo ynl --family drm_ras --subscribe error-report
>>>
>>> Cc: Jakub Kicinski <kuba@kernel.org>
>>> Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
>>> Cc: Lijo Lazar <lijo.lazar@amd.com>
>>> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
>>> Cc: David S. Miller <davem@davemloft.net>
>>> Cc: Paolo Abeni <pabeni@redhat.com>
>>> Cc: Eric Dumazet <edumazet@google.com>
>>> Signed-off-by: Riana Tauro <riana.tauro@intel.com>
>>> Reviewed-by: Raag Jadav <raag.jadav@intel.com>
>>> ---
>>> v2: remove redundant initialization
>>>       remove unnecessary space
>>>       use ynl in commit message and doc (Raag)
>>>       simplify doc for error-event attrs
>>>
>>> v3: rename error-notify to error-report
>>>       Replace notify with report across the file (Raag)
>>> ---
>>>    Documentation/gpu/drm-ras.rst            | 21 ++++++
>>>    Documentation/netlink/specs/drm_ras.yaml | 48 +++++++++++++
>>>    drivers/gpu/drm/drm_ras.c                | 87 ++++++++++++++++++++++++
>>>    drivers/gpu/drm/drm_ras_nl.c             |  6 ++
>>>    drivers/gpu/drm/drm_ras_nl.h             |  4 ++
>>>    include/drm/drm_ras.h                    |  5 ++
>>>    include/uapi/drm/drm_ras.h               | 15 ++++
>>>    7 files changed, 186 insertions(+)
>>>
>>> diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm-ras.rst
>>> index 83c21853b74b..406e4c49bac1 100644
>>> --- a/Documentation/gpu/drm-ras.rst
>>> +++ b/Documentation/gpu/drm-ras.rst
>>> @@ -56,6 +56,7 @@ User space tools can:
>>>      ``node-id`` and ``error-id`` as parameters.
>>>    * Clear specific error counters with the ``clear-error-counter`` command, using both
>>>      ``node-id`` and ``error-id`` as parameters.
>>> +* Subscribe to the ``error-report`` multicast group to receive ``error-event``.
>>>    YAML-based Interface
>>>    --------------------
>>> @@ -111,3 +112,23 @@ Example: Clear an error counter for a given node
>>>        sudo ynl --family drm_ras --do clear-error-counter --json '{"node-id":0, "error-id":1}'
>>>        None
>>> +
>>> +Example: Subscribe to ``error-report`` multicast group
>>> +
>>> +.. code-block:: bash
>>> +
>>> +    sudo ynl --family drm_ras --output-json --subscribe error-report
>>> +
>>> +.. code-block:: json
>>> +
>>> +    {
>>> +        "name": "error-event",
>>> +        "msg": {
>>> +            "device-name": "0000:03:00.0",
>>> +            "node-id": 1,
>>> +            "node-name": "uncorrectable-errors",
>>> +            "error-id": 1,
>>> +            "error-name": "error_name1",
>>> +            "error-value": 1
>>> +        }
>>> +    }
>>> diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
>>> index e113056f8c01..8aed3d4515e5 100644
>>> --- a/Documentation/netlink/specs/drm_ras.yaml
>>> +++ b/Documentation/netlink/specs/drm_ras.yaml
>>> @@ -69,6 +69,33 @@ attribute-sets:
>>>            name: error-value
>>>            type: u32
>>>            doc: Current value of the requested error counter.
>>> +  -
>>> +    name: error-event-attrs
>>> +    attributes:
>>> +      -
>>> +        name: device-name
>>> +        type: string
>>> +        doc: Device (PCI BDF, UUID) that reported the error.
>>> +      -
>>> +        name: node-id
>>> +        type: u32
>>> +        doc: ID of the node that reported the error.
>>> +      -
>>> +        name: node-name
>>> +        type: string
>>> +        doc: Name of the node that reported the error.
>>> +      -
>>> +        name: error-id
>>> +        type: u32
>>> +        doc: ID of the error counter.
>>> +      -
>>> +        name: error-name
>>> +        type: string
>>> +        doc: Name of the error.
>>> +      -
>>> +        name: error-value
>>> +        type: u32
>>> +        doc: Current value of the error counter.
>>>    operations:
>>>      list:
>>> @@ -124,3 +151,24 @@ operations:
>>>          do:
>>>            request:
>>>              attributes: *id-attrs
>>> +    -
>>> +      name: error-event
>>> +      doc: >-
>>> +           Report an error event to userspace.
>>> +           The event includes the device, node and error information
>>> +           of the error that triggered the event.
>>> +      attribute-set: error-event-attrs
>>> +      mcgrp: error-report
>>> +      event:
>>> +        attributes:
>>> +          - device-name
>>> +          - node-id
>>> +          - node-name
>>> +          - error-id
>>> +          - error-name
>>> +          - error-value
>>> +
>>> +mcast-groups:
>>> +  list:
>>> +    -
>>> +      name: error-report
>>> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
>>> index d6eab29a1394..77f912a4d101 100644
>>> --- a/drivers/gpu/drm/drm_ras.c
>>> +++ b/drivers/gpu/drm/drm_ras.c
>>> @@ -41,6 +41,11 @@
>>>     *    Userspace must provide Node ID, Error ID.
>>>     *    Clears specific error counter of a node if supported.
>>>     *
>>> + * 4. ERROR_REPORT: Subscribe to this multicast group to receive error events
>>> + *
>>> + * 5. ERROR_EVENT: Report an error event to userspace. The event contains device, node
>>> + *    and error information that triggered the event.
>>> + *
>>>     * Node registration:
>>>     *
>>>     * - drm_ras_node_register(): Registers a new node and assigns
>>> @@ -186,6 +191,34 @@ static int msg_reply_value(struct sk_buff *msg, u32 error_id,
>>>    			   value);
>>>    }
>>> +static int msg_put_error_event_attrs(struct sk_buff *msg, struct drm_ras_node *node,
>>> +				     u32 error_id, const char *error_name, u32 value)
>>> +{
>>> +	int ret;
>>> +
>>> +	ret = nla_put_string(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_DEVICE_NAME, node->device_name);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = nla_put_u32(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_ID, node->id);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = nla_put_string(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_NAME, node->node_name);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = nla_put_u32(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_ID, error_id);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = nla_put_string(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_NAME, error_name);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	return nla_put_u32(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_VALUE, value);
>>> +}
>>> +
>>>    static int doit_reply_value(struct genl_info *info, u32 node_id,
>>>    			    u32 error_id)
>>>    {
>>> @@ -222,6 +255,60 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
>>>    	return genlmsg_reply(msg, info);
>>>    }
>>> +/**
>>> + * drm_ras_nl_error_event() - Report an error event
>>> + * @node: Node structure
>>> + * @error_id: ID of the error
>>> + * @error_name: Name of the error
>>> + * @value: Value associated with the error
>>> + * @flags: GFP flags for memory allocation
>>> + *
>>> + * Report an error-event to userspace using the error-report multicast group.
>>> + *
>>> + * Return: 0 on success, or negative errno on failure.
>>> + */
>>> +int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id, const char *error_name,
>>> +			   u32 value, gfp_t flags)
>>> +{
>>> +	struct genl_info info;
>>> +	struct sk_buff *msg;
>>> +	struct nlattr *hdr;
>>> +	int ret;
>>> +
>>> +	if (!error_name)
>>> +		return -EINVAL;
>>> +
>>> +	if (!genl_has_listeners(&drm_ras_nl_family, &init_net, DRM_RAS_NLGRP_ERROR_REPORT))
>>> +		return 0;
>>> +
>>> +	genl_info_init_ntf(&info, &drm_ras_nl_family, DRM_RAS_CMD_ERROR_EVENT);
>>> +
>>> +	msg = genlmsg_new(NLMSG_GOODSIZE, flags);
>>> +	if (!msg)
>>> +		return -ENOMEM;
>>> +
>>> +	hdr = genlmsg_iput(msg, &info);
>>> +	if (!hdr) {
>>> +		ret = -EMSGSIZE;
>>> +		goto free_msg;
>>> +	}
>>> +
>>> +	ret = msg_put_error_event_attrs(msg, node, error_id, error_name, value);
>>> +	if (ret)
>>> +		goto cancel_msg;
>>> +
>>> +	genlmsg_end(msg, hdr);
>>> +	genlmsg_multicast(&drm_ras_nl_family, msg, 0, DRM_RAS_NLGRP_ERROR_REPORT, flags);
>>> +	return 0;
>>> +
>>> +cancel_msg:
>>> +	genlmsg_cancel(msg, hdr);
>>> +free_msg:
>>> +	nlmsg_free(msg);
>>> +	return ret;
>>> +}
>>> +EXPORT_SYMBOL(drm_ras_nl_error_event);
>>> +
>>>    /**
>>>     * drm_ras_nl_get_error_counter_dumpit() - Dump all Error Counters
>>>     * @skb: Netlink message buffer
>>> diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
>>> index dea1c1b2494e..9d3123cc9f9c 100644
>>> --- a/drivers/gpu/drm/drm_ras_nl.c
>>> +++ b/drivers/gpu/drm/drm_ras_nl.c
>>> @@ -58,6 +58,10 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
>>>    	},
>>>    };
>>> +static const struct genl_multicast_group drm_ras_nl_mcgrps[] = {
>>> +	[DRM_RAS_NLGRP_ERROR_REPORT] = { "error-report", },
>>> +};
>>> +
>>>    struct genl_family drm_ras_nl_family __ro_after_init = {
>>>    	.name		= DRM_RAS_FAMILY_NAME,
>>>    	.version	= DRM_RAS_FAMILY_VERSION,
>>> @@ -66,4 +70,6 @@ struct genl_family drm_ras_nl_family __ro_after_init = {
>>>    	.module		= THIS_MODULE,
>>>    	.split_ops	= drm_ras_nl_ops,
>>>    	.n_split_ops	= ARRAY_SIZE(drm_ras_nl_ops),
>>> +	.mcgrps		= drm_ras_nl_mcgrps,
>>> +	.n_mcgrps	= ARRAY_SIZE(drm_ras_nl_mcgrps),
>>>    };
>>> diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
>>> index a398643572a5..03ec275aca92 100644
>>> --- a/drivers/gpu/drm/drm_ras_nl.h
>>> +++ b/drivers/gpu/drm/drm_ras_nl.h
>>> @@ -21,6 +21,10 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
>>>    int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
>>>    					struct genl_info *info);
>>> +enum {
>>> +	DRM_RAS_NLGRP_ERROR_REPORT,
>>> +};
>>> +
>>>    extern struct genl_family drm_ras_nl_family;
>>>    #endif /* _LINUX_DRM_RAS_GEN_H */
>>> diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
>>> index 0beede3ddc4e..8abfb7d2077b 100644
>>> --- a/include/drm/drm_ras.h
>>> +++ b/include/drm/drm_ras.h
>>> @@ -80,9 +80,14 @@ struct drm_device;
>>>    #if IS_ENABLED(CONFIG_DRM_RAS)
>>>    int drm_ras_node_register(struct drm_ras_node *node);
>>>    void drm_ras_node_unregister(struct drm_ras_node *node);
>>> +int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id, const char *error_name,
>>> +			   u32 value, gfp_t flags);
>>>    #else
>>>    static inline int drm_ras_node_register(struct drm_ras_node *node) { return 0; }
>>>    static inline void drm_ras_node_unregister(struct drm_ras_node *node) { }
>>> +static inline int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id,
>>> +					 const char *error_name, u32 value, gfp_t flags)
>>> +{ return 0; }
>>>    #endif
>>>    #endif
>>> diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
>>> index 218a3ee86805..eab8231aa87c 100644
>>> --- a/include/uapi/drm/drm_ras.h
>>> +++ b/include/uapi/drm/drm_ras.h
>>> @@ -38,13 +38,28 @@ enum {
>>>    	DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX = (__DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX - 1)
>>>    };
>>> +enum {
>>> +	DRM_RAS_A_ERROR_EVENT_ATTRS_DEVICE_NAME = 1,
>>> +	DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_ID,
>>> +	DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_NAME,
>>> +	DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_ID,
>>> +	DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_NAME,
>>> +	DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_VALUE,
>>> +
>>> +	__DRM_RAS_A_ERROR_EVENT_ATTRS_MAX,
>>> +	DRM_RAS_A_ERROR_EVENT_ATTRS_MAX = (__DRM_RAS_A_ERROR_EVENT_ATTRS_MAX - 1)
>>> +};
>>> +
>>>    enum {
>>>    	DRM_RAS_CMD_LIST_NODES = 1,
>>>    	DRM_RAS_CMD_GET_ERROR_COUNTER,
>>>    	DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
>>> +	DRM_RAS_CMD_ERROR_EVENT,
>>>    	__DRM_RAS_CMD_MAX,
>>>    	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
>>>    };
>>> +#define DRM_RAS_MCGRP_ERROR_REPORT	"error-report"
>>> +
>>>    #endif /* _UAPI_LINUX_DRM_RAS_H */

