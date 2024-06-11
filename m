Return-Path: <netdev+bounces-102520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9345903745
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 10:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29BB12823F1
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 08:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D7C17556B;
	Tue, 11 Jun 2024 08:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kiOIwP5f"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445DB174EEB
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 08:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718096291; cv=fail; b=UPlgDo9q79OPsYB3CZRjhSpAX3cIf2r4UVaTZc3Pr4p7sFpgz/hLIwFbTCZP3p7kEUMnlzgzcVR89VUqmvQ2H2H3kKG/Suz7lEmC4yeuumdJr+USOI3UD2qzJsdCFLppozwWe4NnbdLR1hlxpW8zVJo7yHMQX7ib/U3T+EOYJ1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718096291; c=relaxed/simple;
	bh=i3aedo0ek7cYMPWF2VPALCJPtcfg6EyfOPr7dPhqte0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bAisXdEQyEpk0295TKBL8+Unhl0GVeh6Z/6qYo9D0q3GY/S3ypSKLiD+1vOA4Jjk/Ac9bWqoCMLgz7StnPBytpCVTLzQfsq8EmvZt1dcc4fAs5UFhut/TNHvoXzUNFj5RfXGQ6gxNxvIIy/unhfVZYHKR5pJT4mXq2U720CRUVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kiOIwP5f; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718096289; x=1749632289;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i3aedo0ek7cYMPWF2VPALCJPtcfg6EyfOPr7dPhqte0=;
  b=kiOIwP5fTq2B6i3mIFYuwPRjeNBjdLmQvu+TMdlZbmoc/43CV2+KCvSB
   RFmcjugfgB/2S7QMu6o4UpsQl4USF6e7rb0d0VTkRf5CEJeyiydomwswH
   AjH/1IwwYz/6JvDR6u1MekCFilaqRzfEi1t31K1eE6JUBNFbjyTKGAZpv
   ue5vkRk+XVwyPIYz+NsQIlsYKHwaIHREZZmW83UB/K0h0iTMqTgMASo3C
   JvAflV2zIskXmiSH7GQjumyOnJi0q78BBESLuSYiH+kOOeKUDklup2cHv
   JUcH85wuDZ6K3vVB8/r9Lgz0p1WJiWAYUnLlCbRB9BMPeCGKThThnwsvZ
   w==;
X-CSE-ConnectionGUID: u3PeZV3UST+ilOhKkAqmww==
X-CSE-MsgGUID: vi7Nw4zlRfq8HJQ+SXW7Sw==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14624032"
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="14624032"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 01:58:09 -0700
X-CSE-ConnectionGUID: tJPr05qzToGqxASynzVUmQ==
X-CSE-MsgGUID: 24vSMmBDSGe1/pGwf4tZjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="39205028"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jun 2024 01:58:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 01:58:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 11 Jun 2024 01:58:08 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 01:58:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3B0f5WjWpB0hNyTOUN3mX03stITSlMBvL64c/eKiMCL9OM7OUeWn36idq1djteDfEja6nxLv8Km0orcEe09af6iLSXdyGgjchDIs+ny263dI5D0XGa2MbNpuV/Dp77fP/LQGTaOiEaujmVqWVmvxRRfFlcl4fkbf8LpIIORa8TtaeAoRYhEhIChDAuUfK5jFIhzO4A6zNhedZ1X2tsbTRSKhkFrs7iNGcHUX2mykgh2lt3l9z4gUctNTNjuOkEZL+4NT/+ZyKa1AkqE3thEvD0218Eh4GGdxRVOMDpg7ykjkcjLXjCQ1UDtfbyFJBiUcL2jqhtEpER7iTwYT2r7CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3aedo0ek7cYMPWF2VPALCJPtcfg6EyfOPr7dPhqte0=;
 b=QRytJ+MyhlKedjwuaHPAMqnc12fbwQL0v82A0IsURy8y2qU12QXFF72K3yP1oCIXHrNwvmo3eezB2EbzcPe8E9PDHp2WsB8GsTM7XE7eh+u4pT9B3vL3TdRTxinI0aG3HGwepFk2VbRmQoXX+YlthKS4wUO8E79k0L3PIlXi6o69swyTnbeHo3ec16HyRyKCZLjAOJnbhkMMos3FV34OujkSKI8UJbLzWaXxzhsg7hmfjeOTff91m2PDnGccWpgu5hYDns5KH2q/zywLaUrprm6m9b3OScJF7LIVBmGMonHk2X/RX4wzDowcO516B4YIrZnukHJ8oJtqp5V+Vaaelw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by MN0PR11MB6134.namprd11.prod.outlook.com (2603:10b6:208:3ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 08:58:05 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 08:58:05 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>, "Kang, Kelvin"
	<kelvin.kang@intel.com>
CC: "Sokolowski, Jan" <jan.sokolowski@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, Leon Romanovsky <leonro@nvidia.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] i40e: fix hot issue NVM content
 is corrupted after nvmupdate
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] i40e: fix hot issue NVM
 content is corrupted after nvmupdate
