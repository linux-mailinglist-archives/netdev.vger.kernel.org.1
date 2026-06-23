Return-Path: <netdev+bounces-301301-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KIdlGYRAOmpQ4wcAu9opvQ
	(envelope-from <netdev+bounces-301301-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 10:15:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C81896B532D
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 10:14:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=mF7cUG6y;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301301-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301301-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCD393047070
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 08:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A513BF684;
	Tue, 23 Jun 2026 08:11:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE5C2749DF
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 08:11:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782202297; cv=fail; b=BT+K+R0HMHhPrqN8QF8+ANdf/osfaxcBy39QPz5wlBRNPUW5vh7pSlICSIihDQQna8aosoQ/fQDTA5vS1z0ItJHSm8/TzyxCMy3Vyy6AME9rKnlTPDC0RAVPv2xVMW1IDpBf+3/xMhRKIfllFKEq3MHUWc9/h0SEMklk2yL8X7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782202297; c=relaxed/simple;
	bh=0s0mdqasJIV4uFpWNUgKwd3nxepWaFWZ2iVRx2EOay4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZAqamRI0KduZnkXvgXKmVinH1eVsKnhJBBN6PGhgAvhohAtWd6uBuOQwaMEfexFAFyPBsfOYAwRDUnXU85MQ1WjJGEPhSlxOUC6Iifmqwu44ntjAetgGiNIi0CAz9zAirohGkRogihkBz3m6kIwarxo25JRKVxe5qWGADHfSf9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mF7cUG6y; arc=fail smtp.client-ip=198.175.65.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782202296; x=1813738296;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0s0mdqasJIV4uFpWNUgKwd3nxepWaFWZ2iVRx2EOay4=;
  b=mF7cUG6yKjNlQX5J1Z4AG+QP0UMSL4DIUJGpWpKeoSko+QlICQfKBZuZ
   IMrteEU6tizWIpSx9O6FxZZgJgbS7jftOWNyC5Xqkp4QDq28B0xTchRDR
   UcHPHswENRFDrXm/E6ovFNM6GFUYxvrY6yZEANOUV+7X7D2Vw5kj81sez
   n/IjlZeDYfWsrugKL1uiHhJtGmIPPu5Up6ZPrxGHgR+6Rxkd4g2fPwW0p
   fATLYFYWLSiHk8541Gtuiqam22ObvTFeOMOmVUNZCs4PMHh53Wjz7XU3M
   V5XGjsbzsQR5b1C4W/Hu5/xyeG5anvUB7DFL0vtit7IadMat0wgwXbXzN
   A==;
X-CSE-ConnectionGUID: /1/cGqrrQLiEf0YrpbHx5Q==
X-CSE-MsgGUID: JeM9ktKPQYut8t513VA8qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="86627197"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="86627197"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 01:11:35 -0700
X-CSE-ConnectionGUID: O+677Xw1SLiARJlHzx5hlQ==
X-CSE-MsgGUID: 8UZ/8BrGRmSdzj16EshLrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="287589178"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 01:11:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 01:11:34 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 23 Jun 2026 01:11:34 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.55) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 01:11:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qq1FrlmBxYoKWugSTCoYQpA0s6ro4mo/TMBahvGkFIt5Zcgb6ZsU8ho7dsHJy/Zp4/jKQ3/gWn9MPq9WySOK4ieA+4sm4CQQwaPN2TFVsdsdrHdC7qtD+LXa/iJGF4euGsA16I1zIDmowjLyFJ0BK1Ql3GgCf+iP9+isdY9En6NR5cHoqrHNHdDckCjb38GUL0OQYl+bS1MuOGs3hSfZ8swR3e5lrpaxaKLXb1ft2TCHUtbQt/7X3dg9ry46hqZ41Sa0yVCfO5hIXsktYaIVUloWPPVMiK5TnrdK6W5C686IIlALmUmO3hJXM5VBPwlTEXI1/frlrinmNm6u6BvsyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0s0mdqasJIV4uFpWNUgKwd3nxepWaFWZ2iVRx2EOay4=;
 b=Vrxa5o0Uducx98FG24Au1gldZy7xJnuIeL1uA+3soCzVgl4YB04A/MbV64EGdp7dYAKfuZsqgG8MOLBdSYijXD0ebkW1S1J6omC2GpYmn/02BuoQRxSBLiITGGTd7UMVR1xvV4U9GM+SKMdj9MzYYWtjJ7ozMOGr34hZPD/32EC5gIgrp3a+cyJeRs/RaHwlNySzxm06Id78DFKjGx3Fe9GvUSsjo1QshuQWMvuwSA1OFvk0EQVd7f8XNn8WBgRQ1u5/S/hT7sCWR20fF2DrEqyH+yJBrrxcro7IsGk3eU3xJii2XTmvBBwoEsHrwJ37oPLA/3ZoB0gEvBgSDAAEBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by DSVPR11MB9959.namprd11.prod.outlook.com (2603:10b6:8:3bc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 08:11:32 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%6]) with mapi id 15.21.0139.011; Tue, 23 Jun 2026
 08:11:32 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] ice: reject out-of-range ptype
 in ice_parser_profile_init
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] ice: reject out-of-range ptype
 in ice_parser_profile_init
