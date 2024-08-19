Return-Path: <netdev+bounces-119900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A00749576E2
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 23:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56A31283EFB
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 21:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E913F15C14B;
	Mon, 19 Aug 2024 21:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RsnqoOJl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6B71514EE
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 21:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724104425; cv=fail; b=YCoFgC3gwTFofsRyB+dAek4g/a1/AVWOAGmiJYT9CqLJQZJxn59BqjS81Aac6czvIkjq3vBKN3YEOKf1jnF4jB8BiDUL0P2t8czb6wKh63rcePyKekfiQEUcMP2tO0HkC3X3JDslg1yDbWZvcNCp8mSBtO3RRGKrI6qWAhqqpvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724104425; c=relaxed/simple;
	bh=xTNs0c2AvTPEi1UgJSPRUlKssGl7LGIzDUsi76iYB+U=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RFsYjkIjt47XgrQvUKndDVMhMcWTicSZMvrSBcsInB+nM719iuEHKXd3hK0wyBmQsEfD2JTSgCiNti5socUUxS2jYTYoZGLzmNjtj/5arqSQppJJS+JnhAu//Qfw0mtxoN8UmUzB4HLf7WOPGKIC8ro/BQ3WWIA1mEB1x7Uzvh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RsnqoOJl; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724104424; x=1755640424;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xTNs0c2AvTPEi1UgJSPRUlKssGl7LGIzDUsi76iYB+U=;
  b=RsnqoOJlWFrMkK1RuyPle5QIDT0a2XTIVRkt9bqcyFE/u+oGCsVwmriv
   QIm04+rrhXQaPRCbmGh+UTCmHepfU1AvRc+i83dBSWvmn/dWq5oNY9Auw
   xP0fiO+FIOcUUUkdSgrHaDAhguj/qXDNXx0JrOR/xWNVCjwg1FOQ67gA3
   pQezVQYRk8QMHgxmiH8//ESsuurZ2H8D1QupO4A7PmCgZM0pa+agC7Ewb
   tz1wzyIohsniV57SeMJtqvqt894VWhKeP0YUle2huKsumHeqDIsK5woaI
   oR59n0ZAxFDifOE8RYRDWx6VTAB4GGm/3b+QRKoz16TV8by5LMREEq36n
   A==;
