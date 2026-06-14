Return-Path: <netdev+bounces-299154-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lJB2GaZVLmpOtgQAu9opvQ
	(envelope-from <netdev+bounces-299154-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 09:17:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB00668089D
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 09:17:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=g5mbVC6O;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299154-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299154-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30F0A300D69D
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 07:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3802E34B194;
	Sun, 14 Jun 2026 07:17:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38A3286409;
	Sun, 14 Jun 2026 07:17:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781421431; cv=fail; b=K9u4U88f8g+WL+YxpTn5xTkIWarH7H73NiKtLNTf87kYIo4BDyrZDBy00otLaeSWcGg/AACUuS0BfLSTwQ+/FK2TLwi3hCJzPQtilOGtASBbmf3SEQlKJn+3JkDgz1GkHvC7kD4UG/Ai2b5JoGBJ+Ml6ZDbPY70OfMoEnLnUBZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781421431; c=relaxed/simple;
	bh=8XjOd33biKeNV1y4gFbc5ZUvR7Ef6iZXLDYuZ3YvQ0o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k15g997d37hWrMR8JwRn7IW1GMyo4zUnNlpNCVVa733AnTGU5Lpul7mFjMbt3KzC0nnyIF/KxN5fwwlUKncXaOzpekX1BGwdFXPhA5bm2wOqVb/pZSrxaLkRfanecJRKYIbUDyo2NrF1NW+B13rh/L1ZUBG7ovgf/UJDoJ9Joaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g5mbVC6O; arc=fail smtp.client-ip=198.175.65.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781421429; x=1812957429;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8XjOd33biKeNV1y4gFbc5ZUvR7Ef6iZXLDYuZ3YvQ0o=;
  b=g5mbVC6OCqfvzJ0sFXVnSxPFKiVBXzwjKFOl4bL8l1h0LEZMRn7ZniEq
   vW3SDpJ1arRq9ey9CdZgpslsrbqMD7K39GZp2o7udRp8xGFE8Zw0P7B/e
   hYOYKH3unDWIbmGgRN1xyk3bGmKTEvH7SL5JppoQ1tAUkNtgShrgv3WNI
   zEYU/gHAyrW3lLuAxK+sB3AoMryVCIrEe9EkrAJBpjbwRA5wY57emnlrH
   OXADOXzgNXnN9iKJappf0va+XZS6Rmy0YuXy1FdYaFUfb5Y50Ps+SUAo3
   DQfybolhwIqUVrQ3RdwCv8cuEyqb/w2QtuSwmwLi9Dnky0pCImKaBLgLx
   Q==;
X-CSE-ConnectionGUID: 8E8MaTelRK2bUcjv3Stb2Q==
X-CSE-MsgGUID: 8TE8p08hRiSXNogwXdSPBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11816"; a="85826867"
X-IronPort-AV: E=Sophos;i="6.24,204,1774335600"; 
   d="scan'208";a="85826867"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 00:17:09 -0700
X-CSE-ConnectionGUID: KLcX43rUTSuRTSi0R4Ma/A==
X-CSE-MsgGUID: q9CGqXrTQ22OsXXIBKkLew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,204,1774335600"; 
   d="scan'208";a="285296247"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 00:17:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 00:17:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 14 Jun 2026 00:17:08 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.40) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 00:17:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kaocxe4yIJzigzcHKkdNfUzesqd1vm1AzCJcnEVi6RyvuY4b2XdkJEfP1tAgX6umqgOjT9qk5Q/Gars36QD5rf2QeQ57xtzEny1Rwm4+KgQMQDLyuXTF4kapdVKFu62MCQHynDA7do6DRdbH6T4huBZy73bxFWOafGhEDpTWFQwny606j71YvYZiRxYGag1iJmUTDgdRl0dngggNKGXR5Jqwy1JOhmSF9cTAvXHl5JABkx/EgseCVZ6ZaYg4Lpc9J2NgmXmTlVIhkVP+zlnqwuHxmCzcEq2b4vlTqyJ4i7rW3HR1gAG7TrZuudcR9FH18yQW10eFeQ4YZnbq7pmAxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8umpAxJ8sgoPhfKAE8aOTjW10fmV023tHFcj2PUtRc=;
 b=FQDC599Thh+S/9WGkJILLPbP+DmQ5U7hDEnbBmX9BxN7RvRF9Pp7a15766f7sYL/CNKbPZPeJWUYm2cfsg3jCW43TeaXYQlJfN85vbjelnlWUDhcU+jA0/SnfEYjd9m5P02n+aMSScD/GTMfJDAJbqGfyieMjF0N4bkFvDhSnalswXksrdKfDLhyxfND1CbTgKODYXiOFrZHHyUKUstC3vXZtQN/1jAgOEWAuQz928LhjEm8gSIaWzL4cv+J1tSRaMWqKQ2yU9ucyCtuhjXdiq7BQ9AwPNrw1rDS0ln8SNlG/jkFrBmG0+HMmqY7dpKm5SVSRfZyIaiqWyqcvJn2Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS7PR11MB9498.namprd11.prod.outlook.com (2603:10b6:8:261::10)
 by SA7PR11MB9541.namprd11.prod.outlook.com (2603:10b6:806:4cf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Sun, 14 Jun
 2026 07:17:07 +0000
Received: from DS7PR11MB9498.namprd11.prod.outlook.com
 ([fe80::e3fc:2bca:409f:b925]) by DS7PR11MB9498.namprd11.prod.outlook.com
 ([fe80::e3fc:2bca:409f:b925%5]) with mapi id 15.21.0113.015; Sun, 14 Jun 2026
 07:17:07 +0000
Message-ID: <4d8d9eaa-d9bb-4589-a37d-31d0da584335@intel.com>
Date: Sun, 14 Jun 2026 10:17:01 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v5 2/4] igc: move
 autoneg-enabled settings into igc_handle_autoneg_enabled()
