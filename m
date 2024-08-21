Return-Path: <netdev+bounces-120595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5895F959EB3
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 15:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B2311C20618
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 13:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3ED188909;
	Wed, 21 Aug 2024 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SXvEX3PF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20D41D12F3
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 13:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724247146; cv=fail; b=jf4xx3yk+YJAWHAmqKco2JUaYufV4i+0mAJKuWmqxLswMCZbSDqPzgu5FY9RyGXSdsj4hAemmBO6Yg4dTrgYf4W9/nghAQ4VWEyKd28IngdlJBlQ475BAU8L1gU7J/85E7DmWWVrj/rBzAqJn2Nql6mO4PhUAKbWxxB6uFFK9+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724247146; c=relaxed/simple;
	bh=r6Si7PogbYZ+17vZZ+Z5/p7wr4qcs6bgz8nCmI22LU4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y4TyuyrOvBzpGemtq39E6gHiFgWB0GpXH6rFh8IPYH+3rKasCBRpedgukkUqdATiEXZ0X3gRqvDNQ1P/o+EKkYWgzIWdl1cYMvOgm6SQHCVwqjIeWoUr/yGgVpTk0yPQemEckP82czgI395wftO+b/dyLHZuZU4JWr4w5K6+/JY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SXvEX3PF; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724247145; x=1755783145;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r6Si7PogbYZ+17vZZ+Z5/p7wr4qcs6bgz8nCmI22LU4=;
  b=SXvEX3PF2QCXd7/Ek3BbbFExeoZs08m9M92rJZ23dVYe6mvizlMrtMAB
   t0oVXkCCSuE9CUrXjmwja5kmnN4Oyjbexl+VsCrWcsQYcag2+iF/LnB3M
   RaiG0+nm8oxkXK091TDnZQxU6fYoIlplwuzR9JpH5mz1ccnlo214myZsi
   2QuivxVM8b6w0wKUfSWiXftDzZXhEzszFzbu5y2VCySF0FplE/GNUe5bM
   z90YE0GY0JcJFqMlAPYCqnvtbbh1lsyydNEfWVTt6s1xY2h64PVALudex
   GQ5Gx9S0GEhkMU5VA0sDKogMAv3aMVJMfBu8PuoXGcyPrlLWcDrwepcWU
   w==;
X-CSE-ConnectionGUID: 9W6Fau8eSL6BTTmdl+zgnQ==
X-CSE-MsgGUID: 1XRi66QqQJuipUkUYKL3TA==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="13133050"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="13133050"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 06:32:24 -0700
X-CSE-ConnectionGUID: x59BI2h4S46nybTlT3q3cw==
X-CSE-MsgGUID: GYhOwcz2T7aWhrh9Bj6xWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="65928519"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Aug 2024 06:32:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 06:32:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 06:32:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 21 Aug 2024 06:32:23 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 06:32:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iibch87Rqmxnw/dENLG1az0P1+7CXipYb/ne/TZocn2pNaF7MMmJfld8pkQTilEAD9CTCnKqg6B0rGjAoo0x6WNFPgcv1S3zNnz3zCaBMyyY+IBXnvgbIvwmfuItHTvTsxId46TRcbOpjtntXc4RrnxMvwCXSYTLso6fxun3DLw1JglGWccdNkwuUzNYpOC/HAa7iYdlEh2rHVWyASEu1yxjgBO9R44kXndiVRNZpnlQz33ktajLv0isDQFqYrJUPBlGSAkXQCg3uU2ipfzBSIGXPTIQb0e9SYTeUhHRJs2KOOhC7XY+ef3XwmgTwWI7dE1XR86Rk0aqzLrf1xpirg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dgr2m0ABxVxEP/d3p5l+WM7A8OYblTWVLRNXOotFFnk=;
 b=Dpqyql5iqCdygWOEFxk5E/FZn5VPEfg6qD9t9oByJjTCDOeL6Qg18y/ImMFSmSs70yjOB04rYXVUFTda8lJOAkdH8c50QjbOzP+EPzBLkFYrrrigLnQQXYxPMWYuLDhvYGToXMwkfS2SMA85QeHhdlIv+X1cuSSlf2XN3PHmkYtft2Fz517JmcQfYUosT20+/1bUpTKSKmI5PqoNdFrT5C9Thr4QDweWLS1SRwMU91nbxVza5OO7KE5wpFw9ITsSWCnxEsrlAYXfYfKMsKdAbMhmT/wh+w3E+zkS2sdpj/i993+DjXOhTYb2Z0L4vlZP7EWjLggXJKzKOwCy/HrCUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 13:32:20 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 13:32:18 +0000
