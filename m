Return-Path: <netdev+bounces-235002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F19C2B128
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 11:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C58523ACA69
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 10:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD7B2FDC38;
	Mon,  3 Nov 2025 10:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l5Vtv0NH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05372472BB
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 10:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165860; cv=fail; b=H3kZ76LU96+BiCbowHjTh1XhPRNB28cu87Grac4cM8h25pY5zOJxqZgZfuHw/JmDlTmzhwm8yT5SYX7htaf9fKlKXQlbqSfI2FgCVEgErSXl+XHLgo/66uTvcQj5ouZBGOTJZLMFRsrew7QmE6Xa581EMXdXMoeftdtN0RtLuS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165860; c=relaxed/simple;
	bh=PqhjH6R9z6Ji+SOLMYDDSmnXD09mQ7JneQJqll8QAFY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cSkfrZSx97T613arBDxUijFlw/6K7srlOXWTpf15BOHnq4Xv9hbZ670WZ1LCDNqnkfGWpDTOhTaB2VChVBHZIp0i0IXQlr9XlDXjSHb4zcDPF+FU+W+9j1/jUeXY71nEP6gqqzddHMTC68ZFWjudyXtwht8wxy1Lu871InJw3HQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l5Vtv0NH; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762165859; x=1793701859;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PqhjH6R9z6Ji+SOLMYDDSmnXD09mQ7JneQJqll8QAFY=;
  b=l5Vtv0NHGtlo0MEPibVKR9/vdclQw77FeKajALVNFgpMJluX2B0E4I0L
   e9JrWwtrRdT5zvzlvJBMYsT5dPXVyNX5Q6YL6PNiUEOv301RPOtXcemQB
   W0SI2liKYIYO4qQooPFzHnfB0o2evIx1kTyNBnAjm4mb/8gV1DxotvQoZ
   NGUyQmoTrpurh+D0ewL1EaP6m/qjOM6FayojGu4LW8KepYWe6iR64rUGf
   KNbqPctq+1VbPtBXp1G7GYgxVcT5Bhym8JLTnizNmZPmKRLgUBphRABZj
   gLyhfPSHP6fj/TQDzLTmb0vRNORFJbI982YPjJmjTLlf+sNgMROENbH1O
   w==;
