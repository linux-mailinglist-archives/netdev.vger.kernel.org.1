Return-Path: <netdev+bounces-296831-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rDE9BbRoJ2pewQIAu9opvQ
	(envelope-from <netdev+bounces-296831-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 03:13:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8196C65B912
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 03:13:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=i7B+4YGO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296831-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-296831-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F0049300F5DB
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 01:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC5A27FD6D;
	Tue,  9 Jun 2026 01:13:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319731DE8BB;
	Tue,  9 Jun 2026 01:13:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780967600; cv=fail; b=ZSxN2ofFr076CxDESt4d1eME6LGxQkvxFdp+q/pfm4cSGad4OANB2eSklA8xWExV+n+bM0NDQ7Gk07hQYst3/iyAQ6DSnNDt62btpKeaSOgICCgVZSF96gBZXkKqMeIXVCN0P481ZdsKhMUOy66D3VRHjKpfOnRHMPCdI8xlpd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780967600; c=relaxed/simple;
	bh=5Z8M9oRs4fRtZYvt8MPZlsPBLYqjC+rtNBb/aIQNohY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JewaNlI3eSaAqXVxM13ed2nXZF0lsnhT7VnkhnBQ5y1xtzivlYhjiKR/VEbl8fBu2Rbi6hqFkFCMXtNGmPf/VCbNdz7Dxxpy154fXBxyXjIYXa5VN6WQKcL60WsZgWE9guxx7gVI9OvncBHPun10DDb+tljUQR2Cnm7j43qCPbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i7B+4YGO; arc=fail smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780967599; x=1812503599;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5Z8M9oRs4fRtZYvt8MPZlsPBLYqjC+rtNBb/aIQNohY=;
  b=i7B+4YGO30a28DmrE7yZxlmg0W0zoVuUqoeNHW02Fp/bTdeis0I6URFz
   HBpendjWPzvAJw4L9Wz7Vzl8OmzOSkfn6+l+cmLrSPdgxOgC4n7EI7GoU
   JMigzIbwv8stP4BV1oBPQFwUuyK1/6CydVkhbS2daRM+DqSjZjQjpP3GN
   j/atJ3XPsULa8YA3P+vd/eAxEJw8gvo/QCEHdRN2Vpwsy3B8MB+ilLWR0
   2+o9lftFlfu+kN/d2x5wAkMxxwfulQUlhGzJUE/iGRMwOqOGj0jssf82C
   NpzZG+xe+IIqkCP1Yn34yfOAWQv03IRA8IqFUkOpmQ+P5rpVNauOfd5zt
   g==;
X-CSE-ConnectionGUID: JIYZ3cOYRyiE34lhx1nAnw==
X-CSE-MsgGUID: ZjbAtfh/RFOLEfov+UihqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81904640"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="81904640"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 18:13:18 -0700
X-CSE-ConnectionGUID: b7DluiAwRfCzBsgg8Mpujg==
X-CSE-MsgGUID: ZZNIxiSNQLqPCLu5CSUYVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="245804675"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 18:13:19 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 18:13:18 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 8 Jun 2026 18:13:18 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.48) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 18:13:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U1nJbElTVqNsASHjM4Xv6x3sop2li0FmTzCxguyZ/34CjRXJ98SttM8pU6BzPEhGBMfasVqN6TawP/DCbemmSDyZZJB7deupZuVG4S+hwZwsmSwQF1eDLd6z3HKd0LN6pudqbvcFUh0YtqzjfM9vcgp52NKsM1ATt/WNDQJSeLGrn0PTigGBqm8OWiZaKhTTwH9EKItnGaOndR9Rno8BjyqejOU0ojQRwqiSUlWefEWgjgH62hNY2Kq7kWGfFvuEEKBxpcNfrOc6Fm3bp9XaVhRCWh+QFy0GHgIHr7c95NE0GiuhWrc6f08uJIxM83XcGFbELb0wPwCt3S03H9HVmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQ8dmnpsKzGu3v+Y5F/BgUb9wXTAiNgEN/XGkDtUNTQ=;
 b=PB5Jo7hyyLJXK6oR+xFFKFl7FF4GpN85JFx0W8Yoi7nkhrd89vkYzIVKpmHv1PJPlmrfZ3Q0zIH9p7fyQV/LMKEJximHDDrpxEaI3AdUKyUgayO+1pUlZIvWe913DARtlURwzFExBgikDJultuYVLYGOj8W6SIz2hCE1YWS6r3WnHfsdjj++AMSjsVtyOd4+9Q+k3Qtdt2F0WKNNNRYDk7oqWni5i0JFsA7FbLRt+XYUhTVTMORgmyPFfD3wfJqLJh4AHqLfCegi7zdiB4enrvceprrBaICmpfOSWQyHeFppX9esdVxVHPFZEkQ6gNKb/f3K33Cig5S+2sq53XCspg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7364.namprd11.prod.outlook.com (2603:10b6:930:87::14)
 by BN9PR11MB5290.namprd11.prod.outlook.com (2603:10b6:408:137::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 01:13:16 +0000
Received: from CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3]) by CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 01:13:15 +0000
Message-ID: <a04993d0-fdd3-47cb-870c-e83faeb153fa@intel.com>
Date: Mon, 8 Jun 2026 18:13:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ibm: emac: mal: fix potential system hang in
 mal_remove()