X-CSE-ConnectionGUID: mccKyMkXQo+zsTw3aWwpaQ==
X-CSE-MsgGUID: WW5WGflCTrCynaXkE09VKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="47770431"
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="47770431"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 14:53:43 -0700
X-CSE-ConnectionGUID: xojaOm/+QCqBa7lS5WtAng==
X-CSE-MsgGUID: uGKnGMQ/ROSl02pSJm732Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="60825746"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Aug 2024 14:53:43 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 14:53:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 14:53:41 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 14:53:41 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 14:53:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIT0ti2rzY5uzGNJ26nJ5GsrvFDKVp2l5Q7yXlFxp/JChAqxoWqd0uoDYnJAepVk8RYuYWVb3bAMVC9oHSFyJ5KWMFY290SD0BxEFUcE/UxRS22iliJPAoRb20mOU3I5XwF07kMwMOoloEaFZkncTa3GriHTTzqflE6OyUepamItUlHV/64Ej7pV/kmHNS1D2w582kR3M78ahWVycgBbBhjlc7aVcCHG1VvzetA1WOVmtMsFFux/5g9ALcNlRJoc7z6eqPxPq3y149PccPbr+DleU99Ht0DOig4rn97X5jMLVB3Li40LCnIvS7kDZv117DsQIRjX8y5LTE5xXoRKng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIuOMuw0a1eEsLxcuqL3BtgL66yZZDG0fE9fgAWDLoM=;
 b=QAPGOMiJexrVRF1Og+nCi3bUeztSj2zdHqEH9n5eVLa1PndmaiEkMVvbuzQfrz2D+pVfeG6p+dP/ZUMha4hc5ohM4Rf/TX5qCHr9D6QtA8m3Jrf4iD9vMdkQWw6LdNBygWvnLJf4UMKKd7jSRSzXBy7G8xx9CsQDYKC4zZ6kMxVMrnvAMO8yKvuB16BPRJcEsa70gP0F5+rMqLckYvhWLzxMElYNvUuFuUpXhcEwgRfFMG8UE4Saym4gYqDu7FeW9PbX06W9gFAXUZB8j7sLxE9vfV88H8E58E+hfAb239Jz3ZuEBk2hPNxrOWv7Cwa9GU42rU5LWF9l4v44aUeHWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CO1PR11MB4996.namprd11.prod.outlook.com (2603:10b6:303:90::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 21:53:39 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 21:53:36 +0000
Message-ID: <7d0e11a8-04c3-445b-89d3-fb347563dcd3@intel.com>
Date: Mon, 19 Aug 2024 14:53:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: lib/packing.c behaving weird if buffer length is not multiple of
 4 with QUIRK_LSW32_IS_FIRST
From: Jacob Keller <jacob.e.keller@intel.com>
To: Vladimir Oltean <olteanv@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <a0338310-e66c-497c-bc1f-a597e50aa3ff@intel.com>
 <0e523795-a4b2-4276-b665-969c745b20f6@intel.com>
 <20240818132910.jmsvqg363vkzbaxw@skbuf>
 <fcd9eaf4-3eb7-42e1-9b46-4c03e666db69@intel.com>
Content-Language: en-US
In-Reply-To: <fcd9eaf4-3eb7-42e1-9b46-4c03e666db69@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0029.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::34) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CO1PR11MB4996:EE_
X-MS-Office365-Filtering-Correlation-Id: c45d5278-42f9-4b7a-1ee2-08dcc099606c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QjZWaVZ4M1p4V01IbmJrNWhJcmNmSmhML05iWkhrWHFDanV6cGhZZ0lZUDJJ?=
 =?utf-8?B?dmx1TldHV05obnF6QWorWlVLakVZdjB0UWlidnRHdEx0a2Y2RmRkMVdsT3Iv?=
 =?utf-8?B?SW40cWVRbTZWdnp3ZFJsWmJ1YTVnNHpzOHFhbWNpOEZxb0JDSlNkeGVzcHdC?=
 =?utf-8?B?U0N5UDN4d2NFMkF2T3k1Y2VTcnVKTktzVGJ5MjRndjBrdjRlcnl4ZnFDK2ZC?=
 =?utf-8?B?ZDE0SStzYVBLd3Z1ZFhXMDhJaGtZWXlJWHovTXVuZzY5Rm12Q01xK2pnMkVu?=
 =?utf-8?B?Tmh6c290UHFKak5kcXVKaXFqU1FCbVVuOTFEcXhvek9EVWI4RzdVSGszNjdr?=
 =?utf-8?B?QWFST2h0ZkxSNEZmRkJJWVF4Ym9IUUtZUGI1ZjFVSk4rMk1RalZJRFlTdE5h?=
 =?utf-8?B?UTlyVENoQVFnTlREMDdReHBJcC9WV1padWErc2g0L1c3Tzg0N0pIME9yZmM5?=
 =?utf-8?B?REp2a2NTQjNBL0x5Mk0yVzBPanhISjk5RnZleG5Jb0tBL2lMSWdmNnFNYkY3?=
 =?utf-8?B?eTUrbk9JVHlTalMvSnJsdXE4Q1J2YUpUbTlSbFI3WTE5MVNMKzllcHI2R0kv?=
 =?utf-8?B?VnM4UEpYS2dBZEJwV3Vma0MwOCswUTJQdzgrSG5XNmFHdHNMeldodXFna201?=
 =?utf-8?B?NjBuUzc4aXlhZmhwMnZ3b3hXUElReDViMGlQSk5hUTBGQng3eDlQS29ia1JV?=
 =?utf-8?B?cG8zUzlseVM2M1k1emlEWjFIcXNPRTZKSzRZSnA5Y3hhM096UXg0SDI1RjRD?=
 =?utf-8?B?V3JHbnlWZkhKS3Qxc3R5bi9ocFhvWmdDZElVZ0VtekZzanRlN0hsZW95Wldn?=
 =?utf-8?B?ZVBaWlNDeVRsM1E2VnJubEVSWStVdElIN3hKT2JlNHlqWk1LVnllTGdPR0M5?=
 =?utf-8?B?Vm9hNHNPL09IQmVPZFk3MFpHdStqeFVXVm5oSUlhRThndGhldkloY2pwS295?=
 =?utf-8?B?aVNha254R1d6VHlzV3IrQVh4MjFGaXgrUjZkZlJQSUdNanMvMmdTVE43SjBl?=
 =?utf-8?B?am15VmEraEZ5TXNvYmlsdEpzVG5zQkNBSW53bUFxakNsL3RwWDQwTzRkcjNw?=
 =?utf-8?B?NUk0ZTRxVzJFdzBWM3FrUGdLRG5CSDFBOFpSV0JqdDd6czJrNFR4d1l2cUxC?=
 =?utf-8?B?VkREQ0kycEN3dWtvL1h2NWtOMGZSblMyMUhaYXo2TC81eSt6M054bEs5K3o2?=
 =?utf-8?B?a2U1MEMwbFUrTUZTaURqWnNkSDhySDN5NkdUM0x0MWdDbTBDak9GVE92QWpZ?=
 =?utf-8?B?eHl5VlZreTJvakNZMlJzQlVoamtCdkFnclh5RUVJcHRWa2tQa1NPVEhJL0Mv?=
 =?utf-8?B?YUNWbFB4d3B5MkkxK2QraTd2UGszclVRdnNDcXVYd1lScmNsR0M2RFUrN0xI?=
 =?utf-8?B?eC9jaDd6ZzdienhGOExDbHd1cVh4bHphUUVYZUVVQzhjdWUxcHovUm5rOGtE?=
 =?utf-8?B?MWxyYStJaEdhVDVMcTlKU0RKSFNvbURoUSthMXd6Sng1c2pRWHhFWFgxZzdj?=
 =?utf-8?B?R0hoMTUyN1JVTS83WURIUVA4QllneUZLY29wYTZ5UElGRVpUUmh3R05XM3JT?=
 =?utf-8?B?cVVVMWtKNWNIbDNGT0s0YXpPd3E2T05JSGhSSU9UbXhkSmhMVkpVK0dmZU5S?=
 =?utf-8?B?OVpjaDl0d1lnSG1nY0l0WVhpR1lpMURLSVRDUzI5b0grUDh4YXVCYjdmeS9N?=
 =?utf-8?B?UWhqSUdaV2dwUTMzSCtxakI2UCttcGs4YUJ2V1B5U2ZzQUljQitVei9oOXJl?=
 =?utf-8?B?YVJ5SkhLcXYxUy96SkNJeUVDRnBZTG13T3NKSHBzK0ViVVNxN0ovTEtIajdC?=
 =?utf-8?B?QmsyZ2dFb3NrYzVXQ2svQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHpDRGJHMmk4MTQySmlpK1o1S1VlWW5TRXhIUVRnakFCcUIxUFdvZVBhRDZH?=
 =?utf-8?B?NjJKVmFIVWpXdUtJOHZGWTNDc2NVSTd5Zklxb0xnMHR2Y20vRDRFa2tZYXRs?=
 =?utf-8?B?dS9RaDRBS3dhS3I0MHBtMkFoa0hoSFA5cW9GVll5SUJuSFg3NzNhZC9nWkU5?=
 =?utf-8?B?M2l0N21KanBxNzdpKzJRVklOd2F5Zi8xTmNwYUh0aGF4d0g0RDFRcy9yVXdw?=
 =?utf-8?B?VER0dlo0R3hQSXJsWHVPdXYzQThRQ3d2U3kyV0VMN2I1dkdWVndEZnNNckkv?=
 =?utf-8?B?Z0ZSVVM1NmduMjJYbTRKNC9mZ0JwRm9XQWNPTDR2UmZiZitBTkYzV3NaVVFU?=
 =?utf-8?B?N3hHZjdXczJZQkZRU0p6dGxGcmJnOGE2T2h6Yy9hZmpKcjU1d0tjVWU4QVdS?=
 =?utf-8?B?ekptS0NFMVFmK0lSRFIrQ1dNSGNlSDdld3ZlYXFQOWZpMXRwQ24xamdKeGNN?=
 =?utf-8?B?Vldmc0ovbVNtL1lqb0JWQ205U2xsN01iZ3JQYkgvZ2paSW5zS2V0bmxuUE9G?=
 =?utf-8?B?Y0lPWEljNksrUGZaeGNReVM1VXJWcjQvdEx0a0orWEJxSFVwQ2FJYXY2T0NW?=
 =?utf-8?B?akhlcUVxbmtQWTMwaG9FQjN4NzQ4RkFnekZOM0JkbGY3dHIwUXM5UTBnSWR6?=
 =?utf-8?B?Q0ZIcVVINzdaWFZjUjNpb2JoRHRFSzFTR0txdEhHWEQ3SXBwSTZrT29SQTB1?=
 =?utf-8?B?QVZUNmF6L3dMUlhPTWh0VTJIVmIzOHZLbWJoL01NbzhHczBjV20xNmtPbVFU?=
 =?utf-8?B?UnhnTVZWRHdtNWV4bWJiTVlPcjhvWlY1cXpDc1ZVT05DQnpuMjFGY1VjZm1R?=
 =?utf-8?B?VzJnZWVjVW9iN3d6Z0xObGVaZHg1blptUGNRUTI1WkNVN1JER29jbFdURlR3?=
 =?utf-8?B?YWtsT084K0dBQUYyUjk4VGMwQWJRTnVIR0xteFpMbGhMTXJ4dzJQbnBSWlBH?=
 =?utf-8?B?a0YzS3hrWkE5TEpLL2ZpbjBHVWZ4cHBNVnV4NEZXREdYYjk2VFAxaHdoV1NY?=
 =?utf-8?B?OGtuSEMxV0Frd05ZNXpxamdkYU0zNFRoVCtOOHhqWXpXZDROZWxUNkIyaE8y?=
 =?utf-8?B?dnAzM29GQmFRUUtnYXpnWGxFeS9QV2pkUmREYmdzczFDWU95Y3VDcW1kczJQ?=
 =?utf-8?B?QlV2VVZTMEFDeEdSb0FwZHBqTEQyeFZnY2Z5YXBLR0Fic3NLUXA2T0NIa1lv?=
 =?utf-8?B?NktjSmtCcDlGZDR5UU0vbXo0cXJFR2o2a1UyU0hPZkRqbWF2UDdLWlBrMXZx?=
 =?utf-8?B?dE9OVkZwa2JvZVd2NnN2TVViTXczQTF3V21ZTm9CRlBDQkpVcUN6bEtXY2dq?=
 =?utf-8?B?S3BjZGNkck1lVUl4bE9LY0RoUE0zVzFyZ3hyZ0pycFVIeTRTbkd1Vk1qSTFZ?=
 =?utf-8?B?RHRHSWNUM2hndjZQaGM5WGZmT2huSCtOQjA3Z1l2dDMxSUcxUHo1M0M2OGhk?=
 =?utf-8?B?RzIwSFNLQXF4RGRZSkRJbU1WOVZ6YzJ3S3BvNnFYY3VzUk1jWFlzL2wrZUFM?=
 =?utf-8?B?Z05KalJxK256MlgzQWhVVXJEM2Z4SmlQYWZHK0IrazlHdi9NT1lHY2hQVUx3?=
 =?utf-8?B?VjdSVHAzbW9UWmRyZ0hickNCbDJMZVEzdUdOQkpVOW53UjQ1S1ZYTTBNNUFC?=
 =?utf-8?B?NzMrQnVVWUh2UGFzbU1tcFRramU5SS9HMGxKSDhiL0c1bDBydVFSN0JiNTJB?=
 =?utf-8?B?OFNwSXNONlY2MTFxbDZaZXlQTTM2dTRBbjJkT1NpZ3Z3RGZ4MXRoWDlXaHV5?=
 =?utf-8?B?c3Q4S2ZhZlhIYWtaU0FtRGRYOWk1ZU5CemYxMFRCR1JOanpiUDNqY3pTODls?=
 =?utf-8?B?dFkzdWZOZFBQaHMwemZSd211bHVNSWZFZ2hMZ2x5MHVSSXR2SXcrZmI1VTBo?=
 =?utf-8?B?eXF1SjNjSXI5U2FGblJhaGZWR1NHUXVPdTlpYkZyZTI1b0dGVnZvNldyTllX?=
 =?utf-8?B?eDNiT2RXWUt5dmg3Kys4ME5CZHhjNGVKZmdZNkwxMS9NS3ZEeVpleWFsMnFO?=
 =?utf-8?B?WlRXRTBDdWxlNzI5WW1kTWI2ZXRva2pyREZ2a2lPKzlwRVcydjd5MjNXM2lu?=
 =?utf-8?B?Z0pFWlREQXh5SE1pVXdXYzRkVThFWHlJYjFaV1ZUc2M1NXFQSDBya3d4bW1F?=
 =?utf-8?B?Y1IxaGJnV20vMDcvS3crNEFKVElmQWszbWs1K0FhQS9RVHNLNnh4K3hybDkw?=
 =?utf-8?B?UEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c45d5278-42f9-4b7a-1ee2-08dcc099606c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 21:53:36.4399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WtRG8pekzJkxnVHuXY2fwJuyYnQUNDw+3lyyQN5o+ZxV6ZOHANcU3fpUUGkjd6cH4w6Db4Yu8MaZaRfTwJdxP0VKb0cUVQ21FEojRr1YcZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4996
