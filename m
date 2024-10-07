Return-Path: <netdev+bounces-132909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B63DB993B6E
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 01:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7991B2838F5
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 23:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B41E18CBEC;
	Mon,  7 Oct 2024 23:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DvXzimco"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3834317E
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 23:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728345091; cv=fail; b=XRyCt2oTQKXn919Gl9w7SsPmWfHV5ycG4ceFELz/50hWoNdU3yrlFi/075oH8vmwXLRjVqegnw98u8Cnwhe8nor7Izg/f9AWDXYazISid+IVKOK4GdjmIQkAKgHdw1+kjJD4cKywFGaZKgT6uvJZzehXb4BH2xti2m8EcUz6bwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728345091; c=relaxed/simple;
	bh=RPqikCUSI2WbGPRgOuKbSotPiJX4g5qI60FBbcS3oEI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PI5Wo5U5WqUTwDL1Xbt1EoX33Yn7JoMldDkFDG1MaY3dXhv87Icg1MRY47T/JAiZlQ44TcAZAdSGOGS3vvgKP8f9z6h5UPlw/vr09mSAXqw/0sN+1D54WgloovR+OK9D+IxMkSKzcRz9EhoGwyUaWNR3uRxH2+R+Hd/EtXdjXnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DvXzimco; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728345090; x=1759881090;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RPqikCUSI2WbGPRgOuKbSotPiJX4g5qI60FBbcS3oEI=;
  b=DvXzimcoAbQC2Yaxzp8T44Z4aoGOVAg2IGRZByRpv2SKCPXYquTO0rVj
   NGFKczGeFMoKhvntxOLqZSq+0z4u8g8V0roruY/xkaUjnxrssM/zt7vjM
   rGN+hFhsYmD+WgCOU7vbuRDJIR+oFbYOuSBa3qiKWnehPPvY+/aF2kFxE
   inMBCmkDK0Ckz1HDR7eLgd0mGWMSOtXn27XByk6GPHKA/3yiAEXuxiXof
   +Z/yaShkUBkGJ6l6/7BgFQxzpZrU6QGyvuzcjdOo7szJw3YtrNgcoViMJ
   Vp5uKRgImcdGyWzxSRYy+whIcIlqmyg9L/RBNYaA/iTRYEW45XypOTN1V
   A==;
X-CSE-ConnectionGUID: wTbxo8tHRr+6tpmQlw/nMg==
X-CSE-MsgGUID: RsZ0g8oiR1WimfWFLDZ2SA==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27600817"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="27600817"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 16:51:29 -0700
X-CSE-ConnectionGUID: iqmX8Jx9T/mfWXvYyV0d2w==
X-CSE-MsgGUID: xZIpG2gQRD28+KPho7174A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="75593579"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Oct 2024 16:51:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 16:51:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 16:51:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 7 Oct 2024 16:51:28 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 7 Oct 2024 16:51:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ERaEb9TeKGdDQ8ZG5iNOhM8kJnt0CsonCmjc8h1AOO+WZMoX/V9ctniK5XUPO8Sb6K47+2o5A6LIgeY2M4wNh8mGYrgi833zzeY2M8LBQnEdJNWRhK7U60JwFTUKHQROT5HJ99z0Dkq0gHY2iS01Qx9U6a4yFwvhaNwebCBg/6xhFdpR6k3byk9uMazP20OtOemS1HNSseMbU87VCv2phbefMNLY5hrlqxk+Ai1MqdS0/E18luUVjpa8PrmZYaUONP2HQ255zJeBuJWKjG+7KXD4w+XKc1gufLQQquXA0ha31eaDKUkLgWnoac9MM+fS/VFx6e6/43qVjRGwfDAFcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxThc/bhADz/gbw/TnL1TeamfaIpimBVLrFQ/jJzLWg=;
 b=IcpCOBu1AS4w8cDYBHH4f584Zeg0JuTclB1oZMmNEXNQU/o2N4V9DEJ7fcwF42BnCbBPblTf8fDFqlbn9I4Ri8PNWWhbpVggnG4DzbxmUVhucfalKxCgfv1KeS36gnWkjVRxMxHxhXyE5CbeQ7FNuTiXSWkLlAfkIZDQTZAJuuzPGaFG1JUj9FpOZVFZG6qJ/9W0KbzUp9Ja61ln5gTUU+HI9Zn0BV3z8tXUVh/9PQT8EH4sTos2SNN8Ad216uG+hSJ5Ys0kS3k1P/f0F4UBcBEocvUuKtNZMS+aUDIi6ZnG5icm2A+OvLxlVPKajcTOyqHnaznha/J0VElF3gluzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH8PR11MB8257.namprd11.prod.outlook.com (2603:10b6:510:1c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Mon, 7 Oct
 2024 23:51:23 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 23:51:23 +0000
Message-ID: <a8f04d66-5ed5-42e1-9a5a-8cb097769410@intel.com>
Date: Mon, 7 Oct 2024 16:51:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/5] eth: fbnic: add RX packets timestamping
 support
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Vadim Fedorenko
	<vadfed@meta.com>, Jakub Kicinski <kuba@kernel.org>, David Ahern
	<dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
	<davem@davemloft.net>, Alexander Duyck <alexanderduyck@fb.com>