To: Jakub Kicinski <kuba@kernel.org>, Rosen Penev <rosenp@gmail.com>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, Jeff Garzik <jeff@garzik.org>, Roland Dreier
	<rdreier@cisco.com>, open list <linux-kernel@vger.kernel.org>
References: <20260603230821.5619-1-rosenp@gmail.com>
 <f49d5ac6-ef78-4530-a420-d94e612581aa@intel.com>
 <CAKxU2N8oh03r2-zJhbOXF0Qqx7RzNSX=zq+i6Ld1c9YXJqDfKQ@mail.gmail.com>
 <20260608173638.74da73fe@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260608173638.74da73fe@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0292.namprd04.prod.outlook.com
 (2603:10b6:303:89::27) To CY8PR11MB7364.namprd11.prod.outlook.com
 (2603:10b6:930:87::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7364:EE_|BN9PR11MB5290:EE_
X-MS-Office365-Filtering-Correlation-Id: 07ac29d2-eea5-4495-c0bf-08dec5c44898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: AXAMcRyt+vzQ/t6V99C+fJV9+IYt+6sQWxHgcjSiUUB9y2pzY9hzOwXNm6xMGleDmOcA55ZR2IE6FDguHX4NMNtHtVn+dV9jnnCNzLpjpzTLw3INxylak/7ORGPtDiu46yhOaWcb5Js+snPWRF09udvT1w6Qro+FkMMRp21WsmwY1Jdk6egXTd3jhQeSg16eYPfY9m/7ksHZC1ytKX2coQk0xsHs4ENQIHXOiGuPSNug4RLXYeMRc4SSyj9nQicL6KsnUnBhSEZ/UncUZOgk2jjkX0nwUELNEi7L2UuYFBGEd4akTRmOUsyPARn1Z/RrteVRsiuHo+8IwXVBpor24RKRwE01SHTIuW+8ERPzHgNwAntKstcvNbmvUMYJNEDHkt+T9Lf/JhIGsNywft2bese9/C7vFmjXCm/gY5StcW1+JfTbCksuWeEZ1eRFfeveMjRZOmnDXDehnKpMLCkGtACUWW+ug8f3IczzkrbdT1D8ZhpYNCYB/4asnZNdRKlKmNc6aYfXFzD1t6keNdjNuYBGyoDztAThpEmGtQAnknWPAak2PXqtXzi06DW9Uu4YDBK5UmJulOsmgP5E6Dn/ssxoyWfP0sQo+OobVu08fK6iPnGt0s6AHDk1dvrVNfB1m86ZIh3XbTGhDlyQ1rwpB2nFYcCMIm2p4K/XeSSZwmzaD/sByb2E318yOSEbLXTq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7364.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3dOV2N4OGxhQWdNS0owRzJ3VUpoei93Nm1HUnNsSEZ3UUN3OWY0YVE4RXNi?=
 =?utf-8?B?ZUZLMzlHWnlVWk52S3VYaXlyTnFQMXdtcndLUlRjNVlGRjJpbThmVVgvb1dG?=
 =?utf-8?B?dTNtVVc2MWpTcEx1YU9tYmh0YVVXb3BMLzBPay96c3NERzhoLzhybktTNHRV?=
 =?utf-8?B?dUlwRmFXTXQvMTYyUWFBNHc1OE1DbFkrNnBLcDNZUGhLOGRlVmpOTFlwQk0y?=
 =?utf-8?B?V1FKNit3RUZvT1RVRFAvYk5TTm1WemhoK2wwOTlIUU9WaHk0ZTB4YnQrQXla?=
 =?utf-8?B?MUpYTkF2aHNLa25NWUFyM0VXNEV5ZG1IN01NY1E0MHo5VkMzbEprY1dlWFJF?=
 =?utf-8?B?RU10dElDZzc4ZGFPOCsvWXhPZXZsUjM5TmhqODdMZ1hSaDJGM0FRSjY1S2U4?=
 =?utf-8?B?c25SaHkyOTlJTEtwS2NsZXFJbk1hdGZNTWlZbU5UK0tpdExtemdHVVRCdHMx?=
 =?utf-8?B?VzF4ZmR0clE4L1NiL1J4OWs1eitrUWJXekplRlVwbjRVWDRXTkI4TGVJRi9u?=
 =?utf-8?B?UjJjQ1JVRDBMV1lyT09wMG9taVhuZUpsVEt6aEMrZkZlUldQNm1RUHUyZDZk?=
 =?utf-8?B?cjR2U3p0U3M4SG1PNUlORmJGeEZKMGRhRHlOQXpoQnQyOExnN0VocVd0Rmt1?=
 =?utf-8?B?cVpwYW0vdUFUOWVwaUdnVnA1Z0ZiM1p3NVBET09tL2JESE90WUN4NFBsMndn?=
 =?utf-8?B?YjV0bnpPdDRZUWxhWnN5cit1K3F0MWowcDJ6cktDV3BIK3ZjeHVWR2FsYzlX?=
 =?utf-8?B?TmNaT3pETlVrWXZqVDVxVTA2UEpBVjA0czlsS01WSzRMRWhaOTdJVUM4UTRt?=
 =?utf-8?B?SWNWTmwzQlZiTXB3Nmp2MHE4cGUrNG5EOVdPRllWWVJlVTRjK3NKOTBxV0RT?=
 =?utf-8?B?aWhoV1VRdmg2NC9UM0hETlZXSEprakRPbXpPYm13VFFkWjY2RGJRMDlIaVFq?=
 =?utf-8?B?VUI1d1hXL0tHWDdTZkRUUWdWcUtGSCsxL1JXS1JWd1dQbmw0SkxOTHgzMW40?=
 =?utf-8?B?M1hXNWExbTd3QVgrdGtTcTcvNHJLN3lkQm9pSjFZUGVHVThuZW5OYU53V2dq?=
 =?utf-8?B?bmlrR1NIOWRDMnVsLzN4eGQ3VklYWGhCUWV5S3BLeEFzelB0MjFpVzA4UXFm?=
 =?utf-8?B?NTQvTkRlcGxzQnBJQ29PZHpWaDM3OHE5WE5MVHVEVkhrNmRIcGpQc2NJck5q?=
 =?utf-8?B?UVpORHUrV054M0ovZkMyY3dpa1R0eUpHRUlaWDhCZzlTSnBUL05ZMC9ieFBi?=
 =?utf-8?B?YXNtazd4cDR1MUlFdEFqeU5KeG10VTZBVHJhRk14cTVEVDFzbXIyYWpRM3dW?=
 =?utf-8?B?d0x6UjlUYXY3MXBGRUhqdkFxMGFpN0E5cmVJTW9OcktidmlhY0h0OE94MlRY?=
 =?utf-8?B?NHpKekpaOXYvYk1yakY4UGhUQjAyRlFXL3BEb3ppUUtwL2hDNDJaVHRueG1p?=
 =?utf-8?B?SC9qU1BZWlh1M2NwTWJQL1lSZHNOdGVPUm1SdGZLdVcxYTRjRjM0dTk5aFJi?=
 =?utf-8?B?dVk1N0M3ZmFjZ0lWQ3doRTMzL0lXY3REMGFQZ2xlZE1FT2syY0RvYjRhQ29P?=
 =?utf-8?B?aUJZcUVLRGk5OXIvU2xjSEEvd2Jmdk80SVBsd3NjQkoxV21UYWgvcUNLRmRV?=
 =?utf-8?B?aE9udDZJRHNSdmtxWG10WjZPTmk3eHd0U2VMYlBqb1hPWGN3a3JtWUtMbm9q?=
 =?utf-8?B?REg4cHd1enBNNmZEUmNNS0R1dDJXNklHdlhrQldNMU11SzhRS1JoUDYyRGR6?=
 =?utf-8?B?bFVzd01ub1oyc1FvbDZxbytibk4rNU1mYkRWZWw1NzRvMGpLYnFnR3UxSVVH?=
 =?utf-8?B?QVY2Y1I1VktGSEZKUFF5NDk4MGwzQ0hEMmJXUGpNd0NDOVVCZ0xaREhyaWJM?=
 =?utf-8?B?QzlJSXQ5TGJINjdDL1F0UGlwMXBzbGJ1VkQ1QytSanlteXR2UDljNDJTQ0Vo?=
 =?utf-8?B?SFBaRlZMVTBwalJ2NXpBSXZxRnIrajFmYWRaUXl5OVArSXMyaUVnSTJhQUIr?=
 =?utf-8?B?QnZSUkZLWUZaQloyb2d4QWdCNGwzSW9ZRHk1VkFIWGlkL3ZFTFV4MHpxajdr?=
 =?utf-8?B?VmkrUzU4d0QyRGpEdGRyb2p0RHlGeWdRaDdvdlVoRjhLb01pM2dXc0M4SCt2?=
 =?utf-8?B?NXVxajZ1VUh5SysrOVloRmxKbVplelN2eGtZZEJrTUorZHJ2TC85NUxvOXYy?=
 =?utf-8?B?bXhQR05pellQa1BVZlViL0RodFllamx2cjEwZWlrbTZ4TXhKZloyUDRqREI1?=
 =?utf-8?B?MTMwbitXM3daa09Eb01MVThoY1N3bTQxcEpjWGV0YjhxSUdFSFJRSmZseXhH?=
 =?utf-8?B?aE96enBIL1BESHdBcmZzVVRLZlVUWTl3ajBON3dGV2lCaEJpUlR2QT09?=
X-Exchange-RoutingPolicyChecked: IKzyvqpy/uD0uwiUnfqZhRZqQ3IsHx7UeT99w1yXi7UUEI3JO3yr7hfpfKBFrQYqRRU5FD68zTnf7VNCQzC/HxQeRPtbXmb0xcqi7LkAe6RwZwH7U2oBVGgtnnoq0YUcNumTpBO25fWzqbNV/SCB2U33uSrKecOjdp0DJKVnUs3k84y2HNWJ8RRFhVORAWAOQOp+QOfBJ84E543uxbH6DQP6XkzbYPVjN7o0W7fobhBXu+NoS7WL0BwksuNasnhCThy62BvxkNtJk8+IgKzt+wbh7llEuJpqvjEywmFByYectHDzhSxtgkjSd5bmzRjmwXxN8nwIxSpYxpN7ngwcIQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ac29d2-eea5-4495-c0bf-08dec5c44898
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7364.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 01:13:15.7872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQlevE4JT6yCW7gVLksRh18bPn4KEoyEEmvkWSWnUGHmvB7jqo5n0yG/PB9IXipOR4sSz6ivkvFd25Fj1oIjjQV8MK0Y9BVp99CD0cEvCpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5290
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296831-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:rosenp@gmail.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:jeff@garzik.org,m:rdreier@cisco.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:dkim,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8196C65B912

On 6/8/2026 5:36 PM, Jakub Kicinski wrote:
> On Thu, 4 Jun 2026 16:03:43 -0700 Rosen Penev wrote:
>>>> -     if (!list_empty(&mal->list))
>>>> +     if (!list_empty(&mal->list)) {
>>>> +             napi_disable(&mal->napi);
>>>>               /* This is *very* bad */
>>>>               WARN(1, KERN_EMERG
>>>>                      "mal%d: commac list is not empty on remove!\n",
>>>>                      mal->index);  
>>>
>>> This one doesn't make sense to me. The list_empty check does a WARN()
>>> indicating that this is not supposed to happen.
>>>
>>> This implies that list_empty should be true, otherwise we'd see a WARN
>>> every time mal_remove is called.
>>>
>>> But in that case, we'd have been calling napi_disable incorrectly in
>>> most cases where it was previously unsafe according to your claim.
>>>
>>> At best, this list_empty check is the wrong way to tell if the napi is
>>> disabled, at worst, this whole change is pointless.  
>> I asked the AI. It doesn't agree:
> 
> FTR I agree with Jake, the patch seems to indicate bigger structural
> issues. Then again I don't want to encourage the stream of patches
> to this driver so let me just apply this..

I don't see how applying this discourages the stream of patches?
Wouldn't that be encouraging? I guess you don't want to encourage a raff
of future changes to try and fix the overall structural issues? and
instead accept the small fix here?

How plausible is it that existing users have *never* called mal_remove??
If the list_empty check is to be believed, we shouldn't be getting to
mal_remove with list_empty being false... (since that implies that the
co-macs are still registered) and users would see the WARN. But if we
are getting here with list_empty, we stall indefinitely.


Ultimately it is that which is bothering me. It feels like a classic
"how did this *ever* work???" scenario...

