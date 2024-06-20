Return-Path: <netdev+bounces-105137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0B790FCBA
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 08:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C104CB23BB6
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 06:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE5A2BCF7;
	Thu, 20 Jun 2024 06:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="er6RLE4z"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C8B13AF9
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 06:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718865147; cv=fail; b=SDcus/I7VDdJNSRq80+IKL+sgfKonMLYMrl5jwCN7o54kxmELK/pNDr/gdGAJnqBuN6fq/Ok8RlP9ThNnNcERMIHixnLBydtADiSqrgdRxyGoi21JPl8yFOvKTq6LrgtJjN5X2a5EK4UIbveXUI4TvDo7Mn34DLL9oRnXFpHMmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718865147; c=relaxed/simple;
	bh=F4aB1bsVZoAnfljrRJAQO4VsTc9pzAtjlL6h6P/w6Ho=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E9M8M+tTefZiMwVXo6S1MpVleIUHwNzTgjlIREhx2WLFYPCFImqQs5K37gaYPKaYvHFvB/VbDTBq7s6h03WOtWvd0i1i4MPalODAu9NQ+rRt1enfaxao8E6rSEwvExb2j6gWxFZqiL+c7ha5qx0iaGlt4y4rnFKIWMpk4XsGHLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=er6RLE4z; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718865145; x=1750401145;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F4aB1bsVZoAnfljrRJAQO4VsTc9pzAtjlL6h6P/w6Ho=;
  b=er6RLE4zNX+VC5IxRCcLp2Owl1p70dEm8DhF2ZsqoaF5aGSdzSZIAyM1
   VfPMBNbrerh7Bx6iR7zKh4B5lKEBROCrYj3oLLPyrTjZFoF2RU8xdpSYz
   SToBarU1eM9RNrHrSj77EkKK6kHa/lp/VEFFeBDBkaPGAkZlZ0q/2g5oH
   AwGcAk4ml+OEicIpxR1hjBtfppcws4xg497K0QRrnqcX3plMV5A5z3hFF
   UKPB2oY9W+uiHVU3LqlT6+drB3c2A4HuE4iIzA5Lj/lyDswlI+JD3zyI8
   qdPIj9HDp2EOI2aHHxEescaYJxB5Kxas7M+xbfXXr0hjzz50IfCeC5GRe
   A==;
X-CSE-ConnectionGUID: 3dO1LDbxRSK6SGNVLda2TQ==
X-CSE-MsgGUID: Z907vzHhT/W88aGDqvMo+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15587628"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="15587628"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 23:32:25 -0700
X-CSE-ConnectionGUID: GbJus1w8T0CXWemV2Dzb/Q==
X-CSE-MsgGUID: oBnu8piZQDGXwUumeVoVWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="46590789"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jun 2024 23:32:24 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 23:32:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 23:32:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 19 Jun 2024 23:32:23 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 19 Jun 2024 23:32:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJuvY+PPKorbvsPOoliAOH82edBAspNMK9eXcusFrO5gvHHoP0Zf/fiCGL7UcsnRp4ByItSepRUDDvlbjM9SRkzm+P0ABiB8K/bwgnul0PR/Dv0YMHwuO09s+8MnZnWoNF9Y5ita9rcYhQMavGOHLeQtQG3zqMv/0OgOGdsle2tuFDdpBvBcXAz7GhQ9DzKPOvZpS77+SjB4nxmLX88GXGGXlmViEB22j4Tu77Rs/5tOBbwRyFrOixWJrFq4st8mDdtsebrIyBuTXgwMwjj/tVTNSzCNktp9ewgePFFEmR8UVgh3F5n4qCRmeByTI9VDxnm9slN3LDDvbbNqhVcuwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEwBFhnrNNyNDv9cVjTE6/BfKSNduKyGfJQ0Oxf/Tqg=;
 b=GlIaCBxzM6jb+O3O7QVP/HIzR67peRsIuUwg/O3z5UofoTclLHe01dNgHkzxN2QaMSYATGbnMUPHV8fDmS9WIEPc4lK+nDuWeRd1GSiPBIWwpXH6ypoufGsJEoYlh2GNJ8zn/wa3vig8ZHRDYkzOXbB7t6TvVI+PsZdCb5Bo1jlN7nH98rlbNOBPCjxA5Tuv6hlYSLxvYYjIdv+CquwZAiT0E7YMXpCC1NVTCLdlR8r5SfyBzjkhJubtbTA2bDQLFqazzqnygbtW7/EPuT8pAc2kQuc94Gt0EaesvbYE14EllsuzswsG/o4BRakPu5xJXwOcQY4jqRZHwQdOBqn20A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by LV8PR11MB8487.namprd11.prod.outlook.com (2603:10b6:408:1ed::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 06:32:15 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 06:32:15 +0000
Message-ID: <ca867437-1533-49d6-a25b-6058e2ee0635@intel.com>
Date: Thu, 20 Jun 2024 08:32:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 3/9] net: ethtool: record custom RSS contexts
 in the XArray
