Return-Path: <netdev+bounces-114554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4EF942DDA
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 14:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A396B225C5
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 12:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B592E1AE84E;
	Wed, 31 Jul 2024 12:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fqSK3Uy5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079B51AD416
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 12:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722427909; cv=fail; b=MNgG1b97t7ubtg8GI3lOgoxCCUvMYJ4p3HbXnhkqFbTlRLkx14tLp4ZrlKuH64CL06HRsZmLcWizc/32UyvvwayNeSnHud3dmaHNgTkFN0ccsDWhUurgzchBy13cXNJj9yETdEU4hJRdi64oRM9OXJTWqt0mc5T/vdyHpcQ4GCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722427909; c=relaxed/simple;
	bh=pMwuc2ao9UWFJkO4/YOtn3EePFDdkHqety02gjC7LkM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=coLewLcY0BB1/09H5SoO0mTC6qPGTs7NuLoMu6dPFa4eBw9MWWnDhCXEgITH9PHJvBQVDxGuU5Bx1O5bnxGYGBmTbgEvqkhqjoUBPrTnpHmiulkULjeSb/Po3H38g2Daa7UJ68nktDBsncOrEnDxNE2UEiXZ5lI/QiZsv5f4nkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fqSK3Uy5; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722427908; x=1753963908;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pMwuc2ao9UWFJkO4/YOtn3EePFDdkHqety02gjC7LkM=;
  b=fqSK3Uy55BL4syBEvAewk9QNY6eTKu+SaHuNoVeX2MH3tQf0P+ZSo3qe
   Mk8EOnmZIW5tYLuvrJCEryzDH1slCR6CgJx63YKnQHPz1AKuUGjrFbElI
   NI58yB3hO5Vv1OJpjcIseu+d5whC2DRpkOaxoaVuNSbKNraekXre0F5Nt
   hUU+Ci/YUi5KPaP6v4t8IJPoW6O1E9sZkkr8tg0rEPbg92OGUj+kqNQ1y
   DsDfPUBOCnlXOX1yCb4HmI6AisGozKaNSi4tEaIndYCTFQSlBeXCSkKn0
   SzfvCsbHGmh+XS6HoGsMobrJhq64kBdQoZzNLkwxavjgZPbTFHCgDlRZu
   Q==;
X-CSE-ConnectionGUID: gmpd2XlCRpaivPWaqkmC3w==
X-CSE-MsgGUID: iJHfL6e6QeSNNHCyRfoBUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="20249034"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="20249034"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 05:11:48 -0700
X-CSE-ConnectionGUID: aK7YNSUmSoeUkJwWid65Lg==
X-CSE-MsgGUID: 4r9tQcy+TpOZH9UTB+io7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="54662782"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jul 2024 05:11:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 31 Jul 2024 05:11:47 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 31 Jul 2024 05:11:46 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 05:11:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S01Zp5aygt5HTcFTNm7zQWGDeHam159LMs80Awi0/+VT1shuSnqlo6xChB4YWelxvxtXCwgpwsyrW43X8AcBeiXt1uRyp2uBosRFacNxch6yTOmXF7XxE97TJjZTKHfZ3jVzXimLQ3nAhShGvG2rSwFgL87a6+xUjxsLKs2rY57pNLHmo4WWHIG+L3HEDLPiCTNQESImz/UwwLbAuEVAcS27OYiLabHey/LJX8LYZ9aTq+eTeywCVMnvewFYWaeCZVd3NY+7yhx9DnUqjC0EeygTiIQ9SoXYPNTztgVptWesas7VDWB5kc0Y0xsLhwRL9HQN0UJzOTSiBDduYDHiYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3bC06Cg1pCKd3huE9iJuufI5F8wxbPGYNMzQnyJSko=;
 b=v4OCdg1XPyAPlsyzNTGQxcw9p+9QWPilDqtGyg4bHjVP1cYQwhbjanhG9PPILIm/wd+Ggyo+ud5tRjZ4aNKt4wcy05bI2m3oKu2VHfTHUuR1XAfpIhJaxgY8khF8xMY+7Y/F7h5hKEytOXEhwomSKLC1g5ePDCg48u9pzwwqdQUKnjPK7DG8jGaw78CtrfPUo42I+b+lyrTNsmHYzlyVcUPtil++aLXLxx8ENcP8nguAZ/Xq9xRI23cSHqSFsQAuFqKsAtEsbH957CE0pK+wSlB1IpGfcqVwp7AkzDY0v6oohKp18sJGuFugjEESr2IdumpeJIpJ6qNTtz2YkeqFiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SA1PR11MB6566.namprd11.prod.outlook.com (2603:10b6:806:251::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Wed, 31 Jul
 2024 12:11:44 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%6]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 12:11:44 +0000