CC: <netdev@vger.kernel.org>, Richard Cochran <richardcochran@gmail.com>
References: <20241003123933.2589036-1-vadfed@meta.com>
 <20241003123933.2589036-4-vadfed@meta.com>
 <6015e3d3-e35b-4e6c-b6cf-3348e8b6d4f6@intel.com>
 <d6d91341-e278-4d3f-967e-3c45f7323878@linux.dev>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <d6d91341-e278-4d3f-967e-3c45f7323878@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0043.namprd17.prod.outlook.com
 (2603:10b6:a03:167::20) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH8PR11MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: a7babb1b-82e9-469f-aa30-08dce72af32e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SkM2UjN1UXdObVNKb1pPTFV2aC9yV091NWY5QVhtOXFQL3dKVWF6bW84SWxv?=
 =?utf-8?B?QXJ4bGVObDZjbUgvTzl4aU9GKzVSSDQ0K3VKZlg3bDlzdUJlZ3dpS1VGTXdZ?=
 =?utf-8?B?Q0FITzZGdUNHVUo5SVhyclVsZmVhbEw4bGttTGc4Uit6Ym9CUnBJWkZieWF1?=
 =?utf-8?B?eXVoWEFWTk1OaDV2TkFPWGRqb0J6UW1GbFZVMnZUWTZDZVBLcnNaUkdpb1VB?=
 =?utf-8?B?ZGpJOFR4d3pzU2xENGp6Z09BQXRrNlV5NytIV3FHTjFLa2pBMG8yUnVyVW5p?=
 =?utf-8?B?RjVwcXZYeUZBRkVBWVEvK3RJYzIweXdrelJuTFFYNzVjeGZxTlEvVXdpdXpH?=
 =?utf-8?B?dE9KVFQ3RHpWWUwvQ1BkWW10RnQxSzhicmRJVzc4Qk9CT1cvKzZpa2ZOblRK?=
 =?utf-8?B?eXIvZEg5ZTJ5WjRId3U4MHU2WC9CNStFenZ3SFJCRlFJaCswY3NURkpmTHpK?=
 =?utf-8?B?UG15aFVCWVVMY2ZaN3NxMHdCSTZCcHhmMERvT0dZMnVGMU1OdnRkMGdaM3Ix?=
 =?utf-8?B?eGhiOFpQQnBzQXVCd3hJaXJMNG1TWEN4N3NZV3Z0aXZZUTQrSzlKQU1IQ29r?=
 =?utf-8?B?OGlnM0NBU2J6K2ZkUENQU3AxYks5WTg1QUFJcGpRRTdDb0RobW1Zc1B1Tm1o?=
 =?utf-8?B?YTliMGhMQnN0QVVjWFJkMzFLZjkySUtXTVZkcjcxNDlIQ1k1T3YvbHdEQmh5?=
 =?utf-8?B?cDdIb0NDSnIzQTl4Y2hkTVduSWNWbDUwWG5tOU44OXNacmg1OWkzdlVOVlRs?=
 =?utf-8?B?a3lpWlRSNzJubFpCOUJiRXBVbzJtU0VkQktXUWd0YmF2YlRjTjh1T1VsUTA4?=
 =?utf-8?B?VmdpRWJFaDhmd2w3Rk14WEp4ZnFrZ1piN1BmVEtQcjhEMXJMSlI4WWs4U3FO?=
 =?utf-8?B?V003ZHlnY2VpNUFiWHFaWGNKRmZ0aWlBMGhScVVITnQ0eUs5bGl0cnVxb0lv?=
 =?utf-8?B?U1FWZk9iYUtxZktPcUU3K0dKbU5GekdQRlJyU2M3cnJTazBEWi9PaDZQSksr?=
 =?utf-8?B?MXJCMWYwSGpKNTFwWlpvVmdnNmp2NUZYcnVvVUpCbEphajAySTQ0V05wbmZ4?=
 =?utf-8?B?dnEzTWZrRGZyUkE3SXBtM0F2R0drL3JDdnBVeEpTVjlFZVhwdHZYWXArT1hH?=
 =?utf-8?B?cmxXaGdZVjczUDJpTzNIYnZUVVdyT3hoSHFhQ2pmcEM4NVpPVDFjSldRNnZ1?=
 =?utf-8?B?a0ZkMW9QcHRaNnpXWGg5YS9VcDRoaWpoZEJLcGRIa1dVSEpUS2ZzY1ZkRWdF?=
 =?utf-8?B?OFZsNUpSVnp3MmNxMHRoUGVFMmVOL1J6c1NsREdLcTRxQjlTSFUxR0p4Tk9s?=
 =?utf-8?B?bzc2WWs5TVE3UUc3YW1zMFlGQlI2Y3YzbEFobTNUU2l0anBWaDhJMUxSeVFv?=
 =?utf-8?B?RnlwaUpLVGx4ZkVJbTFmZUdrWGV0RFVwaHhSVG9iTlltcnZIRDlhZlZIa2du?=
 =?utf-8?B?ZHMydVZVbFBEdm5rSTBVS0FJZk1BclpaS3RkbHZ4c0p4S0VKR1VJZlQ4YVN3?=
 =?utf-8?B?OUppeXpoakNpZFpHNE40cmNXZ3NFTW03eDUrTXJvT1RpbEdjWlZhTVZQTEU2?=
 =?utf-8?B?S0Q5R0x5b3RrUmlaMEN1em9oWmJSS1BqaGluSGc2bzlSdXBKZjBndWFiVlVu?=
 =?utf-8?B?d1lvNUtIL2dXSjc4RDk5SlRIUVJJZUthNFhNc3RleitjdkNUUGhoaWx6K1dU?=
 =?utf-8?B?TjR4bUdLT05WUmNDUUcrQnpidVVqTjN1RDl3ZUtKMEJ0MFYra0RzL3N3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUw4SExZa2FSS0FYbVliSS9tdVZpK2dtTDVHREdMUnQ1eE51MHNzeXo5bm90?=
 =?utf-8?B?ajArbkNnYytBRm9UMnBJbGkvZlgzclE1amFUOWxrQ2FvMFcxSTJZMGR0bzZh?=
 =?utf-8?B?V2ZYVG9qZzZMaldjNWQzeTBHbk1MU1cyYXNwL3NjVC9sTWdDRnVtODVhTjN1?=
 =?utf-8?B?N3E0N3Y1OWkzYWpxNTdKVk1PYkNGbUpkZGVNdVpyK0VFM3FyQTdoRDV3TVUv?=
 =?utf-8?B?K016YVdIR0NOeVJTTHIxdkVpd0puaXQ5TkVQQ1dWZzJFUks3azJsaUdwRE9r?=
 =?utf-8?B?eWNjcWtrWGpQSW5UL2xldWFad2Q3anplSG5CZjB5NUNHVWhZaG1YTmUxMENU?=
 =?utf-8?B?aXRPZ01EU1hRZlVWa2M2SHJtdXphazMyMForVXJneGw1aG90cDJoYWQ3WmRV?=
 =?utf-8?B?cjNaK3NJciszM2JXOU4wTU4zRGkzdjQ0Y3VVK3FpOStLdkZGNDFYOWF5T1pm?=
 =?utf-8?B?UEpVQWZYOGZndHpPWDZVMVB3Zm00OGVTY2dWYjhQQjdDM0Y2bVBReHluN0Zh?=
 =?utf-8?B?elRmUnFTZTJDcm42VlBVQnZrdmhFaWZxRUllbVZyN3pqRmZMSDUxMzJXSi9w?=
 =?utf-8?B?ckV0UHdObWUxMFNmVGN1S2lleHE4d2hSZGpyTVg4N0tVSVpTK1FKV2NTanpj?=
 =?utf-8?B?ZzRHaWJyUG56ODFuY1kweVVlUEpGbGZ1cXlKaGs4SCtmaTBkQVZOUTRZdGxj?=
 =?utf-8?B?K3ZnSDE0RTh4dXFnSGhXQ0drejltaVVTVVJINnYyek8wKzhRbzJDSTFrODNs?=
 =?utf-8?B?ZjY2L2dBK2ZnUWI0RUcxb2E3MjhQZU1vTGNqdUxsOGFSWjRGRkNOZGg2ck13?=
 =?utf-8?B?RmVjdHZ5QWlBell4akhTQjRKR25XRC8xcmtrd0JRNFhuYVdRMFg0cXJSSVY5?=
 =?utf-8?B?TTFOc0RCSGlseEZjb3d4SzhzM1dmbmRFVklQMWNyN2tFU0xNMDBhUDFaSDhv?=
 =?utf-8?B?eEJJUDd0amN2Qk8xbXUzQ2tzWDBwZVdDN2ZJcm1ISXBwNkpKL2ExNnRJSzVN?=
 =?utf-8?B?UjNGT2FLR2lqbmloZk5nd0NoY2JHclNlWFkyQ3dDUjF1UXllTTRxaXY2c095?=
 =?utf-8?B?VnRGOXYxY3dyOHFYNzRLNTM3dFNEQ0d4cU43SmN0aU9Ka0ZQZXZCaHROdFhr?=
 =?utf-8?B?NVp6QlNsVlBqSk1vSmZtRHRYMjFkZ3VSdVRRR0hxcCtqbUdzK3pFekMvZVZU?=
 =?utf-8?B?SGdkYnBSV3ZNTHdaQkhQK056cEpFN0R3UEpSeEpFdnBxODlheDZqUmR1RkFN?=
 =?utf-8?B?VHlTUWxKbDhGNVViSDNyM1loTEF5d0l1cGVtZk05aWwvTGxwc1JmZjRLSlVE?=
 =?utf-8?B?dE54UFhTTy9SK2N5SmViLzM4MG82eS9aNzNJRFg3cGxsTkMrNm5maytvOXht?=
 =?utf-8?B?UDR3ejFmTjJxS1BzYzJ5YTZNQlA3UlZOUCtqeGlrK3FPWGUvZE51ZklFUVF1?=
 =?utf-8?B?RktKUzBDSTBJNWU2bVN6Qk80MWpQZDE0RUs4QmpZVVg4STRSWkJBVVZNQkx6?=
 =?utf-8?B?S0F2dGNkbE5NS1J1MWJsZnJMMlZSTG1uTFcyRHljY2s2K0xsUGlhMU5MUk9j?=
 =?utf-8?B?cG1WbUkreU8rYmdkRkphcTZPVUVhZXdod040a3JNTEpiYlFTcjZkV21GN01K?=
 =?utf-8?B?NkM4cHRUQ1ord1piYWN2VUdMTXArUS8wd0Rva2V0U3JjNjhpNndVdFVEQjMz?=
 =?utf-8?B?TTZMVWRQbVBzaDR6TmNtL3NhMEIvY0JXdkZGU3YvVUlxNXBFRDBNWkVGLyth?=
 =?utf-8?B?NGxBS1NoN1NKeGV3d0cyN2JRakdaQUxZSjcxdTcycXN2cEdJV1hDeW5nNmts?=
 =?utf-8?B?ek1Sc1NhMXFCNFRoRmpCWlZTZ1BiUjUvT2NSdkxJWVdtR0t4SjN0STFNc2ZU?=
 =?utf-8?B?TFZNcHhPcW94SE9tYmhHamRuSmVUSVkxUTFwTEF5c0NJdWJxUy9uQmJ5ckE3?=
 =?utf-8?B?blJvTzRVSzVnVVl5R3lEVm1BMHhuRFpYRnZPNE5NTFIrT0xDMHNPRS9HOGlB?=
 =?utf-8?B?WlFsbjVMOGlyZGFCSFA0TjZ0MjM5d0htdm1MMUUvYkxPQVpiVWd5Q2QyOEk0?=
 =?utf-8?B?clNvMzhPMWNLLzU3eEFDdGNtMHRLTGNRN01pKzZySjNjSGYyWk40MjRHT0g4?=
 =?utf-8?B?ckgxRG1mb3pDVWNlaDk0Y3FVUkZoWGluaE1sL0ExSDRtL09WTmNEWTlHRGlD?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7babb1b-82e9-469f-aa30-08dce72af32e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 23:51:23.5262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MmKsL9jJ5CnNe8B6m0m1Zb4ck54yWwTy1A6N9o9B6lUKuWuQ5DuUD4eAgr9BKXhpEwv4OEtJKnrrn4zf9w/4/8IroPMLuM6GlPdQSVSX2m8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8257
X-OriginatorOrg: intel.com



On 10/7/2024 3:26 AM, Vadim Fedorenko wrote:
> On 05/10/2024 00:18, Jacob Keller wrote:
>> Is there any benefit to implementing anything other than
>> HWTSTAMP_FILTER_ALL?
>>
>> Those are typically considered legacy with the primary reason being to
>> support hardware which does not support timestamping all frames.
>>
>> I suppose if you have measurement that supporting them is valuable (i.e.
>> because of performance impact on timestamping all frames?) it makes
>> sense to support. But otherwise I'm not sure its worth the extra complexity.
>>
>> Upgrading the filtering modes to HWTSTAMP_FILTER_ALL is acceptable and
>> is done by a few drivers.
> 
> Even though the hardware is able to timestamp TX packets at line rate,
> we would like to avoid having 2x times more interrupts for the cases
> when we don't need all packets to be timestamped. And as it mentioned
> in the comment, we don't have very precise HW filters, but we would like
> to avoid timestamping TCP packets when TCP is the most used one on the
> host.

Tx timestamps don't use the filters in the first place. The filter only
applies to Rx timestamps. You should only initiate a Tx timestamp when
requested, which will generally not be the case for TCP.

Are you saying that Rx timestamps generate interrupts?