To: <edward.cree@amd.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <linux-net-drivers@amd.com>,
	<netdev@vger.kernel.org>, <habetsm.xilinx@gmail.com>,
	<sudheer.mogilappagari@intel.com>, <jdamato@fastly.com>, <mw@semihalf.com>,
	<linux@armlinux.org.uk>, <sgoutham@marvell.com>, <gakula@marvell.com>,
	<sbhatta@marvell.com>, <hkelam@marvell.com>, <saeedm@nvidia.com>,
	<leon@kernel.org>, <jacob.e.keller@intel.com>, <andrew@lunn.ch>,
	<ahmed.zaki@intel.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
References: <cover.1718862049.git.ecree.xilinx@gmail.com>
 <e5b4739cd6b2d3324b5c639fa9006f94fc03c255.1718862050.git.ecree.xilinx@gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <e5b4739cd6b2d3324b5c639fa9006f94fc03c255.1718862050.git.ecree.xilinx@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0168.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::23) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|LV8PR11MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: ebceda9a-7d3a-4dd8-e033-08dc90f2b9b8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|7416011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QU5hcnUzZGNtbVlEZTkzT3c4QjZzT2lXYm5VYWpubWZFbWF4ZllEeFRSTSth?=
 =?utf-8?B?N3QxWktrYTEybnk5MHBtQnczdFl0TTRKRlNoaDRmWHovTjIreTBxeHBqYUdY?=
 =?utf-8?B?ZXVRNFJ2RjFpYWpzL1UwWWMwTUZoTjBabnpJdjMzZlVIcm54MFBMYWlpRkpJ?=
 =?utf-8?B?ZDBZWEplQno0azhyRjhnSVZQNE1CVjRqSWxLdmVQSzhKeVYzREF2czFVc0lB?=
 =?utf-8?B?bTFWSm5pWjl3SE9vc29RY2RoVWdpMXZaM3ZIVE04V2JkeUk2RG90ZFUydHg1?=
 =?utf-8?B?NS9teGVheGJWdnRuZ2hqYnYreVZpUnJYRlo4RW1kREdOVGdjKzZOMUo3dDFk?=
 =?utf-8?B?c0RFNE1RL1I5VDRQYXQ3SHFXYzY0SU5qOUxPcDJqSlpLRWduTklBYmtJeHVK?=
 =?utf-8?B?KzBTSFRnOUpHUVV4N0doZ2gxWlg2Nk13aGF1NXE0ZnM4REdwNWpPZEEvdVRZ?=
 =?utf-8?B?dUpsTmh2WWk3MzZQRkVyWUgzeXRZU2czTDZQS3Rnbm9ON2NtWFVUb0ZlRW5B?=
 =?utf-8?B?NXk4bnl1L3VxTGpZTlFzbm9wam9mT3l6Z2VSOUoySk0va0ZPVnhvVDJCWW1K?=
 =?utf-8?B?aUVQcUtwR3JESG5TdFdtL0RkTmw5ZXdycnRJUGVVL2c1Wjd4NmcwY0FmZ2Jo?=
 =?utf-8?B?ZTV6VklIdk5VM2ZpMW90ZzJVcy95K2JEdU5DenVxMGRmQlhJbzRoMDdYczA3?=
 =?utf-8?B?dG9tbFdBdTFIbUVDQW1vL09pcytFaG5zOXFoYmRwbjZBSk9RSWM3ZDlGMWhX?=
 =?utf-8?B?NzBIYkJ1UGJVVmlXdlBMOW5wQ0d3YWJQM3ljUlBwTTAyZTd6bXN2cXZXTnlG?=
 =?utf-8?B?OHhhb1NvaFVvYkNMcEFocWs0K3pqd2V1SVZrNDl1azZxTkpVbnUzM0htOC8r?=
 =?utf-8?B?NFZGUGVlNDkzWjRZMUhQclhCQWtaK2xJMGFsenpCMEJiRlFTUVA4dnFBTjJV?=
 =?utf-8?B?ZjlQS25VcjN2ZkllaHRMYUtmWWh0Z2JvSFVwcHV4SGo2SXVJN1Z1VkMvT1dK?=
 =?utf-8?B?bjNhSG9vZDVQZXZhSHdTbk8vZndxU3p2ZDY5UENYWWhCSmJvNis0VXhETTFx?=
 =?utf-8?B?UjlkMmN1Zm1SdEJtRkpXK0owTFdkc3crRzRnMjhMNGdlZEJpbVdaekxNeEgy?=
 =?utf-8?B?WUNBdVVTSjNNckVqQTZ0UDI5U1I3RHhMWGhFc0cwQUhHTGlvYllXMGNBdEE2?=
 =?utf-8?B?VWZZT2psMWJ2L0Z2R1o0LzJva0hnYkZnRWtUTGhxMFRHWlRpR2pXbXo4Z21U?=
 =?utf-8?B?OWhpVS9wdHZzTElYaEpHcXBoek04Yy9EUUQwL3RUcWVKWCtBYWRtZ0ZjUFhi?=
 =?utf-8?B?VGY1NXdBTHFhQ1B2b3VhanY2VE1QS2o4UkVyeEhkTXprNnJrWkZiTUhubUth?=
 =?utf-8?B?dHc0aUV2N0d2QTlodTUzcFJhbmFGbGhieHZYZW5sRkpreHJ5bkxDOFpOMERs?=
 =?utf-8?B?blJKSnhIYmVuVHFMWjB4cENHV2dWK2VET0lTbWhRMHpwbTdoaXh4UWlFbG9w?=
 =?utf-8?B?VmVpQmx6S2xpQm9Nd3dtaWVtemRORDJEYUdIS2tYRzd6cjhYU0pmVG9JMGh6?=
 =?utf-8?B?UHpaQm9kY1VIWHd6eXh2bWlxQVZOT2xJc01zemZvUUNnNmhKTVRsTS9ibG9M?=
 =?utf-8?B?VDYrKzVESUp3RTEyK2plK0lBV0E3eWxuRTdlUURxRkloQWY0NEordTYySlF0?=
 =?utf-8?B?cFJDc2JqNlF6TmtleCtlVzNrS2o5MG9EVXQvUzNyakRieStQTWVKd0JxTjRj?=
 =?utf-8?Q?oM6EwYEEt5kJOM8uf5BJ7jFPgTfbRStmhxmECVc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(7416011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjFBbmptK1RwTWlheWd6cUFOS0lwSmhYZ2I5MUhSMnhubFdtZWhBVGdBUjhk?=
 =?utf-8?B?RnRNcFF3amtZY1dTUjVNZGRLN1hQM0c0dldFZnppb1M5MlFpMEVjK0UxdEpw?=
 =?utf-8?B?S3ByQVpOeDBUR0FzaStCRkxSdExNNXB6RE85Qm55dmIyVytxOTE1TnprL2lU?=
 =?utf-8?B?V2VUalpyNEl0b2I0V3Vid04xSXpSY1dKS2U5cDhoVE44T2wzZUV5UHltUzRG?=
 =?utf-8?B?RWIzNE9zRGQ2N1pYUzBUdHh2OVhhRTlnTmdpVXNWK3VNYW1BMVNFS25jT1k4?=
 =?utf-8?B?czJXd3NLZ0JXYUlmZHVtUVZSc3c5aDFTbzZYUlcrUHoxTjN1ZDhKaHlodnd2?=
 =?utf-8?B?eGNLUDVSQWJhZGtwV1MweG13NElWd005WFh0TC8xU1ZPdzZTNXExQWlSVzRr?=
 =?utf-8?B?Z3BCSEhmQVRoNWYyYzA4UUlEMnBiWnNtZ3lrOWdEdnBHWjRKaW81ejNtcGc5?=
 =?utf-8?B?TGJkSUFIakl3SWFNOFp2dmFOV01ydmNaeW1CbG1GVUtHK2FTcjBEeDlqVlBR?=
 =?utf-8?B?UmloZWJOSU0xWXBVRG54NVM0NWozOXdPSW4wNWtubm5VQWp3ZkIvMmRueFRs?=
 =?utf-8?B?a2d4V2NuRWtSc3gzakhmcGdTaXNpL2lORjB0UnZkTjRHYnJNaVFLcDZOOHFF?=
 =?utf-8?B?K043QWdRNFJsY3VjVXV2QXZTKzRxVGJYeWNpNmlrdnhlUkRON291MVpGU3I0?=
 =?utf-8?B?cmJDa1FPdGJPVTY4Q2RYMHJWeEwvZjEvVkJhK1ZqZmZtQ2JIZDAyVEtVU3Vw?=
 =?utf-8?B?UE05Q2ZlTDE5MGZNcDl4N2ppUmFzZU1oTFd4T21PaHArWElMMHhQRDg2bDFT?=
 =?utf-8?B?bEFuRGd5RkV1RnVGdjBJTFdTekYxRDEzN3kzaU5nVC9jeTk3a1Z0WmgvUkxG?=
 =?utf-8?B?RXpwUEF1elc1NjR3VVZMdnFaZlpzVGxETDF1Ylo3amZLdVJOWmFTZTdEbEJ0?=
 =?utf-8?B?NU5BeXdPeU9URlF1cmhLVTdONWE2UTdWQTZlaG9mbDFDTmQzeHAyOWNTMUZI?=
 =?utf-8?B?MldhcFlGanI1di9haUVFSW9vQkRxSUZMamxNYzZKd0pWYVZRRU5Bbi9rSENY?=
 =?utf-8?B?d1RpQlp2eU5vaVJYNWxqUk1VREN1MGxYTEVXV0w5R3NtVGdROVBZMHNoRm5I?=
 =?utf-8?B?aUdtOWl5dDRnN013TGdjNG1QZWRBbStJY1lYMndmNjQ0U0lCUzY5QTg5SThJ?=
 =?utf-8?B?ZEJteUxEUGxqcU1IejllNktnSTZzY2luYmJnMFBaMmdTaEo4aFR1ZzFIWDNv?=
 =?utf-8?B?VFg5eUdGN2YwOE9PMXhVbVgxMTVQSHRxNlNRcnNxRWxZZEdPbFY3RXVxeXh4?=
 =?utf-8?B?bzZ6N2VCalRnM09QZFNseXlQOVF3b0ZFdmVBUjBhcjdOS0FZSW1ma2ZEQThC?=
 =?utf-8?B?MlRhQityQjFWb2VZMkR0UjdzVzFxSGVrNFdtSWZ0T1VFVE9tUmJTckhoaXBU?=
 =?utf-8?B?eHYySlN0SWxaMEpJNWhpcWxxVDl2ZmovOUVrUXlyQnVIdDhIYXNlYnNUdmlx?=
 =?utf-8?B?ZlVVVnA0aGJpUG0rZFcySzVPd3BMd2ZqckRYbDVaMHFIeStHM0dGQ1hRcmF6?=
 =?utf-8?B?RGZjU2cxb0dkT1hXQm9qbGFnWEp0YVlHUEpXSWZoVmJxSlYrYkkzcm80d0Jk?=
 =?utf-8?B?djlIL2JqUTV4SUFXMzFOU1Z2RmFpNWtaenlvWHFsb2VOOG1MTDJRclVHSEtZ?=
 =?utf-8?B?bEUvcWMySklDS25mRWs1K2dIOTgyTTdVZ2xJSFY4KzVVM1RZYmhrMHkyOUJ4?=
 =?utf-8?B?RU5HUFNFRXlXWjNUTDQ0YktGOVQwQzJ1bzVFbFZRUVZ1OHBlLzBtVDM1NTd5?=
 =?utf-8?B?cXR3Q1VYZ0gvMkE4RzlDOGdBOWVnSk5yYlE3dnJqeVF3R3NKWDY3UnBWNGh4?=
 =?utf-8?B?ZktMbkUvT2ZTMVZyNGhqbmhMSVpPQ0xiNTA4eHlrTmlEVTdHQlRKZTN0VWxP?=
 =?utf-8?B?b3VPdkZZS2VpYzRCc3hvUDl2cVVuQXN2UEhDSi9TcWdMNFMzaHJ3cEN6ZkRT?=
 =?utf-8?B?OWlVY2JDSVhqY1JhcHFGM2dxdXU4b2xZMktmZy9kaDNXV0FKL1duVUx6QzY0?=
 =?utf-8?B?TVRZUWhyZU5yRkVrYlZmRkUzRFhMWjMvQzlMTUYxeU4wcVE0blFibjJBcGFq?=
 =?utf-8?B?cmE2NktzaUFsbEhCdjFHTTdCUUdlczNtMkVDVEdNV25XQThidUkwc1FrY0NI?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ebceda9a-7d3a-4dd8-e033-08dc90f2b9b8
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 06:32:15.3083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8j7kF4nTssCqU31zjcRwT5EyeVMK8TJymRDU5J1WV4jLbKWulR+stLo1+8WWv17NBffyf3kaXzjmFuX1At6rt4thIwdldW6HN82MMrgZao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8487
X-OriginatorOrg: intel.com

On 6/20/24 07:47, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Since drivers are still choosing the context IDs, we have to force the
>   XArray to use the ID they've chosen rather than picking one ourselves,
>   and handle the case where they give us an ID that's already in use.

Q: This is a new API, perhaps you could force adopters to convert to
not choosing ID and switching to allocated one?

> 
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
> ---
>   include/linux/ethtool.h | 14 ++++++++
>   net/ethtool/ioctl.c     | 74 ++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 87 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index 13c9c819de58..283ba4aff623 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -199,6 +199,17 @@ static inline u8 *ethtool_rxfh_context_key(struct ethtool_rxfh_context *ctx)
>   	return (u8 *)(ethtool_rxfh_context_indir(ctx) + ctx->indir_size);
>   }
>   
> +static inline size_t ethtool_rxfh_context_size(u32 indir_size, u32 key_size,
> +					       u16 priv_size)
> +{
> +	size_t indir_bytes = array_size(indir_size, sizeof(u32));
> +	size_t flex_len;
> +
> +	flex_len = size_add(size_add(indir_bytes, key_size),
> +			    ALIGN(priv_size, sizeof(u32)));
> +	return struct_size((struct ethtool_rxfh_context *)0, data, flex_len);

struct_size_t

> +}
> +
>   /* declare a link mode bitmap */
>   #define __ETHTOOL_DECLARE_LINK_MODE_MASK(name)		\
>   	DECLARE_BITMAP(name, __ETHTOOL_LINK_MODE_MASK_NBITS)
> @@ -709,6 +720,8 @@ struct ethtool_rxfh_param {
>    *	contexts.
>    * @cap_rss_sym_xor_supported: indicates if the driver supports symmetric-xor
>    *	RSS.
> + * @rxfh_priv_size: size of the driver private data area the core should
> + *	allocate for an RSS context (in &struct ethtool_rxfh_context).
>    * @supported_coalesce_params: supported types of interrupt coalescing.
>    * @supported_ring_params: supported ring params.
>    * @get_drvinfo: Report driver/device information. Modern drivers no
> @@ -892,6 +905,7 @@ struct ethtool_ops {
>   	u32     cap_link_lanes_supported:1;
>   	u32     cap_rss_ctx_supported:1;
>   	u32	cap_rss_sym_xor_supported:1;
> +	u16	rxfh_priv_size;
>   	u32	supported_coalesce_params;
>   	u32	supported_ring_params;
>   	void	(*get_drvinfo)(struct net_device *, struct ethtool_drvinfo *);
> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index 998571f05deb..f879deb6ac4e 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -1278,10 +1278,12 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>   	const struct ethtool_ops *ops = dev->ethtool_ops;
>   	u32 dev_indir_size = 0, dev_key_size = 0, i;
>   	struct ethtool_rxfh_param rxfh_dev = {};
> +	struct ethtool_rxfh_context *ctx = NULL;
>   	struct netlink_ext_ack *extack = NULL;
>   	struct ethtool_rxnfc rx_rings;
>   	struct ethtool_rxfh rxfh;
>   	u32 indir_bytes = 0;
> +	bool create = false;
>   	u8 *rss_config;
>   	int ret;
>   
> @@ -1309,6 +1311,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>   	if ((rxfh.input_xfrm & RXH_XFRM_SYM_XOR) &&
>   	    !ops->cap_rss_sym_xor_supported)
>   		return -EOPNOTSUPP;
> +	create = rxfh.rss_context == ETH_RXFH_CONTEXT_ALLOC;
>   
>   	/* If either indir, hash key or function is valid, proceed further.
>   	 * Must request at least one change: indir size, hash key, function
> @@ -1374,13 +1377,42 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>   		}
>   	}
>   
> +	if (create) {
> +		if (rxfh_dev.rss_delete) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +		ctx = kzalloc(ethtool_rxfh_context_size(dev_indir_size,
> +							dev_key_size,
> +							ops->rxfh_priv_size),
> +			      GFP_KERNEL_ACCOUNT);
> +		if (!ctx) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +		ctx->indir_size = dev_indir_size;
> +		ctx->key_size = dev_key_size;
> +		ctx->hfunc = rxfh.hfunc;
> +		ctx->input_xfrm = rxfh.input_xfrm;
> +		ctx->priv_size = ops->rxfh_priv_size;
> +	} else if (rxfh.rss_context) {
> +		ctx = xa_load(&dev->ethtool->rss_ctx, rxfh.rss_context);
> +		if (!ctx) {
> +			ret = -ENOENT;
> +			goto out;
> +		}
> +	}
>   	rxfh_dev.hfunc = rxfh.hfunc;
>   	rxfh_dev.rss_context = rxfh.rss_context;
>   	rxfh_dev.input_xfrm = rxfh.input_xfrm;
>   
>   	ret = ops->set_rxfh(dev, &rxfh_dev, extack);
> -	if (ret)
> +	if (ret) {
> +		if (create)
> +			/* failed to create, free our new tracking entry */
> +			kfree(ctx);
>   		goto out;
> +	}
>   
>   	if (copy_to_user(useraddr + offsetof(struct ethtool_rxfh, rss_context),
>   			 &rxfh_dev.rss_context, sizeof(rxfh_dev.rss_context)))
> @@ -1393,6 +1425,46 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>   		else if (rxfh.indir_size != ETH_RXFH_INDIR_NO_CHANGE)
>   			dev->priv_flags |= IFF_RXFH_CONFIGURED;
>   	}
> +	/* Update rss_ctx tracking */
> +	if (create) {
> +		/* Ideally this should happen before calling the driver,
> +		 * so that we can fail more cleanly; but we don't have the
> +		 * context ID until the driver picks it, so we have to
> +		 * wait until after.
> +		 */
> +		if (WARN_ON(xa_load(&dev->ethtool->rss_ctx, rxfh.rss_context))) {
> +			/* context ID reused, our tracking is screwed */

why no error code set?

> +			kfree(ctx);
> +			goto out;
> +		}
> +		/* Allocate the exact ID the driver gave us */
> +		if (xa_is_err(xa_store(&dev->ethtool->rss_ctx, rxfh.rss_context,
> +				       ctx, GFP_KERNEL))) {

this is racy - assuming it is possible that context was set by other
means (otherwisce you would not xa_load() a few lines above) -
a concurrent writer could have done this just after you xa_load() call.

so, instead of xa_load() + xa_store() just use xa_insert()

anyway I feel the pain of trying to support both driver-selected IDs
and your own

> +			kfree(ctx);
> +			goto out;
> +		}
> +		ctx->indir_configured = rxfh.indir_size != ETH_RXFH_INDIR_NO_CHANGE;
> +		ctx->key_configured = !!rxfh.key_size;
> +	}
> +	if (rxfh_dev.rss_delete) {
> +		WARN_ON(xa_erase(&dev->ethtool->rss_ctx, rxfh.rss_context) != ctx);
> +		kfree(ctx);
> +	} else if (ctx) {
> +		if (rxfh_dev.indir) {
> +			for (i = 0; i < dev_indir_size; i++)
> +				ethtool_rxfh_context_indir(ctx)[i] = rxfh_dev.indir[i];
> +			ctx->indir_configured = 1;
> +		}
> +		if (rxfh_dev.key) {
> +			memcpy(ethtool_rxfh_context_key(ctx), rxfh_dev.key,
> +			       dev_key_size);
> +			ctx->key_configured = 1;
> +		}
> +		if (rxfh_dev.hfunc != ETH_RSS_HASH_NO_CHANGE)
> +			ctx->hfunc = rxfh_dev.hfunc;
> +		if (rxfh_dev.input_xfrm != RXH_XFRM_NO_CHANGE)
> +			ctx->input_xfrm = rxfh_dev.input_xfrm;
> +	}
>   
>   out:
>   	kfree(rss_config);
> 