X-OriginatorOrg: intel.com



On 8/19/2024 11:45 AM, Jacob Keller wrote:
> 
> 
> On 8/18/2024 6:29 AM, Vladimir Oltean wrote:
>> Hi Jake,
>>
>> On Fri, Aug 16, 2024 at 04:37:22PM -0700, Jacob Keller wrote:
>>> I'm honestly not sure what the right solution here is, because the way
>>> LITTLE_ENDIAN and LSW32_IS_FIRST work they effectively *require*
>>> word-aligned sizes. If we use a word-aligned size, then they both make
>>> sense, but my hardware buffer isn't word aligned. I can cheat, and just
>>> make sure I never use bits that access the invalid parts of the buffer..
>>> but that seems like the wrong solution... A larger size would break
>>> normal Big endian ordering without quirks...
>>
>> It is a use case that I would like to support. Thanks for having the
>> patience to explain the issue to me.
>>
> 
> Great, thank!
> 
>>> Really, what my hardware buffer wants is to map the lowest byte of the
>>> data to the lowest byte of the buffer. This is what i would consider
>>> traditionally little endian ordering.
>>>
>>> This also happens to be is equivalent to LSW32_IS_FIRST and
>>> LITTLE_ENDIAN when sizes are multiples of 4.
>>
>> Yes, "traditionally little endian" would indeed translate into
>> QUIRK_LSW32_IS_FIRST | QUIRK_LITTLE_ENDIAN. Your use of the API seems
>> correct. I did need that further distinction between "little endian
>> within a group of 4 bytes" and "little endian among groups of 4 bytes"
>> because the NXP SJA1105 memory layout is weird like that, and is
>> "little endian" in one way but not in another. Anyway..
> 
> 
> Yea, I figured the distinction was based on real hardware.
> 
>>
>> I've attached 2 patches which hopefully make the API usable for your
>> driver. I've tested them locally and did not notice issues.
> 
> I'll check these out and get back to you!
> 
> Thanks,
> Jake
> 

The patches work for my use-case! I also think it might be helpful to
add some Kunit tests to cover the packing and unpacking, which I
wouldn't mind trying to do.

If/when you send the patches, feel free to add:

Tested-by: Jacob Keller <jacob.e.keller@intel.com>

Alternatively, I could send them as part of the series where I implement
the changes to use lib/packing in the ice driver.

Thanks,
Jake