Message-ID: <fd0ce1b1-b788-4389-a520-d9072bfdfa01@intel.com>
Date: Wed, 31 Jul 2024 14:11:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next] ice: Implement ethtool reset support
To: Simon Horman <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
References: <20240730105121.78985-1-wojciech.drewek@intel.com>
 <20240731092406.GQ1967603@kernel.org>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240731092406.GQ1967603@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0056.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::8) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|SA1PR11MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: e9a1a975-e6b6-4e42-f940-08dcb159f143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGFMRWZFTVBhWlFmQmJzQjVoU25ZVUFXQWpNYWEwKzhIM2tWc0tHa0dHOVNm?=
 =?utf-8?B?VXVweG5Hb3JHOGN4bDB0WmNSNkxoTStYRGt4YlpQYk9YSWtwdjc3YXc4V3RV?=
 =?utf-8?B?RGJmdTVVK2gyL3FSWUp6bXJUajJTOG12RmVYeU54Y2FsaE5CalpUU0RITDI4?=
 =?utf-8?B?dk1pNGdQcUJOa2NiZTZuTUFiUGlZUHoyUEsvdVFoQk9MSjRWSHZPVk9pbFVw?=
 =?utf-8?B?dVJZNTc1aU5ZdlVCMUVHSDFuQ2Y4TUFnbE5VQ1lnNFpmR0FoMlNaZ0FucUE5?=
 =?utf-8?B?WHhHNHVPdHVNSDk4Zk1SV3lmeWRiOFl1THZDSXdQM1kyeDJ2SFhzZkRoeG1V?=
 =?utf-8?B?UDY1NlBMVHNjLzRMV29GbDdNeUdZL3FWWnZKcUdmRnp4SkhpQWJ4NE9qT0xE?=
 =?utf-8?B?LzJXenY1VUVORElXcDUzMWlOQnRZVmRSYXZqWWM3Qm43WWQ3QWJDQ3Y0SzlW?=
 =?utf-8?B?bHZVMjMxT1ZnR0tFRGJuSnVwVmJ2cE9HUlNVcWZnb2p3OTAreW5TV0NxRzJv?=
 =?utf-8?B?Z01oTDNJbFN6aFNLeUMwUW5yR1lISWxpWldaUFZ1TE51MmwzSW1YNXBPMDZa?=
 =?utf-8?B?YmVsY3NUaEZHV05KTDhSOEdYam9QVERVL3VjYXduSTRkSS9laWdIWitJN0ps?=
 =?utf-8?B?ZE9XbkxXaWtzYjZLdUNSMS9waERJVTFUaGtIb3E0Tjd0amxGeWQwenBkNUV6?=
 =?utf-8?B?TDRLZEo4RVJGdVBoRkc2anJ3dGpCZHk3SGVFMERUak1kMFBCM01uS0tubVZC?=
 =?utf-8?B?L1hTUWpjUWl6VnRxZ0hkRXl1Y0R6ZjdxcXhrK01HOWdjdFlkWU5FM0tMUUtu?=
 =?utf-8?B?dmVlckNjYkhwM29VZHJxSFBMeVp3UnB1dUk2UjB5ZzNlQU9lOHF3Rkt2SWRm?=
 =?utf-8?B?QWRLVHM5MWptOGxqSHIzTTFOWGxmWVpzWlM4MnVQMm10OE04TEdLdDU4WFNm?=
 =?utf-8?B?VTNSR01LQ1Y3cjdQL2pxa1BaalltMGV3WlZWVlB4bUNPcnBFYWRQMERoMlJx?=
 =?utf-8?B?UitGWExTYVpGdGE0akFXVUIybWlwSUNKZ3dUVWxvUEc3enRUcE1EZVk0Y3RK?=
 =?utf-8?B?bjl2RUpwNldwS2Q5anE1WlFvMXEwYzJodlZrV2JPZTFJb1RmdDQ5VHF6SW1s?=
 =?utf-8?B?Tm15OXBoZ0hKYUVNTWNWVmc5L3RRakVERjBWM1pBUk5hak4yOVRGamJSVXN2?=
 =?utf-8?B?R3hwdHp1eEE1WmNwWnhwZVNTdFFDTmVFUEJrdndYVnJCWFBBK0NIdmYxeDFv?=
 =?utf-8?B?SDNWM2VIMUFvTGJGRmtHaGtDd0gwTGlQMURPUjc3K3FTaFhaZUVtOWZWckVW?=
 =?utf-8?B?YkNJaDMwL3BWdmR1M0tqaUdpRUdXdDdJZkN3Qld3Zzl2cmZKZ1RMWmh0RmY0?=
 =?utf-8?B?d2hBSndUbWdtTFFjTGhwaE9uOCtDU0dLZzE3UHZiWld2TS83ejVKellycjA0?=
 =?utf-8?B?QzdmZTZ0bFAza2V5U3NqQ1NYK0VBMTdpTHBGMVFCRUZaR05uN2hkZ0pQdldB?=
 =?utf-8?B?TkZIV09SNlZiZXQxL2d1ZjQ4TzhDQldXNC9udFRKRVFxVHRaUXIzZWdwR2Ra?=
 =?utf-8?B?TFJ2ZzluYmsrRlFObHpnR0tMNHZLVFRxdERITlA0Mnc4c1hkYXRzQUtBMTRI?=
 =?utf-8?B?RCtsQmE3OWhYYXRyQmJSWms1b1FGb1FjcjNLTTVjYWl6MEIzcS9QZzNIS1Uz?=
 =?utf-8?B?MHlRQ2dYUWphV2xSRGNVSlc4U21VSVI2akN4cGhVSjIrSWYrUGRUVFBjb3di?=
 =?utf-8?B?Rk5QWVF0bkxGNmNETVZ3N2UwSUdWNlBmLzdSZ0h4dTB4aGwwR0V2cEF2N2tN?=
 =?utf-8?B?WHRWRGdUUTJFZTJnU1F4dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGpWNGVaSFpDbDhoaEZ1RXdiNURiQzhoa216eEt0WkliS01uV05BWHRNaU1E?=
 =?utf-8?B?OGlaV0VrQXRiSGFPRDhMWmdqbTA5ZUZXWVFxQy9WVVp5RU5KdDloM3dMTmh6?=
 =?utf-8?B?MW9QUzVSaTBEMlF5bVZ6QjV4dEk4VEJYSFM3eGJueG4rdmUrN3BJem9KbUlK?=
 =?utf-8?B?MThlS0NGUC93bk91VU5uYzdWNjl4S1FBSmp1WXRIWU5ya3V3bDBkOVlLOTla?=
 =?utf-8?B?UXR2TUt6NzNEVTZ2S1lscFNPcjRwVlloSlhHcW82akp0dm1JaHBEV3M3YU1t?=
 =?utf-8?B?SmpBSVEwWjdyU1JyRG9xSFJRaXZSQnBoemNVL2ZYVlZ2dzEyKzJ1ZjlHVTIv?=
 =?utf-8?B?QVMyd3FKdDhLSjZnNjJSblEydGhnMGdHcTJjSFlnbVBDcldUL1M4ZnhZVFhS?=
 =?utf-8?B?eDdDQW8wUlhEaDdZR3lEVzJwTEF3cW5NUzdPdXpDYm4wYUFkL2ZubGRFem41?=
 =?utf-8?B?STdmcmZPenRnbmZwRHdkcTlVb04yanVmOFlRWS9rOTVzU1ZoQmRPREU2b2tL?=
 =?utf-8?B?T2d0Ny8yTisxaS9XUTFLR283K1R5d0RhS1QrRDcxOCt4eEl1ZXRvNXUrKzFX?=
 =?utf-8?B?Smp2c3N5ZXpVSmFLT1pIRXpBdEpHUlB6Q2x5Q3RjL2VZNzVvb0VnUjEvUUdi?=
 =?utf-8?B?ejdpSE5vcGh0TlZSZ05ucnl5SGNMa3RsOURyeHhwOCtiN2FEY1FiQkI0TXBL?=
 =?utf-8?B?UmdPdnJWN0NhWW1MaWJ4OEpUSXAzV2JkM1lpemd6aU5FTWppbzk1b0ZmWk9k?=
 =?utf-8?B?d20vbEpkTFM0YjFqZW5xUHYwL3VMcFhCdTFCMTNEWEdZSnhOMmZLYWl0M0hW?=
 =?utf-8?B?SFdOb1hUUVhLSzJtVnUrTW9JT1N0eVh1NFpGU3A4ZGJtT05rajgrWlhIKzla?=
 =?utf-8?B?dDBkRVpzbzN1UmtHQ3NnS0ozVVliSllsb0t1Y1FaelE4anVGQVE3bWd1SEk5?=
 =?utf-8?B?UFVkdVFtcjFiL1RhT0tZcWVRY3RlWWFLMFJwVGJSWVhpWnBGWW16YlpHMHpu?=
 =?utf-8?B?cEYrWG5UNnM3YW9OV2VhcnlDbmNWVkFIaDM5VUh1NEdtTHFrdkI3SGFOTkhz?=
 =?utf-8?B?VVpUWDA0RmdrZmJlcnZZOFlwM0dhaXROcDZjdlMveGpvZGJxck9rNldIdEx0?=
 =?utf-8?B?L3VQeHVVZTRZTEhTazBpTnpvKzFVYy95N29QYVBkbmliUmtCWjY3bGlOeno5?=
 =?utf-8?B?WS9yYThkV2FkNk9JS2IyU0V0WGlraXFQc0U0Y2o3QVNwSDh3YlN2bHdwZjYy?=
 =?utf-8?B?R2xpYWZyc3dKR2VabXpIOXRXeEprZndBWjVSOFEzTllBQXFZMTRhR1dtNVNG?=
 =?utf-8?B?NkNodDlyZUt6OU1iWmhiQVE1TllGTW1iOUlwcHJIekd3RFhKQ0JodGRlY0c0?=
 =?utf-8?B?ZlhMODJXaHJDWHRvajdZMlBhZjdvUjNTTDBGVVVPK09WY1h1Y2FuZEFhUWxG?=
 =?utf-8?B?MWpLcXNWWDJuN3Z2WXBQL0wybGJOdFozY2VVUTl4WlM2K2VibDJZcXhOQ2kv?=
 =?utf-8?B?djQyYTIrN09zdXg2SUZjOVdlR0dVbzBSbm95dDhENFVwRnExN0lxZlgwY0gz?=
 =?utf-8?B?aTNTKzRXUDlQckhDWTlOOHZGZzFnQ0dXVE5vLzVvMXQxU1preTY5TTNhdWd5?=
 =?utf-8?B?cUdWclZkL0ZVTWRpNlRtaW1XSXp3ZmQ0NG10T2Y5c2lJSEZtVHlKazNJMDUx?=
 =?utf-8?B?czU2N1J6aDFud1U0TVY0UG5DVDFvSFFhUy9pTE9JZ1dZWFVkei91QWI1YmNF?=
 =?utf-8?B?NUhhajhWUXViajBzMGNrY2VkK01CQnpQaldOZjdlRExFQ1ZabFV6d0k2WU5R?=
 =?utf-8?B?R1hEQjMwcEdNRmJrODV6L3hVQjQ3YUpxVGd0TWV4OWFMUXZIT1dWK1NFOFZJ?=
 =?utf-8?B?Y1hiMGlZbVRtZjdXU3dHTVJkdFFvQ01HQjVKQU5aUmtQcWdIVitUaXV1ektW?=
 =?utf-8?B?U0UzcGdVckJoVHI1cVpQb0lSTUw4VnB6VVh2RnI5RDVHbk1hVzk4Z1E0QVdl?=
 =?utf-8?B?bEFZWXhTVlZYV3JEa045Y25OVE81ak1DTlY2MjFCNSt2K0tMOUNsZ0ZQaGJJ?=
 =?utf-8?B?MTRMM05VTU9qaEdJQnB3b3FubUlrblVoVmlNN3A3Q05iUG9yaDBYVjBCYUVq?=
 =?utf-8?B?WSsyZnFLYXR5YmRvbVRIbFc0U2FHZy9pQTd1S0hDU3pUYkxERlFVQmRjSS9j?=
 =?utf-8?B?SUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a1a975-e6b6-4e42-f940-08dcb159f143
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 12:11:44.0009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4W3uTOlvZeLsEO3ISLFM4/jdOgW2+wjwBWZ21v49WRDEAiDza0w71IAU9GCva8r0R9xJohk5yEpUyomR+jxZ1AJEebp4MJiH4YEBHzZt7nY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6566
X-OriginatorOrg: intel.com



