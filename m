Return-Path: <netdev+bounces-180595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA25A81C00
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 07:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645373B7096
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 05:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63911D54E3;
	Wed,  9 Apr 2025 05:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BchtIPU3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544C916F858
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 05:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744174907; cv=fail; b=IzGY54jCmdUP555jh/vdhnKNDBM5XAjRuvWaBCc9IxzVtAZLa4fEywkBeij3ACOcpreaLctiBYed1gkaCw2uvOV93cQZyt+cVdHa25X8UvaFQ6P2okUA9o8lyryx+fgM+VdhRpZtdf6/jgPerlrI1Z/ny3aXSfMXwOsuRP7ZlGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744174907; c=relaxed/simple;
	bh=So7T2qCDWAmxeid5DY74P5S3n8bTWHVOVQCLL+UE1+s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eZnohgW6jPK2VDfsHGM9RJ8JCkGBJmcZ6cGGQtc5y3jbtKFGZ+57igOBXygGpo4SmUQF60ziBPX2bBQ4o3rtWVlaJBuy2hFUZdleGFT2Y3tvHzBhb1+o1Pg8YqczOzMhqzptZk6CsxCSPi6O61mAvTx5Szwz5d3z+7AiXztELBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BchtIPU3; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744174907; x=1775710907;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=So7T2qCDWAmxeid5DY74P5S3n8bTWHVOVQCLL+UE1+s=;
  b=BchtIPU3QApeAtNywYf9C0JI2m8ovfODw6lU+uFubjGx8Jhcn/Cyprsf
   cKXlSxS6FsUgWNmPWq+jK80M9mu95OcMvr5DwJu43+ax4oG/u0EWDHl6I
   fmhGGi2NYglLWbzpAV1uBJWgG7wkHXAunuBc5zGoW3tuaTiZyz3lo/iXO
   zeah1Z8TfWhgDqLOUBIkgs2dHNbSxupWqR5zXD6H6gXwNdEWzRLQCgb0L
   wfNLUi+zlWy1fY3A7v58U4cRh2lcMzYlUIzMY56tOMc1Lc97v0Yev/NwS
   N+YCkAbowjNaS+AdlrjAIr9t8cUCz37yeJOy8GkVRJBG8hQhU3NQHA+I0
   Q==;
X-CSE-ConnectionGUID: 3kEqlBo6Q2Si9bE6qmC3Jg==
X-CSE-MsgGUID: u4HmF2/YSGKNv+AgW5gWvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45722321"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="45722321"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 22:01:46 -0700
X-CSE-ConnectionGUID: IAcGVSilSf2unTbaMeFzTw==
X-CSE-MsgGUID: 3w80oVweRaaESCudPeuVMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="133675806"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 22:01:45 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Tue, 8 Apr 2025 22:01:45 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 8 Apr 2025 22:01:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 22:01:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3cBzcCD1B5gjp3Pr2KoIzRAbzIYSgu5oU9C/SfZ8lga3toZOLphwyFTH9h43g/VzNGKT0XktmnvEGUXzKvEQMvtHE5qyKA3nN2Fs6QHlqdTQMxN5yfwpemPjngSzayjY8P8jXA63hmVZRf9DamXZLor4qJEdPt2997DnLvPg21yaaARYtAMAfwGY1TaCb7rbdLwzeLl2Q3vvtAdWsQ7XbbgNDLkCqkrFgtWPEch9Ff7Zqt1qu1OLgAMc32FbDS09UZFDr2I8SIArIu33IhXIoirZY2qxKRk2bCCiqboeQwIROnE0eCSnuSGInyizFGJWZRP6RnStiGa16k9cyLXPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKHpy4C5Z4LxzOd87t3OrRkenL5n+g+YRhbITGNU7DY=;
 b=lP96PrL75PJ+POb+zhCdLP47FDh8OZBhZMv79VWno5hbWQ/H6e8DxLEGWFtpavoGmV8dlTQAL5PiQl4q29lKxKgBmZIs64uAz9zpTQD9cSRanVjxkyXY/SBUCdtXhz5MKqyh6Tz6pg9gpahzetE95ivnlkW/JKkiviVocAdgQlH+w7SfOg5x+YvqSKGjjawH+Ruj3GbbuZC4DSlkpMCIB2b6FdelJR1lJF57/QSNfeBvbXzn++Mu6IESehY56VI/6guVwQqXXqLCKh+WRGoAOEDKKTLDePcrkOG/nGiA81Lkg0L0mbGFJRJZsYRP/AVIYu7yuPzmo+5B5zEQEapl4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL4PR11MB8847.namprd11.prod.outlook.com (2603:10b6:208:5a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Wed, 9 Apr
 2025 05:01:42 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.017; Wed, 9 Apr 2025
 05:01:42 +0000
Message-ID: <a21e1053-c84d-4fd2-bf5a-5ed57b4206e4@intel.com>
Date: Tue, 8 Apr 2025 22:01:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 11/13] tools: ynl-gen: use family c-name in
 notifications
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<yuyanghuang@google.com>, <sdf@fomichev.me>, <gnault@redhat.com>,
	<nicolas.dichtel@6wind.com>, <petrm@nvidia.com>
