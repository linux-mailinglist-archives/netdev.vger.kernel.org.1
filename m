Return-Path: <netdev+bounces-303013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J34JJXJ0Q2rKYgoAu9opvQ
	(envelope-from <netdev+bounces-303013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:46:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BFB6E156F
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:46:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Y2sIgNW2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303013-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303013-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2BFC300A117
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 07:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF6C3D7D9B;
	Tue, 30 Jun 2026 07:46:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844FD3C5832;
	Tue, 30 Jun 2026 07:46:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782805616; cv=fail; b=otFxMcZQlQh9PPz43zHWRxFGqclNztcXIhsWV/FGH+xZylqFFxvX192D1mWxhqKMfulETmONxMnEJ56LwBZVgO/ctyP5iO1TVbNC51TxppGBdBIsxhkuRZM3wsRj4JccAheCSd3qCOt7RVKB42feQUddq0rIu9S6nbfKk/xIdhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782805616; c=relaxed/simple;
	bh=wBteS4OZlip9lmdmP/s/K/YVcUnxClrdJj67I8OB6As=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VGl/ukhocmoIxlw+ezHS89PGOYgfPgeXwetBnN/vcghpSFXoRCHecfCLDih9psPzBFnm3fu5x8D0dYa0WEgHdYl77/WMOCagiKGzzXjbvvPkhE3in8Gdkv0c8BW2K6qh8331kdjAUKCABBSt98fmRdi8YZXuDXTu9xSjOW0ibJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y2sIgNW2; arc=fail smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782805614; x=1814341614;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wBteS4OZlip9lmdmP/s/K/YVcUnxClrdJj67I8OB6As=;
  b=Y2sIgNW2ynAeR7EGknOQaV8AIVwadRKHHWumtY74/iB0AA6Ce0vPX7Vx
   rYI8MHk7iWJz4FEdh7M1uwS011FWHTCYbtEkhQfjfFiZ7+MhCz55FO2jB
   ICQonUTP81/m6SYhLeeHkD6DvLNQFIic9SWYYD8HxyLgjWAoLDKKxNaB1
   PM5x+F9JTyLkmBQM5/3C6QeMB2UwZqA7GoBH1c/HNdsvbga18/K/rVP9J
   gaZBBk/8Q1HOapNxe7aPySd3DgYH8r1SrXzKXuAwc4Vzqa9/o37S7t80l
   t2S6UdzigLcmpEigjJk8tigRqG87r/IR3QGnGCoLA6D7sNhiInHsn4tLo
   w==;
X-CSE-ConnectionGUID: KvJbWw/dTJy/3jqVQiC6Aw==
X-CSE-MsgGUID: roC1PDpFS6yu+DH3sRGvbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="101055358"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="101055358"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 00:46:53 -0700
X-CSE-ConnectionGUID: r16WJhEnTGGY03grKkMzwQ==
X-CSE-MsgGUID: PcZpC08VRDqH3Cbz8z9+4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="290307640"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 00:46:52 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 00:46:51 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 30 Jun 2026 00:46:51 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.62) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 00:46:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PKRT1/5YFcL61xwJc7ETdZPTePCPZeL4HNLMIJr+kY0ObZK2xNqAP+limEpjvalu4kGsrE6FFYjrSo3uede5r64O2tSPGHfuuqfh2zwDsYZPHXdddI6ZXdgOyA6Nst2FUt/6woi2dhDQxuTeFu80Iy95hRJslg4Qc2JWPAf5jy09sCq6rMDolYk3AmUf9bpv6F6+/gV9yq0l5RQbEId6QOkICMdk2Z8WRICV+IV+c8DIqXaVxd/u9zLlK0E040qSpmZ4tKdU/sPh/bOXFwmTuU2iLUt7S6Jzg7KTJ7cASnNGGs/5s/r3Ed+hOE0gI3ZBgn224zR8yi4rFdBXbxHBEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBteS4OZlip9lmdmP/s/K/YVcUnxClrdJj67I8OB6As=;
 b=f9JttLDIM5CRq9E+fCwCZzyb77R+2udAFzkm1cBUeSpwDMLFCBqI67tAyDsVdMnQ+NfUDyRzMljh658NxvcOHmrQicdQZle1fHW6JR6PgM4TF3hQ2EMH6YQUMB9Geld/omTtwhWRtqSlNvpg2MU2cqeUz42Ytbffj6wKqnqu/l2rfVkvAZNvZXjVSRxWL6zXPfAwvXZyXayhIV2K3FYVCVPx4ubRmpPmIz8+MQ7lPgw66k9H6xwD5psE388pAuNfcYMyB3MgRJM8bNqnlPg4yoVogToOj2nucSZqV+MBgUf34EY7li1lM4mWbucPk9P72fW8KQug1zm96H5V2WMiVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by LVUPR11MB9567.namprd11.prod.outlook.com (2603:10b6:408:39e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 07:46:49 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%5]) with mapi id 15.21.0159.015; Tue, 30 Jun 2026
 07:46:49 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Yuyang Huang <yuyanghuang@google.com>