Thread-Index: AQHc7aka/hU1d5p2rkS0xE5Okt/XpLYwcQ+AgBuDVuA=
Date: Tue, 23 Jun 2026 08:11:32 +0000
Message-ID: <IA3PR11MB8985A8F551D45A4ECBDE912F8FEE2@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20260527071842.11478-1-aleksandr.loktionov@intel.com>
 <c26b9257-97e7-40b8-a532-3fc0bb985a58@intel.com>
In-Reply-To: <c26b9257-97e7-40b8-a532-3fc0bb985a58@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|DSVPR11MB9959:EE_
x-ms-office365-filtering-correlation-id: 8f625cd0-6bae-48c3-e371-08ded0ff0975
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|5023799004|3023799007|56012099006|4143699003|11063799006|6133799003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: LdkxSsB1Etsa+HKE/EDNAY0qZC9p0j3/4drf4FppmX3WuBiVlzn2hhSYCVj9dV8/GzYngPCM9/1GtW4avZZHdsTp+rUhXAsdR80FS/6CMbak8tqcuZ1oNbDAN7nmknH4Dn0B1oTrlsZDKi3Ezh1gJh27D+pZqqRrTfxPsmLIPZtUCQWNw45ognot4pse6ZVnzpeWxcmbooDtYDK+MDYAqjrVhvpJ926Vyo9QQuehG+uy12x4cbMc6fEGQy+V6tTUCeFANoEsj4wgFNZk96T/lCTbPzafld2KW+uiPszDUeKyuPUrEewZo9TqgCHt/TFgVedmRjd50nTjWA/9nvZqjAmZXlBuhMDEfdodPniMOkh/fxnhfSZf14zZyMdUldjm9eElEdVLUBh6NDG16w5LX9qQZoyZzJyNJ6ltH4Y9vlVgBsdIG6ab3HSHM9/juXqJiMU6XRwnjZWRXCpiorHgnO4Lf3JTWoEixRxSKP6gSnTi2KLwje6hG5ZQHtG1/7A5k0hu3pnfTr/z0AJ+9ZMRUc3LgxMH894VhH3hbozUK5iXd3/qglU0ylgEMdMdq6rfpo0UnG60ErEQtUD5l7l4iyTrt3RQcpo1vP8PXmCyCuvNBJRxdv/Jy/ntqdgAGLQAh7sKRnvi/PX2sSh6UdSKc9HXESo76/y3asSaSXIK9NofRaxO3JzF3p2lT8+WybyFPeMFSICRNfOJlkrTEwbPl07yfqrjPdRc9aNC61xtnWY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(5023799004)(3023799007)(56012099006)(4143699003)(11063799006)(6133799003)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0FPdnEreHZjK2pzV09rUWh3bUtlT2FmNStFbTNLTlo2L1JOVURMVnlLdnJY?=
 =?utf-8?B?ZXNIakwzNUZ3ODVObkFvY2cyNndhK1JFMEhBU00xMTVBaFBteFJjK0RDRzd5?=
 =?utf-8?B?bkxIZVJFTjNvekZ1VFFEUUszSTVPazZUaXVkY290NlRMT0t3Y0kvZXRmMzQ3?=
 =?utf-8?B?R3UyUFhCeU5sSjJLaHNpcFVyUGZUSlEwK1hjbWZPdk9IUm1lV3NlWFBocWxE?=
 =?utf-8?B?VkIrNnZjZVNURE44M0duWlU0blo5clI3VnJMZmdpQklJVXlialhYSlNNSGtE?=
 =?utf-8?B?TXcxdUJGTlg0emNnVEVlRnFwMUNJQ0hkT2dXcys1ZjRlbUxyRU42aE1EVnNK?=
 =?utf-8?B?Mi82bncvcDkxRzZsTlhBbExnUERUc2szSWdzbFRCT2JwbWVMOFVPYlNaMkZR?=
 =?utf-8?B?UWJaTy9pTW5XZ053dmdBZk5aNHhrQXFZaFBDM1RzTFV1NWgxT3dpcUt6azl6?=
 =?utf-8?B?ZXkzUi9GZk1uV21YU2hYL3RleXhFUGhVQkpCbDVueHcyRzN5Y0dQdzF2U0xR?=
 =?utf-8?B?RE9YMDFKNmpPK3J5cEZ2a29TemU4YWtjdVJtQWV1QjhrYiszSWp1NzIwRDJP?=
 =?utf-8?B?em5CTFJqeFRxQmFFc0VjRE5lQ2VhUHAwbVRmZ1o5R2Q0cWpMS2plWVhGcXpD?=
 =?utf-8?B?UWNqZ3plYnlsVTJ6cHk0SG96TnQvM3ZySVNSbGRValBNZUFYL0JPUWVnbjF0?=
 =?utf-8?B?OFFORFV5TUJYNVJzQmNCeXJocTVjMzhENkxlNDFCNnhuUFhlNWhVQzVrR2VT?=
 =?utf-8?B?RnBsZWlLT0NYRzlkTXNFM1BGWmt0bmwxNU91T3kzeUx4Z09vcncvZjdpbG5k?=
 =?utf-8?B?aWJqaDNyZEVPQnBVcHViN3NMRWtBRzdaaWN2Nkl0RlRqd0kvRVNhVlVnQTh4?=
 =?utf-8?B?TzJSMnFzOGZHbzZXa3o3RjFkVExSUWhuUDQxVm1nRi9zanVCemp4RFY5VDdj?=
 =?utf-8?B?TDRrSEtTL1pxWHBIMk10VEROejdpR29VMXpMbFZyU2d3c1YrbC9ZejIvMHk5?=
 =?utf-8?B?UEFUa2pUSzJ1c0RRdzVhSjVZTThsTmN2REQwQnFnUHArZWZLNWRBcVh4b0ZW?=
 =?utf-8?B?MFJ4b0ZXQUZ6aGdyL2lvTTRxdVJyenpxSnUyYy90cS9xcC9wNW1HdE9OWGdJ?=
 =?utf-8?B?bWZJUFphcCtlenlxMlVTZFcweGlVeVRxL2JCUkFjTWVnNkZYUG9LN0R4U29a?=
 =?utf-8?B?dXNqc2dYVllDL0o3dmxxSXpMU2ZCeUtjTFJTbCtXcEVwZVM3NFVVajQyZG9F?=
 =?utf-8?B?djJLNVVHREJFVk5pUTQ0OUxseSt2V1VIRWhuNFNQc2Fxa2xDK3BsN2FXckNG?=
 =?utf-8?B?TzdWNFhGaVQ4MGoxZ25WWTI3S3pCalZSVjdMcyt1dW5CdUV1bHhEcmlWVnF5?=
 =?utf-8?B?STQxZGtWbmg0NVcrMTBSTFdBbWtnM3dGWE11NGIxODl2eGlBdUc2UUxPcVRL?=
 =?utf-8?B?YUxQYURvdUlkUjczSlhuS2JUdENScVRKMTJRTE1vYkhDSS9PVmJEUEVHWDEr?=
 =?utf-8?B?eTlIbUpnVzN3RWx6SndnNVhJRzdCd2g2WjdNU0gwSzliMFJ0M0R1dnl5Wm5r?=
 =?utf-8?B?L1RaWStMbzZQT2gvMnZQT20xSXV0SU1pSXpnZHh6Y3MvZklsdG8vRGcvRlhj?=
 =?utf-8?B?cDJ3RlNSV3A2M3N3Y2tuUUVodHpqcDVITzRSNmp4Z0t6dDVYRVdRV0I5dDhZ?=
 =?utf-8?B?dDhnZVI4UXRLcjE4MWRGMjZJbG1hUHpLUmZoU1pGbkxHaTFtR21RaHBteU9M?=
 =?utf-8?B?dW4xd0UyVFdoRG5maWlFaW1uME9YWHdaWGxJazhTbWJGVXh0ZmwySy82VFJW?=
 =?utf-8?B?WDE1RzVQWXM5OUZGalp4MHZpYVhKb2V5dExTSWlxS2ppR2k2VGhqREhOajVG?=
 =?utf-8?B?WFNtaDlTdjBYZmUrL2Vka1lsSUN1SWZSbEJ3QzI4Zk9LUzliUlczZXBZeVV4?=
 =?utf-8?B?aFdXWnZCTXVmbXEwWW5JU25idkszT3orVWZSZTd1TFdqVE1IWmlRanZ5OU1s?=
 =?utf-8?B?UVU3RmlYTVJXWWlqZHkxRlJZaU5Pcks2ak0wZ2g3Nk9WNnZLRTdvcHkvRUxX?=
 =?utf-8?B?Ynp2aklzRXNya2IrR0ZzVnRoelpmbVpJd0dyVVg3eUJlYUx6VlZrWG5lTm9W?=
 =?utf-8?B?M0pxVGZCeE5oMGNBeW9MWUd3ZzMrbHJxTGp3d3JuWHNoeDJOalhWWjNTb2RV?=
 =?utf-8?B?cGZRNjVlTU5GVkZFVUpkMGlvVEdydWllUHJwVEJROG1PZ0hiUE5ya1VhaHIr?=
 =?utf-8?B?KzV2OWlVMjRNcjNNejIrS3c0dE5jMlpob2hMdVFnWWU4L2FVWjRyVkF4YWJj?=
 =?utf-8?B?dXNVaUlsZVpzZVZOU3NkUmlYLzBrQWg1RlEvbnlScWFERHdGNVpDdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KaPRDoXarjw9AuxkFjtIxmexEouZyiG9ta2uL3uiD/tb61O2dfJAo7HMq0B0boFCkrHBcMY/bSccFBvHm0W2RSIgNyJbj2gV79g9otfd5FJEPEIF0DKTYOnXRZ3r/jqJDrBslLNvxIh98PjJXkrm626R/ZSDDK7hyfan/h2mc6/04M1RIyZsnahEYxEtC1g2dFYgz9I2vnd1xbtwT2y32Cu+WwEQ3oQbI9io/6OlGp5zW9zBKXQH1Vs9o4zoVDCympCX2P71Z7ZPeCJ/KrP+CajfA3CBde2+3EzWCQCxXJvlpzhQQ+DzyFExnxFJ8n+0IqKmZZjvPCVarzD/ZpS9iA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f625cd0-6bae-48c3-e371-08ded0ff0975
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 08:11:32.6732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fiZ3vok6/YQ6XQ9Vsa1mVv4W4zYS5s1GB+9YAPYYlPgkIZc6B/tdl9ONTl67OVdYChx/XbJsUDicC3t8RDawzyB3EzKQ/7SMQoV4kN+YQes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9959
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.06 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:aleksandr.loktionov@intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301301-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[rafal.romanowski@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,osuosl.org:email,intel.com:dkim,intel.com:email,intel.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,IA3PR11MB8985.namprd11.prod.outlook.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafal.romanowski@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C81896B532D

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBUb255DQo+IE5n
dXllbg0KPiBTZW50OiBGcmlkYXksIEp1bmUgNSwgMjAyNiAxMDowMiBQTQ0KPiBUbzogTG9rdGlv
bm92LCBBbGVrc2FuZHIgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPjsgaW50ZWwtd2ly
ZWQtDQo+IGxhbkBsaXN0cy5vc3Vvc2wub3JnDQo+IENjOiBuZXRkZXZAdmdlci5rZXJuZWwub3Jn
DQo+IFN1YmplY3Q6IFJlOiBbSW50ZWwtd2lyZWQtbGFuXSBbUEFUQ0ggaXdsLW5ldF0gaWNlOiBy
ZWplY3Qgb3V0LW9mLXJhbmdlIHB0eXBlIGluDQo+IGljZV9wYXJzZXJfcHJvZmlsZV9pbml0DQo+
IA0KPiANCj4gDQo+IE9uIDUvMjcvMjAyNiAxMjoxOCBBTSwgQWxla3NhbmRyIExva3Rpb25vdiB3
cm90ZToNCj4gPiBzZXRfYml0KHJzbHQtPnB0eXBlLCBwcm9mLT5wdHlwZXMpIG9wZXJhdGVzIG9u
IGEgREVDTEFSRV9CSVRNQVAgb2YNCj4gPiBJQ0VfRkxPV19QVFlQRV9NQVggKDEwMjQpIGJpdHMu
IE5vdGhpbmcgcHJldmVudHMgYSBtYWxpY2lvdXMgVkYgZnJvbQ0KPiA+IHByb3ZpZGluZyBwdHlw
ZSA+PSAxMDI0IHRocm91Z2ggVklSVENITkwsIHJlc3VsdGluZyBpbiBhIHdyaXRlIHBhc3QNCj4g
PiB0aGUgZW5kIG9mIHRoZSBiaXRtYXAgYW5kIGEga2VybmVsIHBhZ2UgZmF1bHQuDQo+ID4NCj4g
PiBSZXByb2R1Y2VkIHdpdGggYSBjdXN0b20ga2VybmVsIG1vZHVsZSBpbmplY3RpbmcgYSBjcmFm
dGVkDQo+ID4gVklSVENITkxfT1BfQUREX1JTU19DRkcgb24gRTgxMC1DIFFTRlAgKDgwODY6MTU5
MiksIEZXIDQuOTENCj4gMHg4MDAyMTRhZg0KPiA+IDEuMzkwOS4wLCBJQ0UgQ09NTVMgRERQIDEu
My41My4wLCBrZXJuZWwgNy4xLjAtcmMxLg0KPiA+DQo+ID4gY3Jhc2hfcGFyc2VyOiBpY2VfcGFy
c2VyX3Byb2ZpbGVfaW5pdCBAIGZmZmZmZmZmYzBkNjFiNjANCj4gPiBjcmFzaF9wYXJzZXI6IHNl
dHRpbmcgcHR5cGU9MHhmZmZmIChtYXggdmFsaWQ9MTAyMykNCj4gPiBjcmFzaF9wYXJzZXI6IGNh
bGxpbmcgaWNlX3BhcnNlcl9wcm9maWxlX2luaXQgLS0gZXhwZWN0IE9PQiBjcmFzaCENCj4gPiBC
VUc6IGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UsIGFkZHJlc3M6IDAwMDAwMDAwMDAw
MDAwMDANCj4gPiAjUEY6IHN1cGVydmlzb3Igd3JpdGUgYWNjZXNzIGluIGtlcm5lbCBtb2RlDQo+
ID4gI1BGOiBlcnJvcl9jb2RlKDB4MDAwMikgLSBub3QtcHJlc2VudCBwYWdlDQo+ID4gT29wczog
T29wczogMDAwMiBbIzFdIFNNUCBOT1BUSQ0KPiA+IENQVTogNTYgVUlEOiAwIFBJRDogMTY1MDEx
IENvbW06IGluc21vZCBLZHVtcDogbG9hZGVkIFRhaW50ZWQ6IEcgUyBVDQo+ID4gT0UgNy4xLjAt
cmMxICMxIEhhcmR3YXJlIG5hbWU6IEludGVsIENvcnBvcmF0aW9uIFMyNjAwQlBCL1MyNjAwQlBC
DQo+ID4gUklQOiAwMDEwOmljZV9wYXJzZXJfcHJvZmlsZV9pbml0KzB4MmQvMHgxZDAgW2ljZV0g
Q2FsbCBUcmFjZToNCj4gPiAgIDxUQVNLPg0KPiA+ICAgPyBfX3BmeF9pY2VfcGFyc2VyX3Byb2Zp
bGVfaW5pdCsweDEwLzB4MTAgW2ljZV0NCj4gPiAgIGNyYXNoX2luaXQrMHgxMjcvMHhmZjAgW2Ny
YXNoX3BhcnNlcl0NCj4gPiAgIGRvX29uZV9pbml0Y2FsbCsweDQ1LzB4MzEwDQo+ID4gICBkb19p
bml0X21vZHVsZSsweDY0LzB4MjcwDQo+ID4gICBpbml0X21vZHVsZV9mcm9tX2ZpbGUrMHhjYy8w
eGYwDQo+ID4gICBpZGVtcG90ZW50X2luaXRfbW9kdWxlKzB4MTdiLzB4MjgwDQo+ID4gICBfX3g2
NF9zeXNfZmluaXRfbW9kdWxlKzB4NmUvMHhlMA0KPiA+DQo+ID4gQmFpbCBvdXQgZWFybHkgd2l0
aCAtRUlOVkFMIHdoZW4gcHR5cGUgaXMgb3V0IG9mIHJhbmdlLg0KPiA+DQo+ID4gRml4ZXM6IGUz
MTJiM2ExZTIwOSAoImljZTogYWRkIEFQSSBmb3IgcGFyc2VyIHByb2ZpbGUgaW5pdGlhbGl6YXRp
b24iKQ0KPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4gU2lnbmVkLW9mZi1ieTog
QWxla3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+DQo+ID4g
LS0tDQo+ID4gICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3BhcnNlci5jIHwg
MyArKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3BhcnNlci5jDQo+
ID4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3BhcnNlci5jDQo+ID4gaW5k
ZXggZjhlNjk2My4uM2VkZTRjMSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5l
dC9pbnRlbC9pY2UvaWNlX3BhcnNlci5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQv
aW50ZWwvaWNlL2ljZV9wYXJzZXIuYw0KPiA+IEBAIC0yMzY4LDYgKzIzNjgsOSBAQCBpbnQgaWNl
X3BhcnNlcl9wcm9maWxlX2luaXQoc3RydWN0IGljZV9wYXJzZXJfcmVzdWx0DQoNClRlc3RlZC1i
eTogUmFmYWwgUm9tYW5vd3NraSA8cmFmYWwucm9tYW5vd3NraUBpbnRlbC5jb20+DQoNCg==