References: <20250409000400.492371-1-kuba@kernel.org>
 <20250409000400.492371-12-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250409000400.492371-12-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0028.namprd16.prod.outlook.com (2603:10b6:907::41)
 To CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL4PR11MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: 3efc24c2-3370-4e80-a76e-08dd77239e36
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RlBMYjNtOTZHMGNZdzhCaXhUS1pqRVZmZjhEeTZBWVRyNUd3YzZZWXdHcjcy?=
 =?utf-8?B?SWhuVmJJQTBic0o4S2E2cnpDR2IvaHVwSUt2T0dkU20xa2wwdmdJQXpsRUJi?=
 =?utf-8?B?bVlETWlkQ2dhNm9GS0RQTGR3TU9QMTBVOUhqVDkxUzE0K0s1U2Zib2h2RFVZ?=
 =?utf-8?B?cGpEYmFSeWp1MW43bGd3NTJwZEVJRXAwVU5DbVQvOWkwWStFcEVYdFBiRGJM?=
 =?utf-8?B?eklqd1oxSmcxOFg2bCt5NzJtNnRZcVFsc0RyNVNqbXM3ZnlJQ1dEVUR1N2JI?=
 =?utf-8?B?MWZOZUg3RDh2MzYvcFByRGZrWkFuRnRZNXJ6STEvdUVtM05YRE5XZSt3bWh0?=
 =?utf-8?B?cUh6dlVtSEUrdDZSRVF5WDdPem4yZlpXaXAxRmdXZmkwR3VHdS94VTFyY093?=
 =?utf-8?B?Wi84R2k1NkFGeGw5TmtheVk4T0Vxb3dhRmNreHNpREF0S0hNS3U4aDg2cktv?=
 =?utf-8?B?Mk1tSXBhdFpZRHFuS1BKR0loK00wVFR6eTQ1T0VMVTRKRUhKMUZxdHBlL09k?=
 =?utf-8?B?VklYSk0vVGlmVVJxMVB6UjI3cXpEcGszZUdUK3R1dDRqSXl0QzFHV1lDbDFB?=
 =?utf-8?B?TGorVmszZ1d6dEVwNGFWYkJ4cEE4OWdDbnN3YjR5azhWK0dEUGdQUDZyUWJl?=
 =?utf-8?B?ekZqSHY2TU9mNlBUREkwYklMenBkVFBtbzdzTDJ5QWt4SWU0WmRwN1NTMktS?=
 =?utf-8?B?YXRFQlozaWpMNzFOZHEyN0NVTmFSNTNTQStGMnAzRHVwVUJoaU4yTGVxYmpJ?=
 =?utf-8?B?U08zdzB4Q1F1bmdWRXl1M0tTaXRnTXN1blRqSUhPN1NkRWpqRXJXemRCbkVu?=
 =?utf-8?B?MmVvSGVhV0JTVTBGYkU2S2dFSFlrUzhTTW1oUEJRazNRSko0ZklaN201ZkJ2?=
 =?utf-8?B?bFpqSlJDMHc1VVFnaUM4LzNYU3lvY3dHMm1DSUZ2bGlJWkpuckxGSnRhdTQv?=
 =?utf-8?B?UFMwWEhVUmMwb0Ztb0p4Y1VxMTFUanhyYXhZMTBhNi9iS3o1NURlTWh0aEIx?=
 =?utf-8?B?VnlKWnFKMVVoM1lPdDlpWEtmUWpudjA1UjhDTG9qR1laWWFTUlNIQVA0NWVP?=
 =?utf-8?B?WVg3azI2dHpKRStTM3ZUeEtiSURDNU9xNlBPcnF3STA3ekViZjZlcG9kVVFs?=
 =?utf-8?B?d2plSUplK2hJMSswUXF3ZGlKOC82bk9hcG9DRW5uUmhidWQxbi9xSHdOS3NE?=
 =?utf-8?B?NmR3WmlDeUcweXcxSURyTzhqRkxxQ1ZrVTNEQVNJbmhqcUdpRzEweGJwNU1u?=
 =?utf-8?B?MEJ1R1JHMzk3S1g5ZFp2bXJycTBEUU5uamZVNlM3K3hZNFZMVThBSVdSQ2FF?=
 =?utf-8?B?UmQ1dy8reFVYaERHTjRhK1hQSzE0YzBhSmdTY0tmQ0hlcC80YVlxcGR1Q2l5?=
 =?utf-8?B?QW56UERidGZybEVBMStwM3VvNVFHMlpuWGpYWThLam5Ua3ZRTCtQS0ZNOWg0?=
 =?utf-8?B?Qys4RjJ1dkVVdXl5OTRvd052RzVtSnM4b3pCY0l6azhrM0pCUHBIYUJQNEp4?=
 =?utf-8?B?d3IwOG83L1RudTY5bENWd2FaRlBwMytUY3NCRC92SUU5bS9TZU8rdWkrZnN4?=
 =?utf-8?B?QUNiK3hHVUpCUjNUcGVUOTNEekhqb2pKTXQ5MzIwUmNiWlN4SitOWUNFUnps?=
 =?utf-8?B?U1N6eVIwT3hUUGpKMWpjYWM5V1ZXVFBOd2hpL1FoeFMvUGhTb05Kejh6ZThx?=
 =?utf-8?B?bTBXZE14U3FwK0M3VHRwcVR4ZW83RUl2cEUxM1F3MzR3eVkwck45eWk2VGdJ?=
 =?utf-8?B?bnlKMzM4dFJwMWVZUkNJK3ViT1NEUUhScUNVeDQ1MDJGek5zOVozUyt4WE1D?=
 =?utf-8?B?V0UwM0RDUU9wOTZaK3pDNFJUQVk5ako1MGxjQ3g2Slk3ZFVra1Q1RjFNcVVa?=
 =?utf-8?Q?FTSw36DOXc6BT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDlGSGJ4ODFvenlMZFoyNE1pL0c5K21NV3VyYkt0K0tCSlozWUR0TmNiT2VF?=
 =?utf-8?B?YlN3cC9rRTYyNldvVjJhTmpod2p6cUppUHdPQ1RwenZpTFhadUVpaUdTemNJ?=
 =?utf-8?B?Nlo4WjRoYlZZL0ltOUNDZDBEbW85cUlDM29GSnBuZmt5a2xnZHFUL05URVRK?=
 =?utf-8?B?SmNYM25pWXJGQXhPUTdCREc0R1RGM3J5RTRhdWtLK09QODFrd2xpbkVQZVo0?=
 =?utf-8?B?RXR4aUZ0L0ZkUTlURFVCNkNLd1A2UldUeUV0RFdWVFk5cTY4MFBJV3hxZExp?=
 =?utf-8?B?SmtYUTNEVHdMSkdPSFNZcnVTVzlPc0RGZ1UyTWJJa1hxOUUyVGlqbXhBZ09p?=
 =?utf-8?B?ekNQMnZTQzdqd0NnRmpyZnhtWFdwd0VjVVdHcVZnRkxFVmdrUnM4NG1Ycnps?=
 =?utf-8?B?Zlc5TUtqU1pjRHB4MEN5YURzZGl1MzU0Qmx6UU9iZmFoU28xclRVZGpScFNm?=
 =?utf-8?B?SEp5RVlJU0NSRTNIb3hvcWIrOS9MNUNKT0hmbU9EQVpibkd5R2YvUzArcjNz?=
 =?utf-8?B?elhJWXdnK3Rscm1mOWczMlRERlJlQUE2SU53MXVEK2ZkN2gyYjFSNTFXT2Nu?=
 =?utf-8?B?RG5hTTA3Z2xPWmJmenVOekhQUzNzdTV4Q1lVcXY5SHp1QnFSbTV0UGY5V3JQ?=
 =?utf-8?B?di9mYlAvdE9EbHVTbnBHSVEzOUg4ZVlhNThzcStOM1lZZEtOTUhFR2lOeW44?=
 =?utf-8?B?Nk1uN2Y1WVlKU1RPVldFb3Npck0zdGhlUGRqMzdPakVSK2ZXK3F3Y29VdVpW?=
 =?utf-8?B?U2c0TC92NVU1S0xMQVYrRUpsdTNXVGY0RjJtNkx0MGR2YUtOOFRIaHk5NHd0?=
 =?utf-8?B?Y1hxL0g2TndIeVM5SHFnQldvd1ZwaEkvY2s1UzFIZ1FQcmxrTFJveW1JL0wv?=
 =?utf-8?B?WGYxblBzNzZNT1BXc3R0aDNXMlB1V2krWFE1M3RMQTYydVhBbzBqSmRGQWo1?=
 =?utf-8?B?SnAzMHQrYUlseDhWWUFlZjJDQWhPUjNnMllveEhrOW91cTBwVDlSOEUrL3BZ?=
 =?utf-8?B?NTNuUm9WSFlYUHo4VW0vSHMrMnkzK1RvdUhlN2M4YzZtbTFhSG1HOXRRVkhz?=
 =?utf-8?B?YUFrdytiTTRaME9jZVltSWtMR01hUGtzVTJmV09HdDJsZ1FhN1RJUFFqTHgr?=
 =?utf-8?B?a1lkZ3hJL1Y2aGNKeFVwNkJrcC8rMm5FVDJGcEszNHY3d1BsSEJweTBSQ2x0?=
 =?utf-8?B?cUVUVlpQU1ZrTkljcENEeXJkU3BVY1EyMTB4OVc4bkFZUEpuMEtyTXo3Yys3?=
 =?utf-8?B?YXk5alVPbnFpQ1B5U0dTL294a0FxVXBKWXRLeW1HQWJ4S1VSWVFZSTdjNkpK?=
 =?utf-8?B?TkIxM3JDNFRNRnB6Z1hzanpQOUJ2dXozVDRPaERXVVpqK1JtckQ0dFJ0ZEpi?=
 =?utf-8?B?dWg4Q29TUy8vSHdOSDU3S2ZCM1BvalVtckRJZC94UkJreVJINHhJY0Q0UXYw?=
 =?utf-8?B?RjRCRXpOZC8rYjhYZENJZU1FclROMEZQMVU3VXRCT3JvRE9EaU9HYUtLNUNh?=
 =?utf-8?B?U1QweUg1OXUxSEZvWU52Tm00U1hBZXJoQXoxdDlWZ0grUUY2dE5KTTg2Nzhz?=
 =?utf-8?B?em4wWkxVbjE2SUcwSndUOWNWV0JmTWw3cTZ5QUNxUzBFcmhEOGFRZHFNbWha?=
 =?utf-8?B?Yk1qdE9rbys3TWV1ckFtT1dNSzVNV00wTEJ3U2Z2Q203UnNQTGx0bTBYd3Ba?=
 =?utf-8?B?MjFyNXZSUkI2QkNnbXR5MHRnSDE5bmtPdTBTN2pzNlgvQ3p3STA5eC92Wm0v?=
 =?utf-8?B?RFlZY2NkRDh1TjBFTkVhN1h0N1ZzTnVYOEtGWVdQNUVoT3p5S1JTQmFTQ1FL?=
 =?utf-8?B?aDQ2YU12V1ovcGpJQ0ZxWEU3cGlzZmN2RXVqU1FJSjdTSkwxdmQ3emg4ZUZU?=
 =?utf-8?B?bVBJQm4vS0IzNEQxUTU2YXpHblRYdXRIdlMrSlZKZnJNcStOdW83QUQzNlFS?=
 =?utf-8?B?T1V3eTdsOEEycHFsSHExY1NvS3NsaWFxQzk1SlRuNS9neWtVTHo5V1IwbHMr?=
 =?utf-8?B?S2gyNldGWDVVSmVjZ3ZBTmx2UTdTek54THlBZ3NWb0c4cFp6VTlqanNGV1dT?=
 =?utf-8?B?UlNIRGl5UHJWdWMvWE9temVzaUZVWm9mb1FIcm5sTzhWdzREOTB3NDNrczJD?=
 =?utf-8?B?TTF2emk0dFRZdUNRUmZhZ3RRNXJHWllaa01MUXNTVkQ1aVJXTEg2a2VCYnpW?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3efc24c2-3370-4e80-a76e-08dd77239e36
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 05:01:41.9715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kXtON03CU+THsPAbwrjCXqQnLW+v0F8OdYr3LOtWwUYg54UScwQr57x3QZSpJxwOICtnAyDGQQKjpS+u8gA17BvwXGc1H+UC5PrhNvf77Y8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8847
X-OriginatorOrg: intel.com



On 4/8/2025 5:03 PM, Jakub Kicinski wrote:
> Family names may include dashes. Fix notification handling
> code gen to the c-compatible name.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