On 31.07.2024 11:24, Simon Horman wrote:
> On Tue, Jul 30, 2024 at 12:51:21PM +0200, Wojciech Drewek wrote:
>> Enable ethtool reset support. Each ethtool reset
>> type is mapped to the CVL reset type:
>> ETH_RESET_MAC - ICE_RESET_CORER
>> ETH_RESET_ALL - ICE_RESET_GLOBR
>> ETH_RESET_DEDICATED - ICE_RESET_PFR
>>
>> Multiple reset flags are not supported.
>> Calling any reset type on port representor triggers VF reset.
>>
>> Command example:
>> GLOBR:
>> $ ethtool --reset enp1s0f0np0 all
>> CORER:
>> $ ethtool --reset enp1s0f0np0 mac
>> PFR:
>> $ ethtool --reset enp1s0f0np0 dedicated
>> VF reset:
>> $ ethtool --reset $port_representor mac
>>
>> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
>> ---
>>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 64 ++++++++++++++++++++
>>  1 file changed, 64 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
>> index 39d2652c3ee1..00b8ac3f1dff 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
>> @@ -4794,6 +4794,68 @@ static void ice_get_ts_stats(struct net_device *netdev,
>>  	ts_stats->lost = ptp->tx_hwtstamp_timeouts;
>>  }
>>  
>> +/**
>> + * ice_ethtool_reset - triggers a given type of reset
>> + * @dev: network interface device structure
>> + * @flags: set of reset flags
>> + *
>> + * Note that multiple reset flags are not supported
>> + */
>> +static int ice_ethtool_reset(struct net_device *dev, u32 *flags)
>> +{
> 
> nit: Please include a "Return:" or "Returns:" section in the Kernel doc
>      of new functions that return a value.
>      (i.e. also for ice_repr_ethtool_reset)
> 
>      Flagged by ./scripts/kernel-doc -none -Wall
> 
> ...

sure thing

