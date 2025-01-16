Return-Path: <netdev+bounces-158843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E18A137EE
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 11:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B77E16703E
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 10:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF311DDC1E;
	Thu, 16 Jan 2025 10:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hiRzWuOn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186B31DB951
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 10:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737023476; cv=fail; b=M+zEb1dkYsK8xmF5eBfFtLABDk1TSheG6cRMDOKW+fCjLyNHzhMVP7n1rZIVhQ+omTN/MxOpqjNqWJZJg+6kqzYNbj9PRupnJJ93tUsFshdyGZB6gUBg/mGFpr0fM6lndFgyhk++ZmH82MLjyPRevzci0yR4LHJWMO8/XLCsUaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737023476; c=relaxed/simple;
	bh=7mGAzMQuUgKUr+VoUqwONkdcm74bHbfN0BNxyDaAjsg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GVrYthckaSK2+nRlGxAPcX/jSYHQJ0oTZ8fJRhaC5HtBgC0eaJMV7p01j1Fw5lYv2bBpejpTxSOlR0mJgE0u2iCveLWRvkBhtNCrybHjH2gg/sgwAyYAc6T8dV8Cwb1ZhFeS3qr2kQwODGgcuW/PHdArfFoJ8IFaxO92Wxdd7d4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hiRzWuOn; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737023474; x=1768559474;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7mGAzMQuUgKUr+VoUqwONkdcm74bHbfN0BNxyDaAjsg=;
  b=hiRzWuOnM2wA3rFMh11pMEadrx6m49iF3ekwH9gze3oG7cWfCEbseuXZ
   effwqrTdxlEa4901AMlOdQHf98lu0rNo8Bx/GnCruG6jSZTRv6gr8wcM9
   U662WrW3u+tHsmN88RldYtZnPGMGS02TfVE82DV87I1DEO7QfNNxZ5yZH
   IsabNg9aGkJHsPsRpS1vm9bOnMlUCmXI6xm20ea9xTyC86CC3S5dGkDkz
   p8yK0ISaOGhgiqM2AEAB4kdRxon2LgQ41oSA/X32xWQYt8D9snYrabVGA
   HlV9DAWJ0AiBf9REA2K4FSSzEq5xdYJf37SMpJV1hju+OGZmcEAOnyBBa
   Q==;
X-CSE-ConnectionGUID: KARTOebsQ5azCAW0Rob6Eg==
X-CSE-MsgGUID: LJWrmANmTL+7yfrNgYvW/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="37557140"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="37557140"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 02:31:12 -0800
X-CSE-ConnectionGUID: c/h/bccLSCSHkVFmNYKmNA==
X-CSE-MsgGUID: PxmP7iEjSfSsOfr/BEZ9eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="136314672"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jan 2025 02:31:12 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 16 Jan 2025 02:31:11 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 16 Jan 2025 02:31:11 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 16 Jan 2025 02:31:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rwcpSTzCfQVHyngO0gbjLkXFXaAUrVc91LP/SilNCojf2UVXXiUmi1raw+lfZPDm+vT5yZuDeDUyCbfTyje5qT0PM7dar29YZL1ZwJvsnNn4nFlvbFZ06qr03U+Bw0iLYdnmkxLNhQ0GsDNia1y1WpcBrHtsXg6tTkVD10x/vBJmIDDNEs+DOPweWRBUixB6oYd5uYWmlPbQCF0ISI+B0pt41A6xT22EhBFY8+iPQuPv/FhwosarEl6AeLX/bp+de1UNH5CDMJxaMoKHZsRiClmToHuPiI2KwMmnWmgZlC53LcI7ysRVn4J4zDC/ZuLdJS7/Vi//nvtiL3XPzrpO6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fM4DJHXAP7uayHzVTUN3KXSyLf3ylGhrTZHnNJYQcVI=;
 b=LBs3l2v9Mb4Z5IDeMJ5X4bnOriH5dzVaygdVFnLwnNQKUR8SNirw3bEDnWGl+DhJNYkFyAngjIlZpY6PKY5MJZNlTZlmyxscyoAb30lNLprlAC1+MXoqN3iwf3m9xO2qJrjtHJnIe1+yVMJyY5H5TH4bacZW8kcgDEmlovOT6S/zafWCns1HuLWwypTk+ykOeoNwA59EMLa4CIlc1j8GdO7xAtVrvAJ9tjiDXyFCw9vl2oRo/fu33M/CSNKEUL2/ZL7HeNjEaZRyTV7RdxLQSDnHnOx9WrtpioxfXwZ80Jyx7KRUaBBoh7eR0M3AKvtW/ziaC/sr5uL8y/Dhlt1ofA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH7PR11MB6554.namprd11.prod.outlook.com (2603:10b6:510:1a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Thu, 16 Jan
 2025 10:30:28 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 10:30:28 +0000
Message-ID: <0cf7fbc3-acc3-4178-bc3b-bd35cde1cafb@intel.com>
Date: Thu, 16 Jan 2025 11:30:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/14] net-next/yunsilicon: Enable CMDQ
To: Xin Tian <tianx@yunsilicon.com>
CC: <leon@kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>,
	<jeff.johnson@oss.qualcomm.com>, <weihg@yunsilicon.com>,
	<wanry@yunsilicon.com>, <netdev@vger.kernel.org>