To: KhaiWenTan <khai.wen.tan@linux.intel.com>, <anthony.l.nguyen@intel.com>,
	<przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <faizal.abdul.rahim@intel.com>,
	<hong.aun.looi@intel.com>, <hector.blanco.alcaine@intel.com>,
	<khai.wen.tan@intel.com>, Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20260507214706.309984-1-khai.wen.tan@linux.intel.com>
 <20260507214706.309984-3-khai.wen.tan@linux.intel.com>
Content-Language: en-US
From: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
In-Reply-To: <20260507214706.309984-3-khai.wen.tan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0025.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::20) To DS7PR11MB9498.namprd11.prod.outlook.com
 (2603:10b6:8:261::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB9498:EE_|SA7PR11MB9541:EE_
X-MS-Office365-Filtering-Correlation-Id: fbfc22aa-21d9-4b9b-8d72-08dec9e4f166
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|6133799003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lifxamZH/87CRkLfFZ0dxjtZDJc2StWGikImbP3FZuu4F9wr/qHMFaUjTSRXnQPPtgz8anwoTBEkWd1P83jli9vOE1zTpFBQqhwuUHym9pgZ8Z+VZLXeyJdt4zlBG2JZukGwl+CkhpKIkLN0WPcwq6uV82zo+YzFX/AVSkcZ701pcX3vdRkBOv0Z1OMsHssiqI5ryMjDpT2FYw+2Xg9QBg69+rW0EGlLzWy8mIL6vh965Y6uFxAZl73owW6KXc81JUF03YdT60qHRyiRVt9WVaDyn8zHoLH0ZMAffzh/vDbpBOt9cAPcLhWDTKkfjoa7c1h+dsJGLRX/T88IXcx1NQmhJnxFFFcXSYfoe5pGdUcqQK7L6adLQpvbL71hJcCRKoOSgegxyiY3YW/52TV80Ir0SzDsZ2SUSkw2hQgQdK6bykM+VtZyBfM5NbVe3SUqrnFV6hRW7KsdVIKUUKTaZZXXj9MWEQcxSV4CjZJQnTS4DB6ydFLZDqgWRwHYd5uDADsL//lKPNaUvtgbUFJgMpbh2iKqe7B4tkwpBVRGtWbYfPuLYprfWTA7MqY4rsI6q3Tckg7HKKE1C4PhySd9A/LcCES63f3Fkt45VxdxuWkEem9gLzwafPGkI0NQI+YDVOY4IrMpP4TfiVJY8IRzcASXsYhAdCNSe92MpasY6eO0n0aHZ8teo611iXPgVWQM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB9498.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(6133799003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K01aSUNQdzNoV0ZmRkhnRXBXOTZYNElVQ29xK2xuRWFXVHFFWDU2YitZeDds?=
 =?utf-8?B?MzVtL0hpdUV3K0hQblcyZm5ra0NQcmFjazZrWEEwR000UFI5bDgyWGU3KzlQ?=
 =?utf-8?B?bVVVMXFjSUdyc3c3N3VtaGxyMVdBTnJ1NWpZaWF3UFd4R05NZFlSc1U5YjhL?=
 =?utf-8?B?UllEdjY0MEJ6c0dBamp0NnRDUEVnZUNrRzdMSXd2UUhTOFA1dHErdHM4Mis1?=
 =?utf-8?B?WUZmZm1iSkhNaWtZZmJCWFVhNWtWclUyOGFPMlJFWFMyZ0NOSEswSFhSL29s?=
 =?utf-8?B?cnpsWkg2M1Z5TmZmc0N6N290cWhZWEdINnBFVGhXbThFdkJQUG5CTFVTdzhK?=
 =?utf-8?B?TE1ybWcwU25lVTh5MjNCcS9NZWVOcEdiUXUybWVJT3JRdFBBZEhCTUFob2pI?=
 =?utf-8?B?enRvYndUczQxeEtEMmtLMFFFRmVJV1k1bnN1L2xZNzNSeG9jR2VzZ0NMU282?=
 =?utf-8?B?RVRwaEd3YjQ0OVJnTDFyRElIV1ZUVUxHenhTSkMvdFNpMkxaWHRTR2RXZUpw?=
 =?utf-8?B?akRNeW53dHRmTFNHd3FUb3hTd0w4NCtEU3RwT1MvbnZvRjNsdnpDa0ZxSGhs?=
 =?utf-8?B?N1N3RGpzU0tTWEo0aC9xN2VLRElBaU1kMzNOL0dBTlI1TmNrMDF6MGgxSXhp?=
 =?utf-8?B?S0E3dzVycithaW91N2JZYzUzd2NPQ1N6OW9wVWtvMUlZaGJtV0F2NmFDZkNK?=
 =?utf-8?B?U3QxQVArWDNJY1dNK0draW90ZEg5YlJqK2gvRDhodmJHcTZ5aEJZNzRTdWww?=
 =?utf-8?B?R1VJOExtSk0vM004OFNXSUFtZDJ6VlJSanFSOVd0N3JvRWtQdHRBazlDWVFL?=
 =?utf-8?B?bjhDUFp2YmlCK3J4d3duVHVVOWlUcEFWMDhSTXFxd3NDWDRMZFg5aVc3SVM4?=
 =?utf-8?B?SzNnNEJFcWloTlBDczhybC93U3ROeHh4bWtBd2VjbEFFUU50RlIzVjhtblNq?=
 =?utf-8?B?L0svV3NmbWYyOHBOSTZiTFdRRDZGWGdKV2VPQWNtcHRXajhkUzdqQjlJN3Z5?=
 =?utf-8?B?VGZHcGJqdGswRW4rOFVJbjZGVk9nSDZ5YUJxWGZtY1JFMk9vbkY0QXlVQTlO?=
 =?utf-8?B?OEYvcTRCS2xXejNnRHlLWld4dmFCN3lTaEl4UHI2VUFnZU1ud056d3gydnJN?=
 =?utf-8?B?cUR6Z1cwQXR4TGhGWW13THBodFNFN1Nra3JIQVNhaTY1YnpZVUJVbm40Uk1F?=
 =?utf-8?B?SEttdVh2RlAwcm9LS0VCRXpNcUhHc09tN1hiRU02RWpUdC91Zk1MVStwbGFZ?=
 =?utf-8?B?WmhLQUZVNmJrRkZDZnpyeEJZa0FIdGtUSGRBMWxHemRkK1pCbFdaNVJham9W?=
 =?utf-8?B?QzFXVHVmei9sNWlDWkJIc1BTdmNOWkJncU1aVXBSN3lhZVlyZ2NHTFpSSEFQ?=
 =?utf-8?B?OTRGWnUzTldYOHZPVUkxR0MxdG5SVDlhNWE3L29jamRIMFR2VTdhZ2o0VWY1?=
 =?utf-8?B?OERQbzVzU3V0YmlwSXBwcEQvVk1BL3ZidEJYQVJpWFY0c2t1OU01cTZ1amk0?=
 =?utf-8?B?Vk9JejdrMU13di96Q2RSOVhrOTc4Wk1HZXZGODVxQ1dSa2ZpdE02SHhPUm52?=
 =?utf-8?B?UnVOWXJsNGtyNVc3Vkd0L1JWZDV4Q0FxaVpBazVTT2I4dWtQSUkzdEVlSlBs?=
 =?utf-8?B?VWtxZUlXak9BM3RYbkh5VHFvZEV2ZFNPVGVDNWVWYXZ0YWZKYlZkbytxVzhI?=
 =?utf-8?B?TDNYVEpRaHVZcDQ3WDA2MVNnUFRENlQ0dVZlcUptZnVqaTAvUWdvdDJhQXlB?=
 =?utf-8?B?QUJ6Y3pWQmtmSDJnQzZsM2UvSG1yZXllY2tZelZRUmwzU3NENWUvUW5LOXhu?=
 =?utf-8?B?MjFyc0VrRDFHQStUZ2pVNEV5azFMWGdPMzVGSHZuaUVuWHhMLytvNEoxa1FT?=
 =?utf-8?B?SG10UldaRUtxQzRkdGVPdzVXck9XWG5jSXVEMExpa1FvSHdRSUlQUGZTTUoy?=
 =?utf-8?B?Nko2LzlucWZsbG85citOYndtZFJ0bnB3VzZTMWlKVG1UV09lMXI0aEhCWlYv?=
 =?utf-8?B?Q2tRQXZ3ZzNQWFJWVERwVEJWLzltWE9PSiswZk9hTnRvV1dLMjdUY09vYTlU?=
 =?utf-8?B?VzJhMldBci96SGhwL1UzV2J0Zm0rUldEeHhZN3piUEl3clprVERTNzFXOHlR?=
 =?utf-8?B?UktJOUM2ZTMwaDdMNXB1dmtObElzVjJXS1Z3OWxMenlRcXg3MHNGOTZnYklO?=
 =?utf-8?B?Y1dPM21Vb0ticG1GUEx6RTVuNmtweElaOFV1dDVaR214Yk41Y3puSy9oeVBn?=
 =?utf-8?B?U1VFY25RY3NqUVNiWlZhNmJLV002eTZEWDlvZGRtUStkRW5vR0JFR3pmRXdw?=
 =?utf-8?B?ZVJtMGF4TEdEMTVpamFLeHM2eWZJL29zcExTK0JOYVJHTzF6eXVmdz09?=
X-Exchange-RoutingPolicyChecked: bbWIfcbC3fqP3Sr9f4KGMjpj7s3BQLjghD5PVKCgMyAt2JywA8f0VGiDF5LhnYId14VgzQQZJVL7oWItyaBMDIsOLS1NTaRUAcqua0WQI8Ka5QssbOXH5jALTFpW5zXX6hqTrG79CVXq9yAdN61FJ7dDyx0PhrjpQoFYQ27aYnO3jgrBKZdBeB0LkxoemqHBN7AZjza8wjMw58OzAAUzrR0NS/uwaSmimHAnVrJYfkN2DCWYs/78OR78Cm+zhJ15xS4C/4seQB2GUmmphersYzJOHXNJXtA/KGtVdH2hBW+2zpRRy8jKmlqVt/vIikoXyZjn8HMI7Fit1HKaSyYbgQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: fbfc22aa-21d9-4b9b-8d72-08dec9e4f166
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB9498.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 07:17:07.3526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Le8TaIQMoRi3bzxV/50ENwOql55VneBGU2TkHSEdEjwpFbmoBCXCKqbmFimoTUH6VtvF9jhl29Ra8ZhRWYQX4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA7PR11MB9541
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299154-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[dima.ruinskiy@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:khai.wen.tan@linux.intel.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:faizal.abdul.rahim@intel.com,m:hong.aun.looi@intel.com,m:hector.blanco.alcaine@intel.com,m:khai.wen.tan@intel.com,m:faizal.abdul.rahim@linux.intel.com,m:aleksandr.loktionov@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dima.ruinskiy@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB00668089D

On 08/05/2026 0:47, KhaiWenTan wrote:
> From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> 
> Move the advertised link modes and flow control configuration from
> igc_ethtool_set_link_ksettings() into igc_handle_autoneg_enabled().
> 
> No functional change.
> 
> Reviewed-by: Looi Hong Aun <hong.aun.looi@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> Signed-off-by: Khai Wen Tan <khai.wen.tan@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_ethtool.c | 72 ++++++++++++--------
>   1 file changed, 44 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> index 0122009bedd0..cfcbf2fdad6e 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> @@ -2000,6 +2000,49 @@ static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
>   	return 0;
>   }
>   
> +/**
> + * igc_handle_autoneg_enabled - Configure autonegotiation advertisement
> + * @adapter: private driver structure
> + * @cmd: ethtool link ksettings from user
> + *
> + * Records advertised speeds and flow control settings when autoneg
> + * is enabled.
> + */
> +static void igc_handle_autoneg_enabled(struct igc_adapter *adapter,
> +				       const struct ethtool_link_ksettings *cmd)
> +{
> +	struct igc_hw *hw = &adapter->hw;
> +	u16 advertised = 0;
> +
> +	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
> +						  2500baseT_Full))
> +		advertised |= ADVERTISE_2500_FULL;
> +
> +	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
> +						  1000baseT_Full))
> +		advertised |= ADVERTISE_1000_FULL;
> +
> +	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
> +						  100baseT_Full))
> +		advertised |= ADVERTISE_100_FULL;
> +
> +	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
> +						  100baseT_Half))
> +		advertised |= ADVERTISE_100_HALF;
> +
> +	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
> +						  10baseT_Full))
> +		advertised |= ADVERTISE_10_FULL;
> +
> +	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
> +						  10baseT_Half))
> +		advertised |= ADVERTISE_10_HALF;
> +
> +	hw->phy.autoneg_advertised = advertised;
> +	if (adapter->fc_autoneg)
> +		hw->fc.requested_mode = igc_fc_default;
> +}
> +
>   static int
>   igc_ethtool_set_link_ksettings(struct net_device *netdev,
>   			       const struct ethtool_link_ksettings *cmd)
> @@ -2007,7 +2050,6 @@ igc_ethtool_set_link_ksettings(struct net_device *netdev,
>   	struct igc_adapter *adapter = netdev_priv(netdev);
>   	struct net_device *dev = adapter->netdev;
>   	struct igc_hw *hw = &adapter->hw;
> -	u16 advertised = 0;
>   
>   	/* When adapter in resetting mode, autoneg/speed/duplex
>   	 * cannot be changed
> @@ -2032,34 +2074,8 @@ igc_ethtool_set_link_ksettings(struct net_device *netdev,
>   	while (test_and_set_bit(__IGC_RESETTING, &adapter->state))
>   		usleep_range(1000, 2000);
>   
> -	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
> -						  2500baseT_Full))
> -		advertised |= ADVERTISE_2500_FULL;
> -
> -	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
> -						  1000baseT_Full))
> -		advertised |= ADVERTISE_1000_FULL;
> -
> -	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
> -						  100baseT_Full))
> -		advertised |= ADVERTISE_100_FULL;
> -
> -	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
> -						  100baseT_Half))
> -		advertised |= ADVERTISE_100_HALF;
> -
> -	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
> -						  10baseT_Full))
> -		advertised |= ADVERTISE_10_FULL;
> -
> -	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
> -						  10baseT_Half))
> -		advertised |= ADVERTISE_10_HALF;
> -
>   	if (cmd->base.autoneg == AUTONEG_ENABLE) {
> -		hw->phy.autoneg_advertised = advertised;
> -		if (adapter->fc_autoneg)
> -			hw->fc.requested_mode = igc_fc_default;
> +		igc_handle_autoneg_enabled(adapter, cmd);
>   	} else {
>   		netdev_info(dev, "Force mode currently not supported\n");
>   	}
Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>