X-CSE-ConnectionGUID: zp2jVejaTiynRE4clp1bNw==
X-CSE-MsgGUID: adYhg4sbTxGRBno6AXVMVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="51807856"
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="51807856"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 02:30:58 -0800
X-CSE-ConnectionGUID: C0RYIoSlTQKBTvQC+/+0hw==
X-CSE-MsgGUID: vehAPMOeSU67C72yuJXBCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="217467922"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 02:30:59 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 02:30:57 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 3 Nov 2025 02:30:57 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.53) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 02:30:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMVXV53kVY/0Qf5E3tdDvpw3II/bkD/98cPUsSEgQfw9vF7ebLy1zNoNC21i9FAf+61vU6EMH0cp3B75BTpw/Zqx4XwatvaG5CGMHMWDgp3s7mUB9Jncc6jikqhChjPGb6mFk7P7eVb2hyrajqicUwoeeEgeS4JPPgqP1CY0wO+XPQIGt2htvN5cIT6KZ9MxH2byYjJCFy5tH031s7/tljAZGya4cZE4a9PHpt6N9giK1X8XAds8paN8mj66CNQqSFz8PxT+Gxq09IqZHMilC8KhPtn37Uw1H0kD+eJ08Zfh66mJlwtz+/HmyjaMoxhNzwCnGj6h8VSMD/gfYfKNgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqhjH6R9z6Ji+SOLMYDDSmnXD09mQ7JneQJqll8QAFY=;
 b=hZVBYpR0YiDnpCgaDQqR7BxI76aRYSwUIOug7DX9b89ar9k3smft2g4cgNMznCAzQ3TFkVY7yoZ3/3OOA9UtaDXAvTLZ4s4vov05509fgmuRDphS3dLEGtQ0slKQanafzy4dwi+4LAr84gdO5tnNM5svhlk/61pLdrZC4kTfXJDnzKrwnsI4dzMj9mG/rrV3TUkC0HtDmdbRG36gh3fnkhuWpMVw8hesp6qb69MKcsmuLznrUK32Qj0WHy/KzKvnr6smPdR4v2mDMbqAzyrTrKpHYTjyfdig3hRn152M5P3EoGRxhnh4hQ1RubvOzgoRq0jNaeFwo5p0AzuCiemuDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SN7PR11MB7666.namprd11.prod.outlook.com (2603:10b6:806:34b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 10:30:54 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 10:30:54 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: "alok.a.tiwarilinux@gmail.com" <alok.a.tiwarilinux@gmail.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [External] : Re: [PATCH net-next] iavf: clarify
 VLAN add/delete log messages and lower log level
Thread-Topic: [Intel-wired-lan] [External] : Re: [PATCH net-next] iavf:
 clarify VLAN add/delete log messages and lower log level
Thread-Index: AQHcTKsdWq40vs4PrEegOewua3v7fLTgwD5g
Date: Mon, 3 Nov 2025 10:30:54 +0000
Message-ID: <IA3PR11MB8986A6E0A4954131F3ECCE3BE5C7A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251103090344.452909-2-alok.a.tiwari@oracle.com>
 <05a823d2-231d-47de-89fa-9648e47cbfa5@intel.com>
 <ce91f141-102c-434d-a8c4-1d8e7ab5181d@oracle.com>
In-Reply-To: <ce91f141-102c-434d-a8c4-1d8e7ab5181d@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SN7PR11MB7666:EE_
x-ms-office365-filtering-correlation-id: f223959f-d88c-49da-4ffb-08de1ac411d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?VWttd3h1c3lSanB4dEhmWkZYdVVzSlJIdU83UHNMY1pQU05SSVA2bnlQYnJ4?=
 =?utf-8?B?eXIyaHJtNzFwSWtNSEFtbXlwSlZvSUIwQkFBeXpWSjZKRGU3dGZ0UzFlWElm?=
 =?utf-8?B?WUVRSDZhcW9CVGk0dEFCOVE2QWh3ZUF0emFaOUhIOWdYNVJMSTN5cE9RRXpk?=
 =?utf-8?B?OURXZ1FiT2NsVE5YL1pPcUtwVUJaZkRKcW1BWkI1d1VkeTVLTE41ZDhhcTg4?=
 =?utf-8?B?NCtzMzN5YUtJNTlQMkR0OFp3VHVERmxpSzNFVTlkNG50Vmpqa0FZRkdMRkp6?=
 =?utf-8?B?WGJHZDJCSVcxQldsaGZIWGJaZDk3OXBKdjJhMFkzMFI5aElkWEZvZXJUT2VH?=
 =?utf-8?B?aXBDZEYwcllSS3dkcWFWUlpndkVWQXVGZGpWZ3dPQUd0dG1rR0RCdGtLVmJh?=
 =?utf-8?B?QVlhemRkMUloWXJqYmMvZ2creHkrTFpsUk9GTEVNSUhGMm16WUp4N3A2M0hm?=
 =?utf-8?B?bjBBTmtaN0NPaGVuWnhHMnhkQndGYmV6QzZrZUVTNExYUWVtZU5oS2RqdU9I?=
 =?utf-8?B?WlFGMnhuOVBLVGRKcUwydW5LUUFLdzVHZ1lra0JLVmQzYVdYNkZ5WlByOHpX?=
 =?utf-8?B?blpLSUsranBybVFmZzlVVGlibytkbFhqSFZlRFNmVTBqRFFqWXJDekdBRnZ2?=
 =?utf-8?B?eHdRekRxaWNrZEYyODh2M3UyeWRiMmVSN2owbmtPaUFrdktvUVk3bEU2b3Y2?=
 =?utf-8?B?R3JKZ001RWpWQm1Vd2VmbVhWblA4SG9jWkZFczd4M2hGbENsL1pMWGJLUFIw?=
 =?utf-8?B?K3A1STQxc1JQTTlUcXNjNlFybFJVS1FTMXI1MmRuZHQwOVBWMDVVUk9uSzRL?=
 =?utf-8?B?cVphdktXMFc3NTI2a1pEUitTbGFaN2thdWs5cGV2Tkc0cE1Gem5mZVZIUUJY?=
 =?utf-8?B?S3paUHIxYVowNUpkZEVId1owdEJQRDZXTy84YmJuc01iSStCbWMrREZYUzFK?=
 =?utf-8?B?WmdKSUZoaGRwZjRweFQ5dHI0Q2VYK3NiOUxmMC9pUllmejl4ZHVLam9JRndL?=
 =?utf-8?B?TTQ1dUh4ZDVLRm0xdFBSRS9wM1JORzBCVHBzQ2d3bDhiZ3NuaVJKTnJrTEh0?=
 =?utf-8?B?SXZVYXYvNTVYbHFxRXlhR3FaMng1Q1htMFVZSEduWUdpalZNU1YrSU1aNTht?=
 =?utf-8?B?cGEvL0JrTkIxVm9teEQxOXZ5UzFKNEx6SFVhTjc4L09FRkFUNHp5aXdhYzl2?=
 =?utf-8?B?dnVEUFBMR0V2Y1lUT2M0K01vK3Q4UjZHRU81QlVueWRtQ1RMYXlEOWZuQVdJ?=
 =?utf-8?B?WEJWNXVINi9HNEJmV2VHejBzVkNvU3psNFM3bm9JYkkycnowSlZQN1ErY2I5?=
 =?utf-8?B?TWM2WWpWV2pjMURqVFQwMFVDbFo1RXF1YlN3aTFSUnpLSEtLdVhrSys5VDc5?=
 =?utf-8?B?bWhrei9ya2ZEMGZ5REhDV2duZnpYVEhxNWFuT2Fhd2pYR0NYZ3hsQlpYUkxS?=
 =?utf-8?B?Z283RDJDN09FdzZ2QXRrUkp6WEMzcHBJbStkWWloSFBBUHpjM3k1YS81MkpQ?=
 =?utf-8?B?STBtbkFxZjZlVEpiVzZJV1dyMW56QVVwcmQxWlZsZXJyZ3VvY2VtY2RDYXpz?=
 =?utf-8?B?YXZrMlJLb3pVZGJraU1mY1o2NE5EMng5RDVhL3YzY0Y5cGNCNG53a3RaTHEy?=
 =?utf-8?B?RXBWQTAvT2JoSlRhcDZkajlYZVlLenhmYkRCUEg3bUpMeTZoNUlYR1NVY0FT?=
 =?utf-8?B?VXV3NDBWSnpPeXh1SEJJK24zOHRUSlF4MjhsNTlvK21SNGxDRWhVSTF1RnpQ?=
 =?utf-8?B?NWVrRjRUZjE1VmExOFNEbjBHNllWTDhlc1Z6RmVDN2drWGN2dEg3VnhkZGNz?=
 =?utf-8?B?OFdYWjFuY3lPQ3VoLzYydUlqZGxUdm4vSTBmZmM1YU9heFJZWFpNMzlUYzgw?=
 =?utf-8?B?cUNVYVFHbXdjYU1pWnJXOXRvQlZucUh4ZHJBOGVvNW9VRDZBZms4WnJ2ZHBW?=
 =?utf-8?B?dXIrMFFWMmFOWlNXRm9sZ3N6RGttM2tuQkZWRXF0dHltTkh0Z2tnT2Z5RUV5?=
 =?utf-8?B?em5qVld6Yk9RPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UElkcTZnanJIQzhjWndmYURpRTVkbVdoRHljNlA0RUNoaFVEUUhTMUY4M2ZH?=
 =?utf-8?B?QndDVVpmMTBaMDZLYmZQTU02d1A4SUluK0lDc1ZRRmhILzlPQ0xzY3pONFRP?=
 =?utf-8?B?bWpkUnE5NWFpNWh1aWxLTGxsYUhwSlVEMnpWcXFoTzB4QTdibStaKzUvM0hC?=
 =?utf-8?B?SDRXSzA5Q2QxeHVId2d0TzN4a1MrMmU3MHNFY3ZFbjdJSmFXMk5xd3grcm5j?=
 =?utf-8?B?b0toSHlLR1VoczZKMDcxU0FaQ2JhMm92Z1liVlhnUDVCdCtzeElmYVJxYWhr?=
 =?utf-8?B?bUsyZmxiK3BGS1V3TGVJMkNBdTBPL1o0bVFKOHBzWkVWSkZzZVlHQjJyb3Q2?=
 =?utf-8?B?QXZ5WjlkbjVYYWtla01qZWE0eWJteC82TXd1YVRwVVNMYTFheUFTcmJvZFpu?=
 =?utf-8?B?TFdtTzJMWUhGZG1HaC95QTZvSEdxeTFhTGJNZDJlWnhSMm5UVUpCdyt6NjA1?=
 =?utf-8?B?NzQ0emROK3NTOUhmYTRES3pPSXUxU0ZxOVV0eGhVaDdqQTU2K2JhelZOcndO?=
 =?utf-8?B?aVA5cEZOQXU3NnR1aHBGaVVOd2ZDcm51L2RxaVNhTk1LMUJ3SE9YbkJ6RHpX?=
 =?utf-8?B?WUFYbWhKbndLODRzUmQyYmlaclVteHhqSlhrREFFWFc3Qkd1SnN0RjF0UmV1?=
 =?utf-8?B?Yi9obnRYdzZkM2hyNDVCZGRDSEs4V1Bkdlo3YlRrQ1F3N1FkMWUxTHlyUHcz?=
 =?utf-8?B?OG1uMzllOGZBSVBTamk1WkJMbEVIalhsU24weEQ0VWJSNUJ1b2JQdkFMM3BS?=
 =?utf-8?B?elJtZ2FuZ3duUzJ1WnpLSzJaeC9Ha1pQVkFsL1FMTkNYN0NZa0Z3NWFTbjdI?=
 =?utf-8?B?OERRRmNmYnFMZ1FvMWgySVhwRlNQQ05zQngzVW95Z3o1Ty9keENSNUhnRlM5?=
 =?utf-8?B?R0JWd3hJNmZkMTlLUHF6SnM2TkwwQ0M0SFF2ZCtjN2VVeWU0cUlHLzMwSTBI?=
 =?utf-8?B?OVdsZnV5clcxM3BNdGJkWER3WGZYdlhzWkVsSFkwOW1IbklRbzFLeldpU3px?=
 =?utf-8?B?YkpDUHZhc1Nnc0YreVFRYkVGL05UNW54QlJ2RXNQTkt2UUlMSzFhRHVFTm5G?=
 =?utf-8?B?WnBEL0RyZFFzbkllQXA2NDNqRHBFNHZ3NFNTbitmN3VMNDJCNmxyRE9uM2tl?=
 =?utf-8?B?S2h2ZTRqUEJIUjRiS0kzOGdZSzNiM2R1bG5PbjRTenJiZkFFWVdTRlVuV01Q?=
 =?utf-8?B?dUFzYmxNdGw4WExJZStRZm1WLytQbkxXem53VzlzYnN2QkZOenVkMFAwS0ZS?=
 =?utf-8?B?bE9RN1lUVkVQTUFwL0hIQUQwWHpWQjhDVmtqd0xWTThYK1c1cWc5Nk9Yc2dZ?=
 =?utf-8?B?Rm5ja1c1cHdUZUlOSnlWcDlmaFBPOU9KKzhVMWc2WTRsU005aCs1UVhIMnpk?=
 =?utf-8?B?YU9hQlVrNjl2Y2plVUhNRkRpOE40Z05CVHMvODBkZXVBTnlKYlJkU0lGWEdW?=
 =?utf-8?B?TWxnYVZxWGNyb0VlVDlmcTJhU1dOV0JORDBFZ2RZNUkvanowM1ZOVUl5TXZk?=
 =?utf-8?B?WTdYbWtsL3JLdUlSMTJRVUYvVVhnWnMyWHZWRzRxVUdGanljd28zMlJjNWw1?=
 =?utf-8?B?Z1F3SGpsTEJUUWdVcUZLSlo5V3ZHWGxmZWNMWjhEelcrR250YWpPTGhqaFhr?=
 =?utf-8?B?KzM0bldMMnRVRWJaSCt1d1gyMHA2ZUFDK3ltSVpkM2JOeEZscThTMmFWdW1N?=
 =?utf-8?B?WWJHd3V0V2MvWVQ4QnIzdUYwNVY1aEppTkRmeUdVRERjVG9TQkRmZVlJUzli?=
 =?utf-8?B?QlMrYlpLV21jSDEzYy9iemRiTkJTeGpHSTdGZG0wY1RiNDFLUHpxbEJrSS9F?=
 =?utf-8?B?YTNyeFFOeWRnOXhqTHFJM0hRSC9jVUIxa3hDY1Z4RWlaRk0zOVR5Y0hRVUNK?=
 =?utf-8?B?TTNJdXQzeUhVcVZzQ3pLd21xV1FVY0plS0Y4NmJBdkd1a2tDZHcyZDAzbFB5?=
 =?utf-8?B?b2lwanBQRG9ITDVqQ0NGTDZhWkpCb05PS1dxNUxURVVNWlZQRk9JbStVeHNT?=
 =?utf-8?B?cVQxTEVGSVJscEE2VTJnMnVsUUxEWmhUeVpybnhzUlBMMUR2MnpxUWdGNTZI?=
 =?utf-8?B?R2c0QlZhK0xnbDN0ZEJwY3pKWUdpUlZsV3ZWd2VzN2wyQUMwV0pZZmtDeDIz?=
 =?utf-8?B?ZlRhNUlyK0ZFekV6Z1JmY0FOWTBCbytYbCtLd2E5RWd5UlhWQStpOEp5YjFX?=
 =?utf-8?B?Ymc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f223959f-d88c-49da-4ffb-08de1ac411d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 10:30:54.7683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 42VcAR3dlXX6GRjHB82Xbz27OxDbQFnacB8nv1ThRzDZID5KGOaLkVMZpQ7U9RPVHpCDM8xg4d5KYHMe6mmBTW8c1+Mb0MuKCzWWYU5wlfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7666
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgQUxP
SyBUSVdBUkkNCj4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciAzLCAyMDI1IDExOjE3IEFNDQo+IFRv
OiBLaXRzemVsLCBQcnplbXlzbGF3IDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPg0KPiBD
YzogYWxvay5hLnRpd2FyaWxpbnV4QGdtYWlsLmNvbTsgTG9iYWtpbiwgQWxla3NhbmRlcg0KPiA8
YWxla3NhbmRlci5sb2Jha2luQGludGVsLmNvbT47IE5ndXllbiwgQW50aG9ueSBMDQo+IDxhbnRo
b255Lmwubmd1eWVuQGludGVsLmNvbT47IGFuZHJldytuZXRkZXZAbHVubi5jaDsga3ViYUBrZXJu
ZWwub3JnOw0KPiBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29nbGUuY29tOyBwYWJl
bmlAcmVkaGF0LmNvbTsNCj4gaG9ybXNAa2VybmVsLm9yZzsgaW50ZWwtd2lyZWQtbGFuQGxpc3Rz
Lm9zdW9zbC5vcmc7DQo+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtJ
bnRlbC13aXJlZC1sYW5dIFtFeHRlcm5hbF0gOiBSZTogW1BBVENIIG5ldC1uZXh0XSBpYXZmOg0K
PiBjbGFyaWZ5IFZMQU4gYWRkL2RlbGV0ZSBsb2cgbWVzc2FnZXMgYW5kIGxvd2VyIGxvZyBsZXZl
bA0KPiANCj4gDQo+IA0KPiBPbiAxMS8zLzIwMjUgMjo1NyBQTSwgUHJ6ZW1layBLaXRzemVsIHdy
b3RlOg0KPiA+IE9uIDExLzMvMjUgMTA6MDMsIEFsb2sgVGl3YXJpIHdyb3RlOg0KPiA+PiBUaGUg
Y3VycmVudCBkZXZfd2FybiBtZXNzYWdlcyBmb3IgdG9vIG1hbnkgVkxBTiBjaGFuZ2VzIGFyZQ0K
PiBjb25mdXNpbmcNCj4gPj4gYW5kIG9uZSBwbGFjZSBpbmNvcnJlY3RseSByZWZlcmVuY2UgImFk
ZCIgaW5zdGVhZCBvZiAiZGVsZXRlIiBWTEFOcw0KPiA+PiBkdWUgdG8gY29weS1wYXN0ZSBlcnJv
cnMuDQo+ID4+DQo+ID4+IC0gVXNlIGRldl9pbmZvIGluc3RlYWQgb2YgZGV2X3dhcm4gdG8gbG93
ZXIgdGhlIGxvZyBsZXZlbC4NCj4gPj4gLSBSZXBocmFzZSB0aGUgbWVzc2FnZSB0bzogIlRvbyBt
YW55IFZMQU4gW2FkZHxkZWxldGVdIGNoYW5nZXMNCj4gPj4gcmVxdWVzdGVkLA0KPiA+PiDCoMKg
IHNwbGl0dGluZyBpbnRvIG11bHRpcGxlIG1lc3NhZ2VzIHRvIFBGIi4NCj4gPj4NCj4gPj4gU3Vn
Z2VzdGVkLWJ5OiBQcnplbWVrIEtpdHN6ZWwgPHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+
DQo+ID4+IFNpZ25lZC1vZmYtYnk6IEFsb2sgVGl3YXJpIDxhbG9rLmEudGl3YXJpQG9yYWNsZS5j
b20+DQo+ID4NCj4gPiB0aGFuayB5b3UhDQo+ID4ganVzdCB0d28gbWlub3Igbml0cywgYnV0IHRo
ZSBtZXNzYWdlcyBhcmUgZ29vZCBhbHJlYWR5LCBzbzoNCj4gPiBSZXZpZXdlZC1ieTogUHJ6ZW1l
ayBLaXRzemVsIDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPg0KPiA+DQo+ID4+IC0tLQ0K
PiA+PiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
YWxsLzQ3ZjhjOTVjLQ0KPiA+PiBiYWM0LTQ3MWYtOGU1OC05MTU1YzZlNThjYjVAaW50ZWwuY29t
L19fOyEhQUNXVjVOOU0yUlY5OWhRIQ0KPiA+PiBNdWxSdmxPdEMzSkFPTi1PODE2X25SMlAyZ2VZ
QkhESXg4NlhPcl9pMWFmYzlnalNyWGZwY1Z3Rm1QNnVNMHAxLQ0KPiA+PiBrRk42NHpCU0xqd1Mz
WHZURFE2bko1UjJoeUlhUSQgLS0tDQo+ID4+IMKgIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVs
L2lhdmYvaWF2Zl92aXJ0Y2hubC5jIHwgMTIgKysrKysrKystLS0tDQo+ID4+IMKgIDEgZmlsZSBj
aGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pYXZmL2lhdmZfdmlydGNobmwuYyBi
Lw0KPiA+PiBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pYXZmL2lhdmZfdmlydGNobmwuYw0K
PiA+PiBpbmRleCAzNGE0MjJhNGEyOWMuLjM1OTNjMGI0NWNmNyAxMDA2NDQNCj4gPj4gLS0tIGEv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWF2Zi9pYXZmX3ZpcnRjaG5sLmMNCj4gPj4gKysr
IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWF2Zi9pYXZmX3ZpcnRjaG5sLmMNCj4gPj4g
QEAgLTc5Myw3ICs3OTMsOCBAQCB2b2lkIGlhdmZfYWRkX3ZsYW5zKHN0cnVjdCBpYXZmX2FkYXB0
ZXINCj4gKmFkYXB0ZXIpDQo+ID4+IMKgwqDCoMKgwqDCoMKgwqDCoCBsZW4gPSB2aXJ0Y2hubF9z
dHJ1Y3Rfc2l6ZSh2dmZsLCB2bGFuX2lkLCBjb3VudCk7DQo+ID4+IMKgwqDCoMKgwqDCoMKgwqDC
oCBpZiAobGVuID4gSUFWRl9NQVhfQVFfQlVGX1NJWkUpIHsNCj4gPj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgZGV2X3dhcm4oJmFkYXB0ZXItPnBkZXYtPmRldiwgIlRvbyBtYW55IGFkZCBWTEFO
DQo+IGNoYW5nZXMNCj4gPj4gaW4gb25lIHJlcXVlc3RcbiIpOw0KPiA+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBkZXZfaW5mbygmYWRhcHRlci0+cGRldi0+ZGV2LCAiVG9vIG1hbnkgVkxBTiBh
ZGQNCj4gY2hhbmdlcw0KPiA+PiByZXF1ZXN0ZWQsXG4iDQo+ID4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgInNwbGl0dGluZyBpbnRvIG11bHRpcGxlIG1lc3NhZ2VzIHRvIFBGXG4i
KTsNCj4gPg0KPiA+IHBlcmhhcHMgaXQgaXMgdG9vIG11Y2ggYmlrZXNoZWRkaW5nIGZvciBzdWNo
IGEgY2hhbmdlLCBzb3JyeSwgYnV0IEkNCj4gPiB3b3VsZCByYXRoZXIgcmVtb3ZlIHRoZSBuZXds
aW5lIGluIHRoZSBtaWRkbGUNCj4gPg0KPiA+IG5pdDogYW5vdGhlciB0aGluZyB0aGF0IEkgd291
bGQgY29uc2lkZXIgaXMgdG8gZGlmZmVyZW50aWF0ZSB0aGUNCj4gPiBtZXNzYWdlcyAodjEvdjIg
b3IgQS9CLCBvciB3aGF0ZXZlcikgZm9yIGRpZmZlcmVudCBwcm90b2NvbCB2ZXJzaW9ucw0KPiAN
Cj4gDQo+IFRoYW5rcyBQcnplbWVrIGZvciB0aGUgZmVlZGJhY2suDQo+IA0KPiBJIGluaXRpYWxs
eSBoYWQgdGhlIG1lc3NhZ2Ugb24gYSBzaW5nbGUgbGluZSwgYnV0IGNoZWNrcGF0Y2gucGwNCj4g
cmVwb3J0ZWQ6ICJXQVJOSU5HOiBxdW90ZWQgc3RyaW5nIHNwbGl0IGFjcm9zcyBsaW5lcyINCj4g
DQo+IFRvIGF2b2lkIHRoYXQgd2FybmluZywgSSBhZGRlZCB0aGUgIlxuIiBhbmQgc3BsaXQgdGhl
IG1lc3NhZ2UuDQo+IEkgY2FuIGRyb3AgdGhlIG5ld2xpbmUgYW5kIHN1cHByZXNzIHRoZSB3YXJu
aW5nIGlmIHRoZSBtYWludGFpbmVyDQo+IGNvbW11bml0eSBwcmVmZXJzLg0KPiBJIGp1c3Qgd2Fu
dGVkIHRvIHN0YXkgY29uc2lzdGVudCB3aXRoIGNoZWNrcGF0Y2ggcmVjb21tZW5kYXRpb25zLg0K
PiANCj4gZ29vZCBwb2ludCwgSSBjYW4gYWRqdXN0IHRoZSB3b3JkaW5nIGFuZCBhZGQgdmVyc2lv
biB0YWdzICh2MS92Mikgbm93DQo+IFRoZSBtZXNzYWdlcyBjdXJyZW50bHkgbG9vayBsaWtlIHRo
aXM6DQo+IA0KPiBkZXZfaW5mbygmYWRhcHRlci0+cGRldi0+ZGV2LCAidnZmbCBUb28gbWFueSBW
TEFOIGFkZCBjaGFuZ2VzDQo+IHJlcXVlc3RlZCwgIg0KPiAgICAgICAgICAgInNwbGl0dGluZyBp
bnRvIG11bHRpcGxlIG1lc3NhZ2VzIHRvIFBGXG4iKTsNCj4gDQo+IGRldl9pbmZvKCZhZGFwdGVy
LT5wZGV2LT5kZXYsICJ2dmZsX3YyIFRvbyBtYW55IFZMQU4gYWRkIGNoYW5nZXMNCj4gcmVxdWVz
dGVkLCAiDQo+ICAgICAgICAgICAic3BsaXR0aW5nIGludG8gbXVsdGlwbGUgbWVzc2FnZXMgdG8g
UEZcbiIpOw0KPiANCj4gVGhhbmtzLA0KPiBBbG9rDQoNClRoYW5rcyBmb3IgY2xhcmlmeWluZywg
QWxvay4NCmNoZWNrcGF0Y2gucGwgd2FybmluZ3MgYWJvdXQgc3BsaXQgc3RyaW5ncyBhcmUgYWR2
aXNvcnksIG5vdCBtYW5kYXRvcnkuIEZvciBsb2cgbWVzc2FnZXMsIGtlcm5lbCBzdHlsZSBnZW5l
cmFsbHkgcHJlZmVycyBhIHNpbmdsZSwgcmVhZGFibGUgbGluZSByYXRoZXIgdGhhbiBpbnRyb2R1
Y2luZyAiXG4iIGp1c3QgdG8gc2lsZW5jZSB0aGF0IHdhcm5pbmcuIE11bHRpLWxpbmUgbWVzc2Fn
ZXMgbWFrZSBncmVwcGluZyBoYXJkZXIgYW5kIGFyZSByYXJlbHkgbmVlZGVkIGZvciBzaG9ydCB0
ZXh0Lg0KU28gcGxlYXNlIGtlZXAgdGhlIG1lc3NhZ2Ugb24gb25lIGxpbmUsIGV2ZW4gaWYgdGhh
dCBtZWFucyBpZ25vcmluZyB0aGUgY2hlY2twYXRjaCB3YXJuaW5nLg0KDQpTb21ldGhpbmcgbGlr
ZToNCmRldl9pbmZvKCZhZGFwdGVyLT5wZGV2LT5kZXYsDQogICAgICAgICAidnZmbCBUb28gbWFu
eSBWTEFOIGFkZCByZXF1ZXN0czsgc3BsaXR0aW5nIGludG8gbXVsdGlwbGUgbWVzc2FnZXMgdG8g
UEZcbiIpOw0KDQpTYW1lIGZvciB0aGUgZGVsZXRlIGNhc2UuIERyb3BwaW5nIHRoZSBjb21tYSBm
b3IgYSBzZW1pY29sb24gaW1wcm92ZXMgY2xhcml0eS4NCkFkZGluZyB2ZXJzaW9uIHRhZ3MgKHYy
KSBhbmQgYWRqdXN0aW5nIHdvcmRpbmcgYXMgeW91IHN1Z2dlc3RlZCBzb3VuZHMgZ29vZC4gDQpU
aGFuayB5b3UuDQoNCkFsZXgNCg==