References: <20250115102242.3541496-1-tianx@yunsilicon.com>
 <20250115102245.3541496-3-tianx@yunsilicon.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250115102245.3541496-3-tianx@yunsilicon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0181.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::14) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH7PR11MB6554:EE_
X-MS-Office365-Filtering-Correlation-Id: 46fc11c3-0c92-47cf-fd33-08dd3618cb92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TDVQRHhWd2NCQUQvMzNsMXdvdmQzMHU5UkRkalZvYUJWSUxNVDVzbkZHYys0?=
 =?utf-8?B?NEM3OVM5WFVIWmMrcURMOGt2U2xhSUovN0I1V3RMT2FGVVFIYTVBVGtUS3JU?=
 =?utf-8?B?N2cwS3hNVzk3Q2VFREZkSnZlUHFvbThuaGJHWTN5c2UwK2ovOXB1dVlMVzdN?=
 =?utf-8?B?WXZLakR4VDVLQktSdHppOGRqeDZDVjZTVlA4VVRYOUNkcXdkOXRpMTVyN2hj?=
 =?utf-8?B?L0tIREZKMUI5b1B5QVJ5aVNvanVtWm01TU9RRkxKN3lOQVlueHlCcHhUWGRp?=
 =?utf-8?B?UG1OQ3p4LzcyME1PVVJqSlVUMVpHSmd2NGpNeW5XcHUxcnlBTG9MbDRiVXAv?=
 =?utf-8?B?UDlMcEtmb2ZLcW9kelFQRmVnTlo2V2VsOTF2OU9Xa2ZSM3ViOXQ3VCtXS1RG?=
 =?utf-8?B?T21FMW1QNjZhbjdLQ1ZzQ0FpRzR1QzZieGN4RWw0SklUaVNVL1NRa0NXa1VP?=
 =?utf-8?B?NnhhUHYrcHlsNjlSZWk4YTdSSUk3ZFM2cXJ2NUhVQmljT0NDQ2NZWnVrcjBs?=
 =?utf-8?B?UFVaak41NmZvditSWFdxdU1tL0V4dTJWeXJyUnRPdEhEKzdmbGNibm9ja20x?=
 =?utf-8?B?eEZNVGdwUlIrY1lVbDRrY2djeUw0SnFvaHUxU0kyamlXU0QzQmVrT2FHSjh1?=
 =?utf-8?B?aVZyNzdQUlFKWjVqZ2RWU1d4YTdsMTRKbDZOa3dYYU5OZGFRZTR4YnlQSExX?=
 =?utf-8?B?cDE3RVRuWXNJL3B5bEgzWmE1cERKTjFoZzNrSC9ySjNMMFIrVDA0L2pWMUhy?=
 =?utf-8?B?VnlwS0FoOXp1cEZXclJXdDRVNFlocUM2TDFiTFRZZEhtdGhNa1hGTE9HdGpV?=
 =?utf-8?B?ZHlsREdEdWswUVNPY21ZUUZ6MExkd3Znb3RZWmFoTmJBclVhYURNU08vMjhx?=
 =?utf-8?B?c2VGaVc1Z2JyM21IMm50RjR0aDNtSm1ra0piZWRzdzFzMGM5d3ZMVEoyYXN5?=
 =?utf-8?B?U3F2d3IxVExaS1RqU2E3a245OVNLeU5WamEySzJJMDFCUVMzc0lNOTQ2QTNu?=
 =?utf-8?B?bExTZFdXVEx0Z0lDcndXeEJIYy9XSFFOM2pnSXU0QXJ1MzdYRDZmWUw5aUNC?=
 =?utf-8?B?cVJxUE9iWmdsQmZ3SEpRdnhRQ3p6ekl4enV0Z3VHZXdMczNGT3NnODFjbk0v?=
 =?utf-8?B?VWYwQjFDTFlXVUZ1RmZ5VDQvT0Nyc2JheXN0UUpaM2cwRzRPeVdEVE8vZzhR?=
 =?utf-8?B?WWJQS3NxZzlzVEpSem5VOXZ4Y01PbDM0am5yYTlLUjEwZVFwOXVPOWtJc0dy?=
 =?utf-8?B?YkNKZHRNRG5kTXdMeXZray9Pcnp0SUdLT29paGkySmZwdmdZRWdkZFpLcHlq?=
 =?utf-8?B?dmlPUWRtVnQ0dERvYlJtSW05QUpBM2lHTTdCdUN2M3A3V2VqZVBEWnR5eG50?=
 =?utf-8?B?UzhRcC9XdVIreUpyV1BVbHlOVzZlSDBPMEtYd3hET3VmQ0hOMThRSm9WK3NC?=
 =?utf-8?B?blNiZlRseVByQm1lUGdaaEJPczZoZkRDZWc1ODZkMmJkdW5ZbnMzYUxOUmdr?=
 =?utf-8?B?cFVhVW8wYStGcXBvUlpaUm0wZjdDUTNmb3pVbGYwK1VleUdEeE9ZMGNveDNE?=
 =?utf-8?B?NGNlRjBsZFQ3N0ozMVBPWWY4YW9PK3d3U1NjQlZaYVVsdWpDc2xkRzBYRk10?=
 =?utf-8?B?L3IvNU1XVlBVeDlhUW9IM245QnZ5SDJpOGEzQkUvb3JTODBZL0NncGgyMWVH?=
 =?utf-8?B?SHBUQjVnd3liR2w5K3p5eWRhZU9yYk5pZ0VuVVV5a3hJYllVWlQ0d1VRZ2Vo?=
 =?utf-8?B?UGlNYTNGZVBiVjBTQUN5b3BIakI1NllBNEpZTzVYL2JWcURCcUVSb20vZk8z?=
 =?utf-8?B?M0dRMGtNNHAxek1UTUFsaHhIUGpMbGQ3Rk9raVZZSjBLR1RWajRTWDlRRTgv?=
 =?utf-8?Q?MINPVHcym2bw+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGpUTWZnT0hwV21waHZIYytGdnZoM0ZPRHcwQW5XMVljT0c0NXZqRDZjcWJx?=
 =?utf-8?B?ZTV1cUJKdG9JY1lSMmdWczBkTmp1bDlPdEdxcncycHVuMVgzWEdNWjVERTc5?=
 =?utf-8?B?OTJTRURnZmozR2NBc1FRUDZUbkc4VzZEaUpJYWsxUEdjN1I1ZUlFcVFnVzdj?=
 =?utf-8?B?NXpIc1ZWZEFlekhYNnVYd2tneEU5RTZ1RmRSVlpNQkJUMTI0T1JxdnJiOWx2?=
 =?utf-8?B?ekJ2NjdxcFg2aktMVFlIc0s3dGl0TjlXNEhrTDBHdloyeHdjb2JaMnVrNG1P?=
 =?utf-8?B?cFh0UVNTcWt6dzhyaFlFeDJpREhOZTY5OTlSVTR2TlljekViaFdiNnE4Mlh2?=
 =?utf-8?B?MS9Sdld3Z2RuWlpkQmlQYnFLSXFhL3h3bGwwV3Iwcjk2M3gxNVVmTlFKRjR6?=
 =?utf-8?B?RC9CeDdZdXE5djRsZ2srTytUNmRleVBrSElYSkQyNFlncXh5Vm4wS0hDdTJp?=
 =?utf-8?B?NmtCU29kOFE0UEY2OCtpaUp2WkRhMTBqZDgzWWxybDhNN2ZGV0IwVERJZEZs?=
 =?utf-8?B?c2V2cTR2Vng2dUtCRmpPWGx5ZzgxdzZDeEQ1a1JscWVjMnkrdHBjRGdZM3Jq?=
 =?utf-8?B?OUt0eDZOUFRZd2p2SzBKbk1RVUhsWVRsVHBDaWlCeWFlZTEvMFUrN1NIZmN3?=
 =?utf-8?B?R0dSM29FMVJ3cHFHbXZVeHdrVGVOYXlpakx4aFd1Um9iWUIvekprdGRoK2d1?=
 =?utf-8?B?VWhuUTNhWldrcHRGcWJUZk5Nck1Nd2VzL1JUc043ZWM0dkhXY1Uyb1Zra0lG?=
 =?utf-8?B?ZnhjVi9TUEVkYWJvbnpPdWFSYkN2U2tIdDIvUnJQMUpPMU0wM1VJdWd4MjRa?=
 =?utf-8?B?dkNHc2hNSEJmWGszUldZd1N6RUhZdWRySy9zV0FUaUpNTEpPak9EL09pQmhP?=
 =?utf-8?B?dlhMRnl2VElMRzhpUXpQaXJmc3BuUldicVoxVnNUMlloMmZleFNxMm05cmtv?=
 =?utf-8?B?VVJSQ3FHbkMvNTBzaUMrenB4VG82UkFwek9YYjBSbnBWcTRVODYzQ2RXeU5S?=
 =?utf-8?B?RS83U2ZNVk1uMkJRcXExZFpUV2k1YTEyMjFSWTVjWW5yNTNrU3NHSUJCb3p5?=
 =?utf-8?B?bTh1WDVjd3R6YndXRSttMzRHZWxraUNSVktJNDZwR1AvSWwvM3JHR0NpbDA2?=
 =?utf-8?B?cGt2cXQ3Tnc5M1k5K05TV0NRbzhmOVFmdXVZOWFTRHdzVHdEYlptUVV1ZVk3?=
 =?utf-8?B?VFRTWHY2K2xyWkY4TVphY1JXbzBEbXpVaWp2UklIQ2daZzRJMzNrakxLaUZ2?=
 =?utf-8?B?YXdiRG56NFMvdGloOXJ5YTZZaHBPTENReTR4bTRyZWYyUWNSOWNEZVExaGRN?=
 =?utf-8?B?dTRsQ3c0TThpL05DOWcyZVNTTk4xMmpyeFhvcGMrT0w4ZkdHVEppbnFJOGp0?=
 =?utf-8?B?d3N0WTJOV1JYNVVEU255citBV0l5RXlUV3pjUXIvejdEQ0R2d0g2dW9FZisz?=
 =?utf-8?B?M1VTWThJU0pBRi96NlY4YUMxakZlemExeGkzL25UVHJIZFE3Tk9xcGNVbkdu?=
 =?utf-8?B?ZEhmNkdHMGdySkdURzNES3FTRE1lNFg0ekZPL0VvQnNyM1U5NmVFQXVxTTRD?=
 =?utf-8?B?QVNrVURJZ011NTNKclMvSFh1VG11STJyN0tpMEcwNTZXcmxsY1YyNm1RVjZV?=
 =?utf-8?B?SjQzRUt3ZWt0aWZXZi9KaHVUZHBDYWNEajQ0NmV5UkN1NGI4Qjk2eUJ6dGxu?=
 =?utf-8?B?b0ljeTVxVWlETnd0Z2VWSHRWS2NuMFN4TU5hUGNrQ0NVMFhTMi9wa3ZQb1Vq?=
 =?utf-8?B?M0hyT0JTMXhtQ0ZhbExWbElIeVF1ZVJYbExBbHZ0VnRSSmU5Y2RpUUZMMGQy?=
 =?utf-8?B?dkxHK2RJRDVrMy9IWTdjcE44Z3pvSE53b3hJbmhwNFhQWnFJZzZZUk5EUHA1?=
 =?utf-8?B?NmJtcGU0MzF2d0paa2lqM1AySW1VOEdSbHZjeGhoOFU0T0xZK1VIcEttNFY2?=
 =?utf-8?B?YVdkU2tKdzMvbWc4cnRRdnNBU09KRDgzTWRzWW5wcTJLQ1VGT2cweFZZemRn?=
 =?utf-8?B?c29tT0lLWlBQZWVWMDJubHR6SFNuTlA1d0xQc2wzQmpMblJKNmxnWVFOQUM5?=
 =?utf-8?B?cTl2VXBYdVkrVDRnVnl2RmxpNnkyWUpWWEpzYVZtSGtHeUN5d1NtanFTZVdu?=
 =?utf-8?B?aWpDWUV6bktYa3ZiRkwrTTJGRTdnK2o3M1VldVNmNmRHSE5nZG1lUXdxYjVX?=
 =?utf-8?B?NHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46fc11c3-0c92-47cf-fd33-08dd3618cb92
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 10:30:28.0034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DKtOGs82zQ5z22pvnfGtEzti0R9kCfsc1AZMnKBejbSk1phsFYrfTe2CELxAj7KVDZMLeNp95edHaE7mb26ZE8xoUOzmkMDV4fAxW2axQ4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6554
X-OriginatorOrg: intel.com