Message-ID: <4841006b-b594-44bd-8295-6556f148dc84@intel.com>
Date: Wed, 21 Aug 2024 15:32:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v10 01/14] virtchnl: add support for enabling PTP
 on iAVF
To: Wojciech Drewek <wojciech.drewek@intel.com>
CC: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<horms@kernel.org>, <anthony.l.nguyen@intel.com>, <kuba@kernel.org>,
	<alexandr.lobakin@intel.com>
References: <20240821121539.374343-1-wojciech.drewek@intel.com>
 <20240821121539.374343-2-wojciech.drewek@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240821121539.374343-2-wojciech.drewek@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0119.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::16) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CY5PR11MB6392:EE_
X-MS-Office365-Filtering-Correlation-Id: bc948eda-3278-4f20-efc6-08dcc1e5ada7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cG43QzluUjVvZC9vWDRKR2RjTytKcTR2WDJ6eDI1Qyt1NFVnaUdmTFZ1c2lH?=
 =?utf-8?B?UWR2MndXMWRSaFdGdkdLZnFMSm5GUnJlSHNXNDZFbjFGalQ0Qkd3NXRjVGow?=
 =?utf-8?B?RWxSWlNGQmh0QnB3dkZhc01NZVkrR3k0WXJJVitZVENwT0ZaV3liWDBvTi83?=
 =?utf-8?B?aEc3TldyQ0c2ekhSRkJvMDFiZkxEZVl6NHlpZXVJME9pajVnc1ZDUlBWVmVZ?=
 =?utf-8?B?OVU2Y2RYaFVHa0QydU5CM3hGNDY5Nk9qeVJPdUlXZkcyWEVoclZlNlo4SWdo?=
 =?utf-8?B?dFVOOUowbndTQjllOTBkSjhRMUhBYUpSZEhsSGNsR2krMnIycjFtbFFla2pn?=
 =?utf-8?B?QXRPZUVtdzg2UFRpT0tuR2tEWWszdTBGNU1UKzJmanFYNmQ3OUJ1b0FGSWtZ?=
 =?utf-8?B?T29NZGJPRC9ueUl5NTRISFJGMkFKb3NZMWlLYm1hUTI0V1JkQ2NNK292MGdm?=
 =?utf-8?B?RTllWG9yZFBzeHVyZkMyaVFCK252TFRzSjQ2Rm1ibTE3dXZWVC9jaEZndDVZ?=
 =?utf-8?B?UjRad0xQQzJIeWgwZEhIdkljQXdkeWl2a1c4YWo5K2hkb2JkMTJBb1dxZWxQ?=
 =?utf-8?B?Nk9SK1Q5aDVEZkM4d2J4RjJSRHU0RVFPN1N2azA1RDI5M2NlcWJ4aktVbWRW?=
 =?utf-8?B?djNkN1p2ZGhTbnRla3ZUelg4TWo2cVJFaVRiMXdLSGtQYmJiK3V0bVVRb2o4?=
 =?utf-8?B?QlU1WEpCVU5nS1ZHUWFsQzNHemZJVnlOY1NKNEJ0QVdkcTZLUi9mSmdNUGFm?=
 =?utf-8?B?UWVOV3dtWGovREFWT0lVV0dzMTQrN282LzBJZDV1c1BPRDA4RStnM0QyY2E3?=
 =?utf-8?B?YzBnVnVtR2ZKbFZCNHRhckdoNmhOQ0l6NGhITDZiNXB3c3RhK3dWYjQvNDBN?=
 =?utf-8?B?MVRsRHdUekRMN0xzMmgxWWRiUG15R1pLU1F2MDMvc1hxVzJYektkbTB6KzlZ?=
 =?utf-8?B?ZDJwZDhmYk9SUkJEOThVbDU0ZmllR2pkYnRWTFF6Vy9WaUdqSWN2ZTdCVjdr?=
 =?utf-8?B?NEhPRWZMTGlIdi9zSldDeDBOTjhlckovejEzWXZ3UnhtR2JFVHREdjZwVXFx?=
 =?utf-8?B?K0xIZDRLZVlIcXVCa3lRK1M5ZkFWWlNsaU9hbWo5NzRZVzR1Q0ZkSXNHeDFv?=
 =?utf-8?B?NlV2ekUzZmJRcHpzQzgvT0JJQVhBeUUyTGt1SXhuK2d1WlFRTElmNHFxRFdY?=
 =?utf-8?B?clFpSkRCQmMvUHFnMU5DeHlhMXlMRS9rNjJJdFdrT0FKTW1udjUzSENCMzZG?=
 =?utf-8?B?ZHZxckxmRGpuSVFTT2FQSWlSd244SVQ3MjRKWWtxN3FFcnpKVG9tVkNlUnY0?=
 =?utf-8?B?SnpaNXgyaFpFM3dWKzBNYllWYUhNYWY1dDBjMTlFLzFPTEtLOE9JbUhGV0Rs?=
 =?utf-8?B?OEVRaVVkVUhxaFhhdWFsaGFZYW03RFR1aTZ0ckZGOFcrbTA3NnJWWmRGdnlp?=
 =?utf-8?B?NEQySU9URnFpNk5sbWY2NU9tT2dXUHp6ZTRSWHltbFFHZXFGcjV5aWlBQU9w?=
 =?utf-8?B?d2pIWDlkQWc2NnJjOGY3MnY5enRIVGk4YlA1M0xEWWZqWEt6STdJRUZVZjAy?=
 =?utf-8?B?VzRhMjJpSzdtVlJNejRtMjYrTjNZMnFPZFlHQW8ySmg2OHk1aHAwOUlGaGs0?=
 =?utf-8?B?cGhXSlNRb1NtOTI1L21JWksyUmhNdEYwZVE1Tk9qTTFzVkx6UFM1bllZMHg2?=
 =?utf-8?B?TVZvMmFrOTRXbEFyZ01adHh4eFJWUkppcGRVbXNSR3NGM3Y0WUI0N1lyUXk0?=
 =?utf-8?B?SlZNS2pEK28xRzlYNUp2RVBocGltY3hIbjJ3RGVQVnJnR0pLbmQ2NUpHazNs?=
 =?utf-8?B?YVVCWWYzSURIc3lwOEsvUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUxCSTlEak4wNjVUSXk1VXp4ZjFzMS9GKzFCOHZWVG1ObkNhOEdFSnJSWnd1?=
 =?utf-8?B?OGtWVmNqWWZrRTB1T3c1Ykx4VWttVUtsa1NKcUptbEs1VGRvVEorcUxXUFB4?=
 =?utf-8?B?R3A4c1dyY3Y0eWtaL2djMnM1Tkc5OTErT1FxYWNHTCthUW5nWnlzclZKSUhy?=
 =?utf-8?B?a2I1dU9BVjJ6VVhCNHZIS1ZJdE1MMnErN1Qrek0zbldIK3RCVTAzOSs3R20x?=
 =?utf-8?B?OXFJNkk3VGxoYlNXTHYyalUxdnBsbXhzWFhqSUhaeWdqVm1oN29WMEtsMHhj?=
 =?utf-8?B?RG5mQndyMDZ0V1VYc3lWdkdtYXVrRU85enQ3ZUNCNDZiZlg3WTFBUDlwazRy?=
 =?utf-8?B?WHZqanhMMmhkYzRFMWdsT3REVnlvQnhHTVJ6UndVMzdaNm9FRkNWYmNRcmFR?=
 =?utf-8?B?dDFXRTZKaXdHN01uelB5M1YzTTFpaEhkeDhBVEJleStYV0lubTJ1NjNlRUNj?=
 =?utf-8?B?QlFackU5bk9VbHNPLzVsWnJEMC9yYndqN3EvL1Z5MUtSOGRQa3BJVHoxWHFN?=
 =?utf-8?B?UDMxdTVKa2VyVXg1NWhrWk1uSVRqQmJDb04ra01yVTU4czVpZzJtMnRoZWFi?=
 =?utf-8?B?NGR1U1pScFJzNUxXQk5TbURkS1M3dzF5KzNySVBHWmVOczczOFlWcm9DSHRF?=
 =?utf-8?B?Ly90alVOcHNrSWJnZ2lMZ084dVBZSUFwWDF0NWc3WXlacEl3N2czcUhydEU1?=
 =?utf-8?B?V2JvTGdSaEVtUDc3L1RBTlByYUdxSGdGNkViSS9rS3hHcDlnRjZwZWt5N0Mz?=
 =?utf-8?B?REltTFkvV3JhMU5iS3BreVBlMmpmVzJ0Q053NlJvM0VRWDZTOWxWQmlMY1FE?=
 =?utf-8?B?dkc5bjhtWjdFK0lxV0UvVlF0NEk4Sjg2Tm1nYUViOVZoQ2xxNi9WbERyZWJ3?=
 =?utf-8?B?ZWVGZFBHNk41anRHNXN1WkJiM21obnBkcGc5eWZzQ3JLMkU5NzhyaEg1aWUv?=
 =?utf-8?B?d2w0aHdKM0ZsWHlicGYzUlpTZnowM3BwVmdkdDlCOVhHdFR4MGNpZVRzRmpF?=
 =?utf-8?B?b2FFdVd0Z2tXY2NkdkFLc0Z4blBuU25UZVNTQiswaWpFUGJEWGl4d1IrT0th?=
 =?utf-8?B?Ym5LUDBGWjM3bUdidGpHOTNQVnpQRkdiWHU3aEFJcmdzVGd6OHNCaWVIc3Vj?=
 =?utf-8?B?eVhXbmtzS2pKb3lQeG5jdnluUElXN1hPczBMYUY1SnRmWnJURnBWYWpJTmNZ?=
 =?utf-8?B?R3Z6V1VmbDA4Tnk0N05KRTRLZ3Y3UTZISUJqODRGdENXZnNLVFlDYnBFUk9H?=
 =?utf-8?B?WEJPQmdYLzNuL0lHS3U3ZTk1NDdoT0R1d1ZZRE16U2trR2l3UWJZNlhUcExB?=
 =?utf-8?B?dDYyT1ZtZ1hCWW9iTjRGTlhyT2l5U0VSa0xMSG1Wc3FGSUtiVFZsbTQ0UzhC?=
 =?utf-8?B?VS9FcFMzNy9XWWZpVGVteGtDWWFpMXdGRXl6QzZ6L2VSRjRUcHBPNndDVlZM?=
 =?utf-8?B?Wm5OdXJsNFZUNXN2MkNXdnc2ek9uWlVXS2xKYXZZUHMzMU1wWCt5ZXRZM3J4?=
 =?utf-8?B?WnFMYjlQSVBpTzIva3krSjBVU2V4dmlOTXQ2RXViYUd2NFpyNUl0ZGErQlBa?=
 =?utf-8?B?TWpWeDAxSnBWaHRvRDBJcHRpZzRoSlJGeW05a2p3blZoMmZUOGsxTDJSV3ZB?=
 =?utf-8?B?b21vN3hXOVZ6YndwYWwweUVPOEYvMWJDa1V5YUtKOXpveW9DTlZvaHdtcTRo?=
 =?utf-8?B?L1c2K0tQM1pSU2NWZ0wvRVJSNzE2ZTYyMGpzYzNqc1YzWTJjTVpKdVpVUzli?=
 =?utf-8?B?bnA4VVNxZWFzb20xNXlnNjg1WmJrU1hRbEgxRXFKM0Nsd0xuOGJYeVN5U1ps?=
 =?utf-8?B?N0RJT3FEVEp0SGxibDdYdnRqVWN0SHlaYmExUWpyQ284bHJWbmJDSWt1aGlP?=
 =?utf-8?B?K0ZvTWgvNDZvWTNEZzdLQVc1dklmR3QvQlNmRC9oMnJnTFZ5dzlkZDJVemt2?=
 =?utf-8?B?RnZhZVdGUEJoS1RQT3NBcWlOWmNCWnN4WDNkdXFkbWYxd2piQkd2dXZEcUt3?=
 =?utf-8?B?aGt3NzFYMm9FY2ljYURacURqMTBYdmMzVEFhMVlUSGh1NzRES3R4S0JMdmJY?=
 =?utf-8?B?MWMrVVJqc0trMG9rSHl2VnZWdzVBakU2NXZ6NHFVYTVoK0RyZzVPUFQzN1dq?=
 =?utf-8?B?UnNZcjZmTmhlQWRaa3d5QjdyckRQZklJbUdIUlluU3dwdUdOamcwalNDSHl0?=
 =?utf-8?B?Qmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc948eda-3278-4f20-efc6-08dcc1e5ada7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 13:32:18.7200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g58DpXE5M6cHD847uaMNgpw3w9GU22Yz4e5VsCO02ULNw3betRj686JrgPtOoqR6uJfIZKxO494ePogvhRZ1rGu2rOWBT1j0NKd/1nUbQ+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6392
X-OriginatorOrg: intel.com

From: Wojciech Drewek <wojciech.drewek@intel.com>
Date: Wed, 21 Aug 2024 14:15:26 +0200

> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Add support for allowing a VF to enable PTP feature - Rx timestamps
> 
> The new capability is gated by VIRTCHNL_VF_CAP_PTP, which must be
> set by the VF to request access to the new operations. In addition, the
> VIRTCHNL_OP_1588_PTP_CAPS command is used to determine the specific
> capabilities available to the VF.
> 
> This support includes the following additional capabilities:
> 
> * Rx timestamps enabled in the Rx queues (when using flexible advanced
>   descriptors)
> * Read access to PHC time over virtchnl using
>   VIRTCHNL_OP_1588_PTP_GET_TIME
> 
> Extra space is reserved in most structures to allow for future
> extension (like set clock, Tx timestamps).  Additional opcode numbers
> are reserved and space in the virtchnl_ptp_caps structure is
> specifically set aside for this.
> Additionally, each structure has some space reserved for future
> extensions to allow some flexibility.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>

Thanks,
Olek