Thread-Index: AQHauxePZUIIvyLVckGO394neDxrc7HAv52AgAAHF5CAAAE3YIAAAMAAgAAjwYCAAVf54A==
Date: Tue, 11 Jun 2024 08:58:05 +0000
Message-ID: <SJ0PR11MB586653D85AD2BB577620C722E5C72@SJ0PR11MB5866.namprd11.prod.outlook.com>
References: <20240610092051.2030587-1-aleksandr.loktionov@intel.com>
 <a2ad5189-10d1-4e6b-8509-b1ce4e1e7526@molgen.mpg.de>
 <SJ0PR11MB5866360BDA97A03298A4A637E5C62@SJ0PR11MB5866.namprd11.prod.outlook.com>
 <SJ0PR11MB5866699ABC33C1DDCD86A3D7E5C62@SJ0PR11MB5866.namprd11.prod.outlook.com>
 <SJ0PR11MB58660E94611961DC52634069E5C62@SJ0PR11MB5866.namprd11.prod.outlook.com>
 <ea00b2d5-e463-4c4c-808f-5eeb3e0d71df@molgen.mpg.de>
In-Reply-To: <ea00b2d5-e463-4c4c-808f-5eeb3e0d71df@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5866:EE_|MN0PR11MB6134:EE_
x-ms-office365-filtering-correlation-id: 098d9a4b-68be-4005-8c40-08dc89f49ba9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?VmJWd1BGYlo0Q0lhOS9nL3JwMnVpSHZjb24wbXpPeFBqNU1JREJPZzFPYU1n?=
 =?utf-8?B?OXRISWpmdFh3bEZuRFNCZW5STE9ULzAvUy9zejRxSkJzbk1Od3JsYXJodHlV?=
 =?utf-8?B?NFdFUVVwSU1WOGhKK085dGtZTXRIUlM2Q2gyTXZ3NFFqT3hmNUgzazRVTnVH?=
 =?utf-8?B?MWwzL1VGL1BRL1JyV3FuRDhLK245MFZhYUZITk9TdmFadDVBbmNhVnFRcm5w?=
 =?utf-8?B?ZXBnQVF4WVNCeHV6eTl5N1lYSGYwVnJoMmI0RDNwWk16bXh1M2hhV1NSMWNk?=
 =?utf-8?B?ZE16UStOMXNZUXdhRzB3dGFhb2lucndGNWF3bzMxUjBCSVUxWEdtWnJZQXdJ?=
 =?utf-8?B?MXNYUnJkNHRDaCtmUFRDNFJvczlhdEptdkhUZ2M0ZjNTZ3cyNjhHdWRDS0xQ?=
 =?utf-8?B?azByVjB2S1ZqV0xScWNXaTB6OGZKUGFDU1c0cVBzWGRBU05EdXJNSWx5akx0?=
 =?utf-8?B?TUpkL1ptc1JIYVROVnQ0bzFqUkdNZTJpTi8wUXcvUHdzd1hmK040YWg0dkt2?=
 =?utf-8?B?NDNjUFk2aEpiWTZLQzNINnNWRWRQUU45QURYUFhZaHNmaGlnRlYzSVNhQkRP?=
 =?utf-8?B?Wnc0TkNGekh5QThCYXo2Z1J0T1ppcHRucTFQSWpsdGxEbm80L2VQZVduSHBW?=
 =?utf-8?B?WHc0bmxVcUhSL3Uzd1JYQkZkeFRQSjJ6WGlQYk1uYzJ3WkdQQ2lxNEZZV0No?=
 =?utf-8?B?MDI4Nm9hcUt6WXdEOEhnWjdkazN2S2F5c1ZpTlptRUJCTklHM1ludG82dmZy?=
 =?utf-8?B?UjVZd096aDJhYmdXQ0dNSmQ1ZStuQ1BvVXpUeHhKWXcya0FGM2pCVElsRE5H?=
 =?utf-8?B?dHF3ckRiaUl6VzFZOVVhcE5XdEthMkZYalE3UEwzOHJidTdUalROdVVFNVBT?=
 =?utf-8?B?L1VpNml4dHBHaXNiNDF3eU1KZUk5NVQzekNIbngzRFdpN2M4RDFjTTlidVRs?=
 =?utf-8?B?VzBodTArb2tHY3l1dysvUzNCUTFzcXZ1M3lzWnVOOStQMVpjbXBWVnEwSWNV?=
 =?utf-8?B?OGxWdjk4TXRRUWhsS3dzWkhEUlFTNjBBNlN6Nnl3UnFlVVNjU3BCdW1EK2NC?=
 =?utf-8?B?ZUdPa1JJVGFxYXc2dUFhRlFzNXhRL3MrWFc4VjVoUGo4NndoNGRqcDB2K0Nv?=
 =?utf-8?B?aXY0c05GMyttaEt1RHZ1ZFpXazA0TTJtNmpZQUlGWFVZekNiaFBYdm0rcHp1?=
 =?utf-8?B?WDVhbm9aemhXWEJTb08wbnNLeG9Oc0VtV0NOZHJSVVpPS0t1c2lCODVJNTZi?=
 =?utf-8?B?THZqclB6V203dHkzREdBZnlhQzhROEpqaDJjMzU3b3F3T1FoY3VHRmZacHB6?=
 =?utf-8?B?K1Vuc0szZHdXSlJNdGV1Vkh1MktVZ2VINVIwYzhaa3dHZmRPUUp4WXBYVlVW?=
 =?utf-8?B?OWpCU1N0ai9PVTljZmFHVmlTYjVNRGxuMmlCM2pzZ25tck1mYzIxTDBjYzVS?=
 =?utf-8?B?WmdwbWVLVkFCWE1rUFRCZjRrQzdZdEN4SzdIeUpBWW85MjZHZ1FwSWNXazND?=
 =?utf-8?B?UFdBbE5mSXZGeHdlYXBvS2JTSnVjZXNjVGVxbXE4ZmE2K2wyRlczOTlwT2l5?=
 =?utf-8?B?bUhXR2Q4cGR3WFJYaWxoa25ZL1J5d09zTHJrR0duQjNQWXd4MzZDcU5xSzgy?=
 =?utf-8?B?RSt2ME43Q1BCMjRlKzlJcmtEMkQ1RlpJWXdsUSt2VFNiTkVYc29VbXNQcmVx?=
 =?utf-8?B?UHl3NW8ya0F5NXZ4SCtiRW9nU3ZxcjNhSmt0SzREUVRZbXBzN0VEdDZWNjB6?=
 =?utf-8?B?WmI2ZHZ4cS9Ma0wrbWcxRjR4Y25YNm5WTHdQdjVKZFN3V3pLRFJZeDRoK0xU?=
 =?utf-8?Q?tn9hVgHNMU7OwzhugLckwpLw3aHIiJWmWFrk4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmk2cGlGU05CSlRNT3k5b0d3TU1WeFFzcnlvVy9tcllzNVhNVWxBRFhwbzFE?=
 =?utf-8?B?VkJQYWxrOTkzVVE5N2VmWUpuVnVXeHE4MnlXcTA2NHlkYTNkN3hoY0dobHl6?=
 =?utf-8?B?S1pTYllYWVc5T082UUt5bXArRnFQZUxDTFNyTkN0TjJkMGo3bjM0b1k2RHR1?=
 =?utf-8?B?bnRpVUdRMHdiRi9UZ0JVWDJWM1RQQWp6MHAwNTc5NHQzYUpwYXRUQWxpZDhL?=
 =?utf-8?B?NXpJSjNZZWZFSGtqTCtha3VuWmFsQ1puN1VLL0YwTXhoTTFyeFd3R25GY0Iy?=
 =?utf-8?B?a0ZQUGlaMlJuc3drM0prbitqbVNBVlVPRGYyZ3BseUhqek14UzM3OUdwSXZk?=
 =?utf-8?B?RmdzeE5LaTR1WEhaczRFcW5CWkhCYjVSeEt3TDU0enM5cjhWSExVeFFqUS83?=
 =?utf-8?B?MVU5MFZ1S3N0cTF6QkJVTHpHU3JCN2NhYzJ2c3k0SWRRQ0pQSzg1SklzY0NJ?=
 =?utf-8?B?V0cxZHhUMWp0Q2lqTndIS29lcUFHUWhWVkg4S0tPdXNENjNFOHBXSE9qQmR6?=
 =?utf-8?B?RzRQRHI0SUJRZVZ5NDh4UndEdXlNVUFsNHIvbkc1UmFMSXB2dTdNR1VUMWpV?=
 =?utf-8?B?NkgweXIrQldnK0xtc29yOERZVzVkZVVrVUZwcTFtQ1IvV280dXI4dkpGRE5p?=
 =?utf-8?B?OEEzamxaUHlSMEg1UGlUMFZ0Ny9XUjlWU0ZTMmdnN1ZhRlorcVUzaGVkbDdo?=
 =?utf-8?B?K01EMDRpRE9QZU9VRTc4Y2Fwd0RTRGxldURKT1lpMGJHeTBBbEhqbnRkaWJH?=
 =?utf-8?B?UGZJN2FOdmJJeXJwcFB2dDdvRXJjcDhyWCthS2pjODJ5ZWpCWFgyYVFFN3E1?=
 =?utf-8?B?RUpzSFY2ZmJndllIdG5XTldpakdFOWxzNmJacTlMZzNWN2dQOGpONjU2c0hD?=
 =?utf-8?B?NEhGa1JSd1BjT2taUE1iSlljdGNoNHh2bndrMDQvSGllVEovcVpxMTRHdlI0?=
 =?utf-8?B?bXNES3JETUlCRFVOV05aSjhTZUxJMFZCMU8yNFdzbjJHZy9GQWt2TjBYN1NW?=
 =?utf-8?B?V2d3OWd0RG5pS2I5a1U4bTgzbm5Hd0ZremRENlBKdkZGbVRraUI0cDdNeUR0?=
 =?utf-8?B?bE9xaDF1YkVXaWxOaXVvOXdhVDlqNVJlcG13RUxKSjArTEZOSm1YL21WM3Nj?=
 =?utf-8?B?MlBEUVQzY2c5Q2JmMjZrVDdlUXhBdHBkZzQzNGE1cVhBSTNJYXdhc0ZJeVJW?=
 =?utf-8?B?Z1FzWEdnSkJncjh0cm9sOFdXaW13MEdCZHNSWVlEN3NzWkJscW1BMmhvUU1M?=
 =?utf-8?B?Y0pCM3ZjWFpVZ0hoNnVyUEN6ZXFpdUdZWXhFUFRRaUJiaWgxQnA1MndCNy9v?=
 =?utf-8?B?dEoyM1ovQmd4c2hkTkZTSENzRElBL1NXTlJKakY5QytiNjZrRzRoZEJ3eHVH?=
 =?utf-8?B?OUxQZ1ZId0s5UWRpWHJJRHdkUno5NzF1WGo5by9ic3YzNjZBTzN1NHlQbGJZ?=
 =?utf-8?B?L1dWbmFucXpZOWNleWQ2dXpLODlIVmlzUkMwZTRCeHR4c0NQcjhjTllXTzFn?=
 =?utf-8?B?UVgvLzlvcGtwekRmNG9qTTRBaGZUcVcrektlM0ZQK3ovN3hvZTlRYm9va1pp?=
 =?utf-8?B?TDZkaXAxZnU1elNwZDVKb3R6V2plM0JUWkh3dVpVZFFsWVdLNmYwYVlvV0Nl?=
 =?utf-8?B?WmJUb0lsNU5ibmdwWVEvWVFWeWxYV2sxRGVhU2JjbFo3ZFJoaVJJb0ZNSmg4?=
 =?utf-8?B?UHlXcWJ2QVMzZnVsWVR4cjNzd2JwaEhHdUNnUzkyeTlIWkNJNGM1Z1VBMUdR?=
 =?utf-8?B?SEdnNlY5aXRPWUxjZ2pHQnA4YkE4cjdiK0VXMU5yQjhwNmc4aENpaUY3eTBz?=
 =?utf-8?B?bkw3T1NVWkMzY3Mzc3dTRjhYa25nQkMwWEZrVjgzTHNlYVFJbE8wSjVZNGVi?=
 =?utf-8?B?YkRmWkdlL3d0b3VqNGR5RUlmY2EwckplTU8vZ1ZFUVdhWXVsZ2dKeGFEMzNr?=
 =?utf-8?B?YlN4bnVXU0RSSFhnVVNaMXJwUzRqUWdVNmV5dlFrOStha1dueUZTQ0d3OGFX?=
 =?utf-8?B?ZTdjaXpYaDNlQm9uNDNXa1MxcWcrbXlrVDBsd3JLS3JZdGVwM2UyUGdyQnVv?=
 =?utf-8?B?M2VhMGlyUm1ZYWdzRDVSOFhFRWc0cTU3TXQwZjVTWWpWVFFJNlNBL2pwTFFL?=
 =?utf-8?B?bmxCRGVORkdKVWJmK3NEcVdkUXJUcnBDVTEwUHdNUjg3enE1SFJNYml2cTB0?=
 =?utf-8?B?dkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 098d9a4b-68be-4005-8c40-08dc89f49ba9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 08:58:05.6114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: um1K8OdEzHO4fPEa1aj5BRcokE++jyQDYP2DoZ2/vyem/kAnfAVFsTiBvpjupPf56mMv5x/EeaegndzVNj5ypWcTjG1kzLSsdoRJM6lAyIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6134
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF1bCBNZW56ZWwgPHBt
ZW56ZWxAbW9sZ2VuLm1wZy5kZT4NCj4gU2VudDogTW9uZGF5LCBKdW5lIDEwLCAyMDI0IDI6MjYg
UE0NCj4gVG86IExva3Rpb25vdiwgQWxla3NhbmRyIDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVs
LmNvbT47IEthbmcsIEtlbHZpbg0KPiA8a2VsdmluLmthbmdAaW50ZWwuY29tPg0KPiBDYzogU29r
b2xvd3NraSwgSmFuIDxqYW4uc29rb2xvd3NraUBpbnRlbC5jb20+OyBuZXRkZXZAdmdlci5rZXJu
ZWwub3JnOw0KPiBLdWJhbGV3c2tpLCBBcmthZGl1c3ogPGFya2FkaXVzei5rdWJhbGV3c2tpQGlu
dGVsLmNvbT47IE5ndXllbiwgQW50aG9ueSBMDQo+IDxhbnRob255Lmwubmd1eWVuQGludGVsLmNv
bT47IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnOyBMZW9uDQo+IFJvbWFub3Zza3kg
PGxlb25yb0BudmlkaWEuY29tPg0KPiBTdWJqZWN0OiBSZTogW0ludGVsLXdpcmVkLWxhbl0gW1BB
VENIIGl3bC1uZXRdIGk0MGU6IGZpeCBob3QgaXNzdWUgTlZNDQo+IGNvbnRlbnQgaXMgY29ycnVw
dGVkIGFmdGVyIG52bXVwZGF0ZQ0KPiANCj4gRGVhciBBbGVrc2FuZHIsDQo+IA0KPiANCj4gVGhh
bmsgeW91IGZvciB5b3VyIHJlc3BvbnNlLg0KPiANCj4gDQo+IEFtIDEwLjA2LjI0IHVtIDEyOjIw
IHNjaHJpZWIgTG9rdGlvbm92LCBBbGVrc2FuZHI6DQo+ID4NCj4gPg0KPiA+PiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGludGVsLXdpcmVk
LWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZg0KPiA+PiBPZiBMb2t0aW9ub3YsIEFs
ZWtzYW5kcg0KPiA+PiBTZW50OiBNb25kYXksIEp1bmUgMTAsIDIwMjQgMTI6MTYgUE0NCj4gDQo+
ID4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+Pj4gRnJvbTogTG9rdGlvbm92LCBB
bGVrc2FuZHINCj4gPj4+IFNlbnQ6IE1vbmRheSwgSnVuZSAxMCwgMjAyNCAxMjoxNCBQTQ0KPiAN
Cj4gPj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+Pj4+IEZyb206IFBhdWwgTWVu
emVsIDxwbWVuemVsQG1vbGdlbi5tcGcuZGU+DQo+ID4+Pj4gU2VudDogTW9uZGF5LCBKdW5lIDEw
LCAyMDI0IDExOjQ1IEFNDQo+IA0KPiA+Pj4+IEFtIDEwLjA2LjI0IHVtIDExOjIwIHNjaHJpZWIg
QWxla3NhbmRyIExva3Rpb25vdjoNCj4gPj4+Pj4gQWZ0ZXIgMjMwZjNkNTNhNTQ3IHBhdGNoIGFs
bCBJL08gZXJyb3JzIGFyZSBiZWluZyBjb252ZXJ0ZWQgaW50bw0KPiA+Pj4+PiBFQUdBSU4gd2hp
Y2ggbGVhZHMgdG8gcmV0cmllcyB1bnRpbCB0aW1lb3V0IHNvIG52bXVwZGF0ZSBzb21ldGltZXMN
Cj4gPj4+Pj4gZmFpbHMgYWZ0ZXIgbW9yZSB0aGFuIDIwIG1pbnV0ZXMhDQo+ID4+Pj4+DQo+ID4+
Pj4+IFJlbW92ZSBtaXNsZWFkaW5nIEVJTyB0byBFR0FJTiBjb252ZXJzaW9uIGFuZCBwYXNzIGFs
bCBlcnJvcnMgYXMNCj4gPj4+PiBpcy4NCj4gPj4+Pj4NCj4gPj4+Pj4gRml4ZXM6IDIzMGYzZDUz
YTU0NyAoImk0MGU6IHJlbW92ZSBpNDBlX3N0YXR1cyIpDQo+ID4+Pj4NCj4gPj4+PiBUaGlzIGNv
bW1pdCBpcyBwcmVzZW50IHNpbmNlIHY2LjYtcmMxLCByZWxlYXNlZCBTZXB0ZW1iZXIgbGFzdCB5
ZWFyDQo+ID4+Pj4gKDIwMjMpLiBTbyB1bnRpbCBub3csIG5vYm9keSBub3RpY2VkIHRoaXM/DQo+
ID4+Pj4NCj4gPj4+IFJlYWxseSwgcmVhbGx5LiBUaGUgcmVncmVzc2lvbiBhZmZlY3RzIHVzZXJz
IG9ubHkgd2hlbiB0aGV5IHVwZGF0ZQ0KPiA+Pj4gRi9XLCBhbmQgbm90IGFsbCBGL1cgYXJlIGFm
ZmVjdGVkLCBvbmx5IHRoYXQgZ2VuZXJhdGUgSS9PIGVycm9ycw0KPiA+Pj4gd2hpbGUgdXBkYXRl
Lg0KPiA+PiBOb3QgYWxsIHRoZSBjYXJkcyBhcmUgYWZmZWN0ZWQsIGJ1dCB0aGUgY29uc2VxdWVu
Y2VzIGFyZSBzZXJvdXMgYXMgaW4NCj4gPj4gc3Viai4NCj4gPj4NCj4gPj4+Pj4gQ28tZGV2ZWxv
cGVkLWJ5OiBLZWx2aW4gS2FuZyA8a2VsdmluLmthbmdAaW50ZWwuY29tPg0KPiA+Pj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBLZWx2aW4gS2FuZyA8a2VsdmluLmthbmdAaW50ZWwuY29tPg0KPiA+Pj4+PiBS
ZXZpZXdlZC1ieTogQXJrYWRpdXN6IEt1YmFsZXdza2kNCj4gPj4+PiA8YXJrYWRpdXN6Lmt1YmFs
ZXdza2lAaW50ZWwuY29tPg0KPiA+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBBbGVrc2FuZHIgTG9rdGlv
bm92DQo+ID4+Pj4gPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0KPiA+Pj4+DQo+ID4+
Pj4gUGxlYXNlIGdpdmUgbW9yZSBkZXRhaWxzIGFib3V0IHlvdXIgdGVzdCBzZXR1cC4gRm9yIG1l
IGl04oCZcyBhbHNvDQo+ID4+Pj4gbm90IGNsZWFyLCBob3cgdGhlIE5WTSBjb250ZW50IGdldHMg
Y29ycnVwdGVkIGFzIHN0YXRlZCBpbiB0aGUNCj4gPj4+PiBzdW1tYXJ5L3RpdGxlLiBDb3VsZCB5
b3UgcGxlYXNlIGVsYWJvcmF0ZSB0aGF0IGluIHRoZSBjb21taXQgbWVzc2FnZS4NCj4gDQo+ID4g
Rm9yIGV4YW1wbGUgWDcxMERBMiB3aXRoIDB4ODAwMEVDQjcgaXMgYWZmZWN0ZWQsIGJ1dCB0aGVy
ZSBhcmUNCj4gPiBwcm9iYWJseSBtb3JlLi4uDQo+IA0KPiBQbGVhc2UgYW1lbmQgdGhlIGNvbW1p
dCBtZXNzYWdlIHdpdGggdGhpcyBpbmZvcm1hdGlvbiwgYW5kIGZvciBlYXNlIGFsc28gdGhlDQo+
IGNvbW1hbmRzIHlvdSBleGVjdXRlZC4NCj4gDQo+ID4gVGhlIGNvcnJ1cHRpb24gaXMgYWxyZWFk
eSBkZXNjcmliZWQgLSBiZWNhdXNlIG9mIHRpbWVvdXQgbnZtdXBkYXRlDQo+ID4gdGltZW91dHMg
ZmFpbGluZyB0byB1cGRhdGUgTlZNLg0KPiANCj4gT25seSBiZWNhdXNlIHNvbWV0aGluZyB0aW1l
cyBvdXQsIGRvZXMgbm90IG1lYW4gaXQgY2F1c2VzIGNvcnJ1cHRpb24uDQo+IA0KPiBQbGVhc2Ug
YW1lbmQgdGhlIGNvbW1pdCBtZXNzYWdlLiBJdCBsb29rcyBsaWtlIHlvdSBhbHNvIG1pc3NlZCBt
b3JlIG9mIG15DQo+IHF1ZXN0aW9ucyBiZWxvdy4NCj4gDQo+ID4+Pj4+IC0tLQ0KPiA+Pj4+PiAg
ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pNDBlL2k0MGVfYWRtaW5xLmggfCA0IC0tLS0N
Cj4gPj4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDQgZGVsZXRpb25zKC0pDQo+ID4+Pj4+DQo+ID4+
Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pNDBlL2k0MGVfYWRt
aW5xLmgNCj4gPj4+Pj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pNDBlL2k0MGVfYWRt
aW5xLmgNCj4gPj4+Pj4gaW5kZXggZWU4NmQyYy4uNTViNWJiOCAxMDA2NDQNCj4gPj4+Pj4gLS0t
IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaTQwZS9pNDBlX2FkbWlucS5oDQo+ID4+Pj4+
ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2k0MGUvaTQwZV9hZG1pbnEuaA0KPiA+
Pj4+PiBAQCAtMTA5LDEwICsxMDksNiBAQCBzdGF0aWMgaW5saW5lIGludCBpNDBlX2FxX3JjX3Rv
X3Bvc2l4KGludCBhcV9yZXQsDQo+IGludCBhcV9yYykNCj4gPj4+Pj4gICAgCQktRUZCSUcsICAg
ICAgLyogSTQwRV9BUV9SQ19FRkJJRyAqLw0KPiA+Pj4+PiAgICAJfTsNCj4gPj4+Pj4NCj4gPj4+
Pj4gLQkvKiBhcV9yYyBpcyBpbnZhbGlkIGlmIEFRIHRpbWVkIG91dCAqLw0KPiA+Pj4+PiAtCWlm
IChhcV9yZXQgPT0gLUVJTykNCj4gPj4+Pj4gLQkJcmV0dXJuIC1FQUdBSU47DQo+ID4+Pj4+IC0N
Cj4gPj4+Pj4gICAgCWlmICghKCh1MzIpYXFfcmMgPCAoc2l6ZW9mKGFxX3RvX3Bvc2l4KSAvDQo+
IHNpemVvZigoYXFfdG9fcG9zaXgpWzBdKSkpKQ0KPiA+Pj4+PiAgICAJCXJldHVybiAtRVJBTkdF
Ow0KPiA+Pj4+DQo+ID4+Pj4gVGhlIHJlZmVyZW5jZWQgY29tbWl0IDIzMGYzZDUzYTU0NyBkb2Vz
Og0KPiA+Pj4+DQo+ID4+Pj4gYGBgDQo+ID4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0
aGVybmV0L2ludGVsL2k0MGUvaTQwZV9hZG1pbnEuaA0KPiA+Pj4+IGIvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvaW50ZWwvaTQwZS9pNDBlX2FkbWlucS5oDQo+ID4+Pj4gaW5kZXggZWUzOTRhYWNlZjRk
Li4yNjdmMmUwYTIxY2UgMTAwNjQ0DQo+ID4+Pj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQv
aW50ZWwvaTQwZS9pNDBlX2FkbWlucS5oDQo+ID4+Pj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvaW50ZWwvaTQwZS9pNDBlX2FkbWlucS5oDQo+ID4+Pj4gQEAgLTUsNyArNSw2IEBADQo+ID4+
Pj4gICAgI2RlZmluZSBfSTQwRV9BRE1JTlFfSF8NCj4gPj4+Pg0KPiA+Pj4+ICAgICNpbmNsdWRl
ICJpNDBlX29zZGVwLmgiDQo+ID4+Pj4gLSAgI2luY2x1ZGUgImk0MGVfc3RhdHVzLmgiDQo+ID4+
Pj4gICAgI2luY2x1ZGUgImk0MGVfYWRtaW5xX2NtZC5oIg0KPiA+Pj4+DQo+ID4+Pj4gICAgI2Rl
ZmluZSBJNDBFX0FETUlOUV9ERVNDKFIsIGkpICAgXA0KPiA+Pj4+IEBAIC0xMTcsNyArMTE2LDcg
QEAgc3RhdGljIGlubGluZSBpbnQgaTQwZV9hcV9yY190b19wb3NpeChpbnQgYXFfcmV0LA0KPiBp
bnQgYXFfcmMpDQo+ID4+Pj4gICAgICAgICAgIH07DQo+ID4+Pj4NCj4gPj4+PiAgICAgICAgICAg
LyogYXFfcmMgaXMgaW52YWxpZCBpZiBBUSB0aW1lZCBvdXQgKi8NCj4gPj4+PiAtICAgICAgIGlm
IChhcV9yZXQgPT0gSTQwRV9FUlJfQURNSU5fUVVFVUVfVElNRU9VVCkNCj4gPj4+PiArICAgICAg
IGlmIChhcV9yZXQgPT0gLUVJTykNCj4gPj4+PiAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVB
R0FJTjsNCj4gPj4+Pg0KPiA+Pj4+ICAgICAgICAgICBpZiAoISgodTMyKWFxX3JjIDwgKHNpemVv
ZihhcV90b19wb3NpeCkgLw0KPiA+Pj4+IHNpemVvZigoYXFfdG9fcG9zaXgpWzBdKSkpKSBgYGAN
Cj4gPj4+Pg0KPiA+Pj4+IFNvIEkgZG8gbm90IHNlZSB5ZXQsIHdoeSByZW1vdmluZyB0aGUgd2hv
bGUgaHVuayBpcyB0aGUgc29sdXRpb24uDQpUaGUgc29sdXRpb24gaXMgdG8gcGFzcyBlcnJvcnMg
YXMgbWVudGlvbmVkIGluIHRoZSBjb21taXQgYXMgaXMgZnJvbSBmL3cgdG8gbnZtdXBkYXRlLg0K
DQo+IEtpbmQgcmVnYXJkcywNCj4gDQo+IFBhdWwNCj4gDQo+IA0KPiBQUzogV291bGQgaXQgYmUg
cG9zc2libGUsIHRoYXQgeW91IHVzZSBhbm90aGVyIGVtYWlsIHByb2dyYW0uIFRoZSBjaXRlZA0K
PiBwYXJ0cyBhcmUgd3JhcHBlZCBhd2t3YXJkbHksIGFuZCBpdCB0YWtlcyBzb21lIHRpbWUgdG8g
Y29ycmVjdCBpdCBpbiBteQ0KPiByZXNwb25zZS4NCg==