On 1/15/25 11:22, Xin Tian wrote:
> Enable cmd queue to support driver-firmware communication.
> Hardware control will be performed through cmdq mostly.
> 

I didn't checked, but plese don't include anything that would not
be used at the end of the series. IOW: no dead code.

 > +	XSC_HW_THIRD_FEATURE			= BIT(2),
really? :D

[..]


> +	__be64		complete_reg;
> +	__be64		event_db;
> +	__be32		qp_rate_limit_min;
> +	__be32		qp_rate_limit_max;
> +	struct xsc_fw_version  fw_ver;
> +	u8	lag_logic_port_ofst;
> +};
> +
> +struct xsc_cmd_query_hca_cap_mbox_in {
> +	struct xsc_inbox_hdr	hdr;
> +	__be16			cpu_num;
> +	u8			rsvd[6];
> +};
> +
> +struct xsc_cmd_query_hca_cap_mbox_out {
> +	struct xsc_outbox_hdr	hdr;
> +	u8			rsvd0[8];
> +	struct xsc_hca_cap	hca_cap;
> +};
> +
> +struct xsc_query_vport_state_out {
> +	struct xsc_outbox_hdr	hdr;

this is BE

> +	u8			admin_state:4;
> +	u8			state:4;
> +};
> +
> +struct xsc_query_vport_state_in {
> +	struct xsc_inbox_hdr	hdr;

this is BE

> +	u32			other_vport:1;
> +	u32			vport_number:16;
> +	u32			rsvd0:15;

and this is CPU order, why?

> +};
> +
> +enum {
> +	XSC_CMD_EVENT_RESP_CHANGE_LINK		= BIT(0),
> +	XSC_CMD_EVENT_RESP_TEMP_WARN		= BIT(1),
> +	XSC_CMD_EVENT_RESP_OVER_TEMP_PROTECTION	= BIT(2)

(always add comma at the end, unless the entry is supposed
to be last forever)

> +};
> +
> +struct xsc_event_resp {
> +	u8			resp_cmd_type;
> +};
> +
> +struct xsc_event_query_type_mbox_in {
> +	struct xsc_inbox_hdr	hdr;
> +	u8			rsvd[2];
> +};
> +
> +struct xsc_event_query_type_mbox_out {
> +	struct xsc_outbox_hdr	hdr;
> +	struct xsc_event_resp	ctx;
> +};
> +
> +struct xsc_modify_raw_qp_request {
> +	u16		qpn;

hard to tell why you have switched from BE to CPU order
at this point

> +	u16		lag_id;
> +	u16		func_id;
> +	u8		dma_direct;
> +	u8		prio;
> +	u8		qp_out_port;
> +	u8		rsvd[7];
> +};
> +
> +struct xsc_modify_raw_qp_mbox_in {
> +	struct xsc_inbox_hdr	hdr;
> +	u8			pcie_no;
> +	u8			rsvd[7];
> +	struct xsc_modify_raw_qp_request	req;
> +};
> +
> +struct xsc_modify_raw_qp_mbox_out {
> +	struct xsc_outbox_hdr	hdr;
> +	u8			rsvd[8];
> +};
> +
> +struct xsc_set_mtu_mbox_in {
> +	struct xsc_inbox_hdr	hdr;
> +	__be16			mtu;
> +	__be16			rx_buf_sz_min;
> +	u8			mac_port;
> +	u8			rsvd;
> +};
> +
> +struct xsc_set_mtu_mbox_out {
> +	struct xsc_outbox_hdr	hdr;
> +};
> +
> +struct xsc_query_eth_mac_mbox_in {
> +	struct xsc_inbox_hdr	hdr;
> +	u8			index;
> +};
> +
> +struct xsc_query_eth_mac_mbox_out {
> +	struct xsc_outbox_hdr	hdr;
> +	u8			mac[6];

ETH_ALEN

> +};
> +
> +enum {
> +	XSC_TBM_CAP_HASH_PPH = 0,
> +	XSC_TBM_CAP_RSS,
> +	XSC_TBM_CAP_PP_BYPASS,
> +	XSC_TBM_CAP_PCT_DROP_CONFIG,
> +};
> +
> +struct xsc_nic_attr {
> +	__be16	caps;
> +	__be16	caps_mask;
> +	u8	mac_addr[6];
> +};
> +
> +struct xsc_rss_attr {
> +	u8	rss_en;
> +	u8	hfunc;
> +	__be16	rqn_base;
> +	__be16	rqn_num;
> +	__be32	hash_tmpl;
> +};
> +
> +struct xsc_cmd_enable_nic_hca_mbox_in {
> +	struct xsc_inbox_hdr	hdr;
> +	struct xsc_nic_attr	nic;
> +	struct xsc_rss_attr	rss;
> +};
> +
> +struct xsc_cmd_enable_nic_hca_mbox_out {
> +	struct xsc_outbox_hdr	hdr;
> +	u8			rsvd0[2];
> +};
> +
> +struct xsc_nic_dis_attr {
> +	__be16	caps;
> +};
> +
> +struct xsc_cmd_disable_nic_hca_mbox_in {
> +	struct xsc_inbox_hdr		hdr;
> +	struct xsc_nic_dis_attr		nic;
> +};
> +
> +struct xsc_cmd_disable_nic_hca_mbox_out {
> +	struct xsc_outbox_hdr	hdr;
> +	u8			rsvd0[4];
> +};
> +
> +struct xsc_function_reset_mbox_in {
> +	struct xsc_inbox_hdr	hdr;
> +	__be16			glb_func_id;
> +	u8			rsvd[6];
> +};
> +
> +struct xsc_function_reset_mbox_out {
> +	struct xsc_outbox_hdr	hdr;
> +	u8			rsvd[8];
> +};
> +
> +struct xsc_cmd_query_guid_mbox_in {
> +	struct xsc_inbox_hdr	hdr;
> +	u8			rsvd[8];
> +};
> +
> +struct xsc_cmd_query_guid_mbox_out {
> +	struct xsc_outbox_hdr	hdr;
> +	__be64			guid;
> +};
> +
> +struct xsc_cmd_activate_hw_config_mbox_in {
> +	struct xsc_inbox_hdr	hdr;
> +	u8			rsvd[8];
> +};
> +
> +struct xsc_cmd_activate_hw_config_mbox_out {
> +	struct xsc_outbox_hdr	hdr;
> +	u8			rsvd[8];
> +};
> +
> +struct xsc_event_set_port_admin_status_mbox_in {
> +	struct xsc_inbox_hdr	hdr;
> +	u16			admin_status;

reapeating "admin" in the "admin" command seems redundant

[..]

> +struct xsc_cmd {
> +	struct xsc_cmd_reg reg;
> +	void	       *cmd_buf;
> +	void	       *cq_buf;
> +	dma_addr_t	dma;
> +	dma_addr_t	cq_dma;
> +	u16     cmd_pid;
> +	u16     cq_cid;
> +	u8      owner_bit;
> +	u8		cmdif_rev;
> +	u8		log_sz;
> +	u8		log_stride;
> +	int		max_reg_cmds;
> +	int		events;
> +	u32 __iomem    *vector;
> +
> +	spinlock_t	alloc_lock;	/* protect command queue allocations */
> +	spinlock_t	token_lock;	/* protect token allocations */
> +	spinlock_t	doorbell_lock;	/* protect cmdq req pid doorbell */
> +	u8		token;

you have a whole lock for token allocations, but then there is a field
named @token, what it does?

> +	unsigned long	bitmask;

again, this name is so generic, that only "data" is less generic
BTW see DECLARE_BITMAP()

> +	char		wq_name[XSC_CMD_WQ_MAX_NAME];
> +	struct workqueue_struct *wq;

sorry if I have already asked you, do you really need custom WQ instead
of just using one of the kernel ones?

> +	struct task_struct *cq_task;
> +	struct semaphore sem;

please write a documentation of how it is used

> +	int	mode;

you could just embed an enum here, same size

> +	struct xsc_cmd_work_ent *ent_arr[XSC_MAX_COMMANDS];
> +	struct dma_pool *pool;
> +	struct xsc_cmd_debug dbg;
> +	struct cmd_msg_cache cache;
> +	int checksum_disabled;
> +	struct xsc_cmd_stats stats[XSC_CMD_OP_MAX];
> +	unsigned int	irqn;
> +	u8	ownerbit_learned;
> +	u8	cmd_status;
> +};
> +
> +#endif
> diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
> index 2c4e8e731..3b4b77948 100644
> --- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
> +++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
> @@ -8,6 +8,7 @@
>   
>   #include <linux/kernel.h>

(sorry for commenting in the wrong patch)

you should avoid including kernel.h
(include what you use IWYU, kernel.h is a historic header
with much baggage, don't inclde if not strictly needed)

>   #include <linux/pci.h>

separate "header groups" by a blank line

> +#include "common/xsc_cmdq.h"
>   
>   #define XSC_PCI_VENDOR_ID		0x1f67
>   
> @@ -26,6 +27,11 @@
>   #define XSC_MV_HOST_VF_DEV_ID		0x1152
>   #define XSC_MV_SOC_PF_DEV_ID		0x1153
>   
> +#define REG_ADDR(dev, offset)						\

no need to put "\" so far to the right
remainder about xsc prefix

> +	(((dev)->bar) + ((offset) - 0xA0000000))
> +
> +#define REG_WIDTH_TO_STRIDE(width)	((width) / 8)
> +
>   struct xsc_dev_resource {
>   	struct mutex alloc_mutex;	/* protect buffer alocation according to numa node */
>   };
> @@ -35,6 +41,10 @@ enum xsc_pci_state {
>   	XSC_PCI_STATE_ENABLED,
>   };
>   
> +enum xsc_interface_state {
> +	XSC_INTERFACE_STATE_UP = BIT(0),
> +};
> +
>   struct xsc_core_device {
>   	struct pci_dev		*pdev;
>   	struct device		*device;
> @@ -44,6 +54,9 @@ struct xsc_core_device {
>   	void __iomem		*bar;
>   	int			bar_num;
>   
> +	struct xsc_cmd		cmd;
> +	u16			cmdq_ver;
> +
>   	struct mutex		pci_state_mutex;	/* protect pci_state */
>   	enum xsc_pci_state	pci_state;
>   	struct mutex		intf_state_mutex;	/* protect intf_state */
> diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_driver.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_driver.h
> new file mode 100644
> index 000000000..72b2df6c9
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_driver.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
> + * All rights reserved.
> + */
> +
> +#ifndef __XSC_DRIVER_H
> +#define __XSC_DRIVER_H
> +
> +#include "common/xsc_core.h"
> +#include "common/xsc_cmd.h"
> +
> +int xsc_cmd_init(struct xsc_core_device *xdev);
> +void xsc_cmd_cleanup(struct xsc_core_device *xdev);
> +void xsc_cmd_use_events(struct xsc_core_device *xdev);
> +void xsc_cmd_use_polling(struct xsc_core_device *xdev);
> +int xsc_cmd_err_handler(struct xsc_core_device *xdev);
> +void xsc_cmd_resp_handler(struct xsc_core_device *xdev);
> +int xsc_cmd_status_to_err(struct xsc_outbox_hdr *hdr);
> +int xsc_cmd_exec(struct xsc_core_device *xdev, void *in, int in_size, void *out,
> +		 int out_size);
> +int xsc_cmd_version_check(struct xsc_core_device *xdev);
> +const char *xsc_command_str(int command);
> +
> +#endif
> +
> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
> index 709270df8..5e0f0a205 100644
> --- a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
> +++ b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
> @@ -6,4 +6,4 @@ ccflags-y += -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
>   
>   obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc_pci.o
>   
> -xsc_pci-y := main.o
> +xsc_pci-y := main.o cmdq.o
> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/cmdq.c b/drivers/net/ethernet/yunsilicon/xsc/pci/cmdq.c
> new file mode 100644
> index 000000000..028970151
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/xsc/pci/cmdq.c
> @@ -0,0 +1,1555 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> +/*
> + * Copyright (c) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
> + * All rights reserved.
> + * Copyright (c) 2013-2016, Mellanox Technologies. All rights reserved.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>

nope, you are either a module-like or builtin-only, remove init.h

> +#include <linux/errno.h>
> +#include <linux/pci.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/random.h>
> +#include <linux/kthread.h>
> +#include <linux/io-mapping.h>
> +#include "common/xsc_driver.h"
> +#include "common/xsc_cmd.h"
> +#include "common/xsc_auto_hw.h"
> +#include "common/xsc_core.h"
> +
> +enum {
> +	CMD_IF_REV = 3,
> +};
> +
> +enum {
> +	CMD_MODE_POLLING,
> +	CMD_MODE_EVENTS
> +};
> +
> +enum {
> +	NUM_LONG_LISTS	  = 2,
> +	NUM_MED_LISTS	  = 64,
> +	LONG_LIST_SIZE	  = (2ULL * 1024 * 1024 * 1024 / PAGE_SIZE) * 8 + 16 +
> +				XSC_CMD_DATA_BLOCK_SIZE,
> +	MED_LIST_SIZE	  = 16 + XSC_CMD_DATA_BLOCK_SIZE,
> +};
> +
> +enum {
> +	XSC_CMD_DELIVERY_STAT_OK			= 0x0,
> +	XSC_CMD_DELIVERY_STAT_SIGNAT_ERR		= 0x1,
> +	XSC_CMD_DELIVERY_STAT_TOK_ERR			= 0x2,
> +	XSC_CMD_DELIVERY_STAT_BAD_BLK_NUM_ERR		= 0x3,
> +	XSC_CMD_DELIVERY_STAT_OUT_PTR_ALIGN_ERR	= 0x4,
> +	XSC_CMD_DELIVERY_STAT_IN_PTR_ALIGN_ERR		= 0x5,
> +	XSC_CMD_DELIVERY_STAT_FW_ERR			= 0x6,
> +	XSC_CMD_DELIVERY_STAT_IN_LENGTH_ERR		= 0x7,
> +	XSC_CMD_DELIVERY_STAT_OUT_LENGTH_ERR		= 0x8,
> +	XSC_CMD_DELIVERY_STAT_RES_FLD_NOT_CLR_ERR	= 0x9,
> +	XSC_CMD_DELIVERY_STAT_CMD_DESCR_ERR		= 0x10,
> +};
> +
> +static struct xsc_cmd_work_ent *alloc_cmd(struct xsc_cmd *cmd,
> +					  struct xsc_cmd_msg *in,
> +					  struct xsc_rsp_msg *out)
> +{
> +	struct xsc_cmd_work_ent *ent;
> +
> +	ent = kzalloc(sizeof(*ent), GFP_KERNEL);
> +	if (!ent)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ent->in		= in;
> +	ent->out	= out;
> +	ent->cmd	= cmd;
> +
> +	return ent;
> +}
> +
> +static u8 alloc_token(struct xsc_cmd *cmd)

remainted about xsc prefix in the names

> +{
> +	u8 token;
> +
> +	spin_lock(&cmd->token_lock);
> +	token = cmd->token++ % 255 + 1;

token==0 is wrong or reserved?

> +	spin_unlock(&cmd->token_lock);
> +
> +	return token;
> +}
> +
> +static int alloc_ent(struct xsc_cmd *cmd)
> +{
> +	unsigned long flags;
> +	int ret;
> +
> +	spin_lock_irqsave(&cmd->alloc_lock, flags);
> +	ret = find_first_bit(&cmd->bitmask, cmd->max_reg_cmds);
> +	if (ret < cmd->max_reg_cmds)
> +		clear_bit(ret, &cmd->bitmask);
> +	spin_unlock_irqrestore(&cmd->alloc_lock, flags);
> +
> +	return ret < cmd->max_reg_cmds ? ret : -ENOMEM;

ENOMEM is strictly for kmalloc() family failures, perhaps ENOSPC?

> +}
> +
> +static void free_ent(struct xsc_cmd *cmd, int idx)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&cmd->alloc_lock, flags);
> +	set_bit(idx, &cmd->bitmask);
> +	spin_unlock_irqrestore(&cmd->alloc_lock, flags);
> +}
> +
> +static struct xsc_cmd_layout *get_inst(struct xsc_cmd *cmd, int idx)
> +{
> +	return cmd->cmd_buf + (idx << cmd->log_stride);
> +}
> +
> +static struct xsc_rsp_layout *get_cq_inst(struct xsc_cmd *cmd, int idx)
> +{
> +	return cmd->cq_buf + (idx << cmd->log_stride);
> +}
> +
> +static u8 xor8_buf(void *buf, int len)

double check if there is already something like this in the kernel

> +{
> +	u8 *ptr = buf;
> +	u8 sum = 0;
> +	int i;
> +
> +	for (i = 0; i < len; i++)
> +		sum ^= ptr[i];
> +
> +	return sum;
> +}
> +
> +static int verify_block_sig(struct xsc_cmd_prot_block *block)
> +{
> +	if (xor8_buf(block->rsvd0, sizeof(*block) - sizeof(block->data) - 1) != 0xff)

you force rsvd0 to be 0xff? the usual approach is that reserved fields
are 0
if this is somethins that your FW/HW already has baked in, please add
a comment at this particular rsvd0 declaration

> +		return -EINVAL;
> +
> +	if (xor8_buf(block, sizeof(*block)) != 0xff)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static void calc_block_sig(struct xsc_cmd_prot_block *block, u8 token)
> +{
> +	block->token = token;
> +	block->ctrl_sig = ~xor8_buf(block->rsvd0, sizeof(*block) - sizeof(block->data) - 2);
> +	block->sig = ~xor8_buf(block, sizeof(*block) - 1);
> +}
> +
> +static void calc_chain_sig(struct xsc_cmd_mailbox *head, u8 token)
> +{
> +	struct xsc_cmd_mailbox *next = head;
> +
> +	while (next) {
> +		calc_block_sig(next->buf, token);
> +		next = next->next;
> +	}
> +}
> +
> +static void set_signature(struct xsc_cmd_work_ent *ent)
> +{
> +	ent->lay->sig = ~xor8_buf(ent->lay, sizeof(*ent->lay));
> +	calc_chain_sig(ent->in->next, ent->token);
> +	calc_chain_sig(ent->out->next, ent->token);
> +}
> +
> +static void free_cmd(struct xsc_cmd_work_ent *ent)

please move near the "alloc_cmd"
remainder about the xsc prefixes

[...]

> +
> +static void cmd_work_handler(struct work_struct *work)
> +{
> +	struct xsc_cmd_work_ent *ent = container_of(work, struct xsc_cmd_work_ent, work);
> +	struct xsc_cmd *cmd = ent->cmd;

reverse xmass tree violated

> +	struct xsc_core_device *xdev = container_of(cmd, struct xsc_core_device, cmd);