CC: "David S. Miller" <davem@davemloft.net>, Cong Wang
	<xiyou.wangcong@gmail.com>, David Ahern <dsahern@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH net-next v2] ipv4: igmp: remove multicast group from hash
 table on device destruction
Thread-Topic: [PATCH net-next v2] ipv4: igmp: remove multicast group from hash
 table on device destruction
Thread-Index: AQHdCDeOM2gICSgY2UCzbymiecKNXLZWtzJg
Date: Tue, 30 Jun 2026 07:46:49 +0000
Message-ID: <PH0PR11MB590210EC36E866B973378054F0F72@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260630022325.1556638-1-yuyanghuang@google.com>
In-Reply-To: <20260630022325.1556638-1-yuyanghuang@google.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|LVUPR11MB9567:EE_
x-ms-office365-filtering-correlation-id: 33d325a8-58a3-42f9-c082-08ded67bbe51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|23010399003|22082099003|11063799006|18002099003|56012099006|38070700021;
x-microsoft-antispam-message-info: 88XpWo9oWflSGnvk7AUlQu1xLm9Pq6OlzKNeedPvI72P1ZxRIXV1UfLX0dodbInUp7vbhQL0YPNGc9Q/ALhNOAbS1zhDhHaPh5rcDjCMX+Y1jmSrA1uJZcbkLfRcO4bRAqf724kGCpu6aH+NzUO/Q+6sl+g0Pcz6+iBLpgZkDbvm+hX7+2Jq3vzSeePWWs2Mz4rhZWg53uGtbGYUpWDz12IY8uuw8Koe9T4ggGFy7H2PnWQuQvNopeUxyC6/fA1w2uhgSCDLXZkdkW3vjLmPOWLOTfQTk9OLdiL6W/Ak+uZr2aqjfJStDdPEmVoLdrGjaH5zIl48jWOKIpdfmgYo9dx1UZav8WDjfnM9Qf+4oEtI67tROgXDQXqXjqB9/SeIuqpHi5OUjujCjqF+EkS1pPGDLwgwleyb6TZxInX6vB3w0WfM9HtNJrZyBTcheF6oHb9+pMIyvIJi2iEaEkAc5oqE7YgcrVKZCxt5lswDCcQyKs5YIqqO5zX7HiiENTOvioeLCfCKSbpeXcTZOaI2kfcFgirclIAqO6jj2ha+2ZJ35MfU9IQzMMR3qJmacClWW5glQZdOb8r5LBa5fbMVcxwsfD3tb43IKoMoYpQSHZ9FYpkNKa3ceSDE97/A4ljMgGlrcBWaV+PdHMWO6ZTo6oIkHfFRiJlfno+lnxR2QCAmJZxQKyrIUx6+DM2oiPSdE/JF9l9sKEfmKlu3dEFVXHWy8FBXL/12Pq8/CI97xl8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(23010399003)(22082099003)(11063799006)(18002099003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFhQTWRYNGFNbllGNkI3NVNxQnBXNE5ndmYxVVFldTBFQmpSVjVhMHdRQWxu?=
 =?utf-8?B?YS8xTVhVNmdpcjd1QXVwemJUaE5EcENDSHhrTzVRZCtJRy9sVU1RWmJETkhG?=
 =?utf-8?B?MlY0VUZiQ2lLVTRFaEtKOWhiY2diTXROVEppM2JId2wzZHZHbWJOL0FXMk4z?=
 =?utf-8?B?QjNESWpYOTRWWkhwZW9mZ2h5RjcyMVNHRjRRZDB0SG1UZWx6VDd5dTRjV29x?=
 =?utf-8?B?RG9kVzdBTU5mY2I1TCthVEtSdXU4N2V1cEZ3V1hXUlZVM3NJalBrY1FadXNB?=
 =?utf-8?B?SDJJT2UwTS9tSUZSaElZSDRLczBNd09vK3RIS2VQckZuRXVINTVHejA1ZWxw?=
 =?utf-8?B?SEFIU1h1QndUczFzdDYyelNUQkNyVGFZeHZKbERVbWJQRDZiMlI0WXl6RSsx?=
 =?utf-8?B?QmpWdVZjTTBoaUI3Z3lqZmI2a1JxdVJRUS9aSVpHaUh5aThCMC9QNmV4QjJs?=
 =?utf-8?B?MkQrMG5wWVBMMm1vZjhWamJaWlRnTkNHOXRJeUJSQlQ0NHUxZkVKR0JFQ0Zz?=
 =?utf-8?B?aGtNZmtPRTA3VTY5VkFhd1loL1BDcjIrdm5TVUFMMmx5eTJnWStldUNqZ05x?=
 =?utf-8?B?NnpCeTFaOVI0eWxycFpJUWQvNEp3TlJFSkRqZHNOSWhoRXpGcno5ZmlRZGdV?=
 =?utf-8?B?U3RhUzVzOVFhcTNMU2Z6U2VvR2ZzYjVmVXZGT0RhYjEzVGRtejhQWFRGZ1o0?=
 =?utf-8?B?bStKRWZTaENnaXAxVU4rbDcyZE9xekdqTFZCb2xhQjFwTXZpVUF0WlNMdFUr?=
 =?utf-8?B?SVA5ekNRMklWbVpFZU84dlZKa0t0VGM5UE1iZGhKR1dnRUI3ejBLbG9Pczcy?=
 =?utf-8?B?czNnL2xiYU1rd09SY3NNODdCMERCSWVraE53NG5INmtuTmd6SnpZNTJCdkxD?=
 =?utf-8?B?SU1LUVN4TG43YTQxODFoN2hYVkNBRXJDak83UFp3Mmo2SGFIM1Fzb21kODR3?=
 =?utf-8?B?akxkZjJhOW1FVUJpK2pWYXZldTBBa3hYZHg1WWgwZXM5Y2Q1SDE1UWxad1Nu?=
 =?utf-8?B?K2FYQTlSK2dQRFNsM3RCOC9DSVlFRDdnWVFUMFFabnkrazg5YUJOelAxWUQy?=
 =?utf-8?B?WHRLcnBxZFVMSHFkVHdIMkJIMVRpTWcrZWQwbDV0L3RGbGV3dTRlNFBKSGpG?=
 =?utf-8?B?ZHg4UG9vZlc5eEoxRjRRVUNmelUrV0R0eHZxUURzVWh4dFBHYVlwZmdCUkxD?=
 =?utf-8?B?Zk5kdjJQVFZzUjVVQUVPRGF2dmVqM1I2M3Flb1lTd01OMnppMDg5TW1oSHcz?=
 =?utf-8?B?RFJiSlBGOUNORGsxRXJnRW9xV1BXTmNOVFMzalZGaFlxd2dXOGpKbnd1WWJx?=
 =?utf-8?B?ZmQ3ZjVKN2pSWllUOE5BbW9aSmQ0d054Z0dmWlFhUExoNFlLUVBRMkVaazlQ?=
 =?utf-8?B?cmZIRjdMY3dmSHVxOWkyaUlFcHNoWXZRcENMaE9EMzFZL0JIa1NJcE90TWpF?=
 =?utf-8?B?eitwbERYYVNWeWpWYVBURWpoa1dFRVFaOHJSYU5ERjhJVFFVSXVzVUc2blc5?=
 =?utf-8?B?YUZPb0xvTHhZbThKdmpWSkU2RXRYNkRKZExKWnJFR0NjVWJ1Z243eWdEWDly?=
 =?utf-8?B?Qkd2T1lnSml1ZlBhYnVTNnIzeE1EdFlQVGFnOUVtTVVBdlpJL0VtSDhKb0ZU?=
 =?utf-8?B?a1VSaGZpRTBENHlkYkZKSTJwV1EvR3JieXc2QnZOS2t2aWREazhlMERiNGpE?=
 =?utf-8?B?Sk9kOVU4bGdac29pc3FSTEdvTFJETjRDVG5TZGNPaktVTGJOSWVLS05HZTV0?=
 =?utf-8?B?dEpUQWZyUGtOK1VpdytNbm1vTDJBNUJFUGlYUHRac250MlRNM1VabVM5WW8x?=
 =?utf-8?B?L0JyTllFajYxOTRuNzdrYUJxWXdrMk43czRkdTVRZlJTQzRKQnF4UFhGS3dJ?=
 =?utf-8?B?VGhmRFJTQ21jSWo2K2U5M202YXNmMUY3cDVkOHBnRktRNnlVVnVZN29iSnF6?=
 =?utf-8?B?MmVpMUk4OFNSTVhvZHRjdVlvV3N5NGtpN1JqMTdicGl3eUlVTjZMUEQ5bW1M?=
 =?utf-8?B?K0s0NnczNWxMbzc1UUUzYUtjTTFLQUoybHZFUUZ5TDZUZWlreHc1SlFSQXJq?=
 =?utf-8?B?NVorMGlSZlNmU0JlOWx0Uitxa2c0cUJabVRLVDVmSmIvc0xxOVMyR1VYMGF0?=
 =?utf-8?B?YnhOMTdCTjBrSXZRWmdNQUVNWlNsdkF3RVppVnd6MitwVldlVkZUakVMVitE?=
 =?utf-8?B?dnQ5QXhqMkRYS3RZTGZiQklzN1RvckhNNm94VnNSdWp6WjY0UlRWdFB3Skhn?=
 =?utf-8?B?bWFWTWN4UHZQQW9QVHNneVFCaXk0dVpTWUtsTVJ4SzVTaktZZmpJd3J4LzFy?=
 =?utf-8?B?aWlsNk9Hb3BYaGtpRFFFVSsxTFA1aG1Cam5GN29xUVNzQ0RZZFExZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eKTQL1E5juU4yLt0A32uAAkqtcjvZpHem2nEQFkmGT4+VMmXUlgf84ryUAHuHlzzA8JFy1BnpeBc/hUsRwH78R8lMrIedtQ0WKpwx389dwXE2ns2GzK/qW7zXIsuCtX9SRr5sKjxr4e8OpE6cfHlViV/y1Nck+2A4c0pvanra8hQpBC/gSBfwj3LbgOxPuNYzsqp+gKfEnPYnB/PBOwDDDwWlu+eFURi5NUzdwoWHJpUhTyuF7obr2R0DQGvo0GbKI7Xjymn04xqy72F6I0mlZZqnnfbWP3aNZLtXzSA2Tgsuu36kegqNQWZUPdoX3GFDGR8CRMNiralefWb8NhXkA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d325a8-58a3-42f9-c082-08ded67bbe51
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 07:46:49.4786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n0WGjJp+cbjrBcznZ8yinr3Oaguhor1p560av13J0XrjTyK6FWA+9Dyc+D2mKYhUDh9NHI/S1n8dJ/78OmRIbzI6Ni8D4yY4nmzly+RudJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9567
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.56 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303013-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yuyanghuang@google.com,m:davem@davemloft.net,m:xiyou.wangcong@gmail.com,m:dsahern@kernel.org,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:xiyouwangcong@gmail.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[PH0PR11MB5902.namprd11.prod.outlook.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:from_mime];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,gmail.com,kernel.org,google.com,nvidia.com,redhat.com,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E2BFB6E156F

RnJvbTogWXV5YW5nIEh1YW5nIDx5dXlhbmdodWFuZ0Bnb29nbGUuY29tPiANClNlbnQ6IFR1ZXNk
YXksIEp1bmUgMzAsIDIwMjYgNDoyMyBBTQ0KPldoZW4gYSBkZXZpY2UgaXMgZGVzdHJveWVkIHVu
ZGVyIFJUTkwsIGlwX21jX2Rlc3Ryb3lfZGV2KCkgaXRlcmF0ZXMgdGhyb3VnaA0KPnRoZSBtdWx0
aWNhc3QgbGlzdCBhbmQgY2FsbHMgaXBfbWFfcHV0KCkgb24gZWFjaCBtZW1iZXJzaGlwLCBzY2hl
ZHVsaW5nDQo+dGhlbSBmb3IgUkNVIHJlY2xhbWF0aW9uLiBIb3dldmVyLCB0aGV5IGFyZSBub3Qg
dW5saW5rZWQgZnJvbSB0aGUgZGV2aWNlJ3MNCj5tdWx0aWNhc3QgaGFzaCB0YWJsZSAobWNfaGFz
aCkuDQo+DQo+U2luY2UgdGhlIGRldmljZSByZW1haW5zIHB1Ymxpc2hlZCBpbiBkZXYtPmlwX3B0
ciB1bnRpbCBhZnRlcg0KPmlwX21jX2Rlc3Ryb3lfZGV2KCkgY29tcGxldGVzLCBjb25jdXJyZW50
IFJDVSByZWFkZXJzIHRyYXZlcnNpbmcgbWNfaGFzaA0KPmNhbiBzdGlsbCBsb2NhdGUgYW5kIGFj
Y2VzcyB0aGUgbXVsdGljYXN0IGdyb3VwIGFmdGVyIGl0cyByZWZjb3VudCBpcw0KPmRlY3JlbWVu
dGVkLiBJZiB0aGUgUkNVIGNhbGxiYWNrIHJ1bnMgYW5kIGZyZWVzIHRoZSBncm91cCB3aGlsZSBh
IHJlYWRlciBpcw0KPmFjY2Vzc2luZyBpdCwgYSB1c2UtYWZ0ZXItZnJlZSBvY2N1cnMuDQo+DQo+
Rml4IHRoaXMgYnkgdW5saW5raW5nIHRoZSBtdWx0aWNhc3QgZ3JvdXAgZnJvbSBtY19oYXNoIHVz
aW5nDQo+aXBfbWNfaGFzaF9yZW1vdmUoKSBiZWZvcmUgc2NoZWR1bGluZyBpdCBmb3IgcmVjbGFt
YXRpb24uDQo+DQo+Rml4ZXM6IGU5ODk3MDcxMzUwYiAoImlnbXA6IGhhc2ggYSBoYXNoIHRhYmxl
IHRvIHNwZWVkdXAgaXBfY2hlY2tfbWNfcmN1KCkiKQ0KPlNpZ25lZC1vZmYtYnk6IFl1eWFuZyBI
dWFuZyA8eXV5YW5naHVhbmdAZ29vZ2xlLmNvbT4NCg0KSGksDQoNCndoeSBzZW5kaW5nIHRoaXMg
dG8gbmV0LW5leHQgbm90IHRvIG5ldCBpZiB0aGF0J3MgYSBidWcgZml4Pw0KDQpJbiB0aGUgdjEg
dGhyZWFkIGl0IHdhcyBzYWlkDQo+VGhpcyBpcyBhIGxvbmctc3RhbmRpbmcgYnVnLCBub3QgYSBy
ZWNlbnQgcmVncmVzc2lvbi4NCg0Kc28gd2h5IGRvIG5vdCBjYyBzdGFibGUga2VybmVsIHRvIGdl
dCByaWQgb2YgdGhpcyBidWcgZnJvbQ0Kc3RhYmxlIGtlcm5lbHMgaW4gc3VjaCBjYXNlPw0K

