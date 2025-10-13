Return-Path: <netdev+bounces-228978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6F9BD6B68
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 01:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009C8405623
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 23:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FF72DBF5E;
	Mon, 13 Oct 2025 23:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QhzuJqOX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AC4220F38
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 23:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760397172; cv=fail; b=oPZbV0bOSWOkoN+JWAGbhjxaBeW89/boCkAnh4LDI2j/dJOGINk/idGkq4fHqYetwTiz5TbntepRNsuOntJissN7D72AJg6Eh4x/icI0eK69ZoVjj3D2xdd+5IN+4vldKrKmiAUjEGKqNtWjRxlNu/3lSkrlqN+WZqYBuwwcVQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760397172; c=relaxed/simple;
	bh=Swfil5QNXvIoKpC20fswVSCpdHpeb+Vzv77PcxtwkxI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t06yUGYupogDlRdaxS0fCHBFEkh1zjDWyg4bhdHP4qkPu93gb/HEbMosEUnBlfWbmqSTMw1L+Fmnntewwqplp2K0omk5NhrjEzrqtkNOclhx908GGctQejM9r7mZnGHAnzmOHpkk1Zw851KWhNW0ZahOfx5ANmSEtFpJLEwapRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QhzuJqOX; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760397170; x=1791933170;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=Swfil5QNXvIoKpC20fswVSCpdHpeb+Vzv77PcxtwkxI=;
  b=QhzuJqOXJ+ajIJLtk+mlMHaaoDKWIY6vK7MstSaqScHAUtncwV3osaj8
   +edtCbOVrWpxPXY4/UGEWazl8IATzlvlOaNuiFQQi6kurmN7HkFx8m6/W
   U4JNyO3Q+OTGlQe/YywbDV61wR6nYHQDacKBrJIHyjs5c+itsyXLX2b7b
   PKWA7kP5AYyrZRn/Ww7mQRsK4DVnenxrcoPJfzey3AkDUrrY1D7dO0Q7F
   aCXbqQJM/sV6Wr7/K3l9JUSZ/ILFDTEopZ4lx0+YV3BwzLYX3SdeCPzVR
   jf+ltyoU7OJdieIwi6m0y5Vo/mPneDTGDXgJB3WHrDZdthd9BJm6ZKgc4
   w==;
X-CSE-ConnectionGUID: 4hP2OjbIRS+JL2QOrHrv0w==
X-CSE-MsgGUID: 46CSCW0uTBmCUjC/IrsPEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="65169444"
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="asc'?scan'208";a="65169444"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 16:12:48 -0700
X-CSE-ConnectionGUID: meMNyQI2TwC063wVjaEmuQ==
X-CSE-MsgGUID: XJBcWUqmQiWR6EhoMQIXaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="asc'?scan'208";a="181679972"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 16:12:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 16:12:44 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 13 Oct 2025 16:12:44 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.39) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 16:12:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQTCIdhx0+q1HFLQVuUyetBjZmi5nruuoZj25o2Cg5es/ua87hTQyKf54NgrQVnouUSsUbeFB/KypPXjoMmSC6MyFo5aoUAzdohMfEcp4sSF2hy7nlD36aeuFvPdTSb8Cy52UlISw/9v2969hj2rzn+QFnSQzyeu8MLw2d2uqwygaB9LDE5Lk2ZDL4Xp1ySyh/65/4BeqAK19q8qfSET349giKpdtShdggnQ8jMveVp4v+qb7shDFO6atZGwmTt0r5e+5YDgzPbdvxBg+gj1kalmN2j2h+JVnbV41wFzMo/XIZzuQQcAn7N6l3Fkts46bnq+7PGWFgOhj69vR5mC2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Swfil5QNXvIoKpC20fswVSCpdHpeb+Vzv77PcxtwkxI=;
 b=WqOV7/bPU6h8DwbsCc0YvQZPDyg8O8m98iNtY4w0VFmMSqq2z69/yu9qWRkOcPZg8JMeblaUh9rL+GW5H1WGib1PqivDUYaVDdeyNO2RpLpYsqv8OtCuYDaWvkCcB7BNtzNZCuGhAPxtc81yvwxD4mHzdjGU4ACruFht1mKT0SjgJ/ZnMGtckj9d3M2qFUV9F35+R9a/CA4B08XjIcjgx8Mo/eMHcJo7Qgrnz2PEJOITyTRI5JfOVimTjxxkNwuWmb+m6UCtGHFBnQXVV7k9dAbzeA9LDHE3b2riP92LxSO094sHyrpw/DbCTzM2eC01i8DJfee0hn/OJzq17KP4Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA3PR11MB9327.namprd11.prod.outlook.com (2603:10b6:208:57a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 23:12:42 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 23:12:42 +0000
Message-ID: <cfd30b2b-efb4-4bde-8a10-fa07b3a88fab@intel.com>
Date: Mon, 13 Oct 2025 16:12:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] r8169: fix packet truncation after S4 resume on
 RTL8168H/RTL8111H
To: Heiner Kallweit <hkallweit1@gmail.com>, Linmao Li <lilinmao@kylinos.cn>,
	<netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>
References: <20251009122549.3955845-1-lilinmao@kylinos.cn>
 <6d9956bc-6816-4726-9bcd-03bce1b9f027@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <6d9956bc-6816-4726-9bcd-03bce1b9f027@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------7BgfRo3Q1I4L68nQV3c7y5TX"
X-ClientProxiedBy: MW4PR03CA0163.namprd03.prod.outlook.com
 (2603:10b6:303:8d::18) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA3PR11MB9327:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ff0eec2-87c2-4cc9-81e8-08de0aae0287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTB3dzdKTmdYSm8ra1lYNXM0d21mY2lKT0NqNWRkUDJ2T0g3WWpwSCtjdnlt?=
 =?utf-8?B?MGc0cUszYjJXSGlzWUlUK1ZnVzkrYUk4TGpCelp4UmIxK1hYOEdIWUtkeWdp?=
 =?utf-8?B?MmtMaW9ONExBbzQzS3llV1dseVN0QzlKQVFWY25SdUtTdE9vRnJzLytocDdv?=
 =?utf-8?B?OWp0KzVhOTRXYjAzdC8vS3k2Z0FnRlJLK3hySU8rWHRTSUtwcllVakpXL1hL?=
 =?utf-8?B?d2s5clFaaVFPOXpXMjFSTkZERnVEWFM4NnRQbllzUUJDTnhSRy95OEg2VjBo?=
 =?utf-8?B?YUErbTA2NDFNQmJhUUNrSWtkN3M1UGlTeVp5UElxa3ZOdGtybVg4SHFFNE5i?=
 =?utf-8?B?MzliUmlMaU9INzh3Rjd3bGRTUldkaHljMXQyMDdUZ3NFRmIzV05ORU1oalVR?=
 =?utf-8?B?eHNWR0dwK0k0ZVJZditVVnFGSTdUVGFIS2tWaTBmWDN0bUMxS3NIVGMyNncx?=
 =?utf-8?B?UG5KVkd6TWVDdUM1c000QWxVeTQwdkJUUS9MWDZBb1hGSGQ1aXRaYS82dzF6?=
 =?utf-8?B?Q05ySkNKWWZwU01kRHBPc0NxcGtOVktQNlR1bTYyaXlqZy9SbG56WEpBMEhQ?=
 =?utf-8?B?VzlaclI2Zm5TYldXbzBoSWtyUHpTV0tTV3pDZHU5WWtJKzVRL3p4T2JORFBr?=
 =?utf-8?B?Rk1kWmRTVVpSTFY5dStFQk9lUWk5ME1rY25GTkR5OW1oTTdMekJiMWxkU2RS?=
 =?utf-8?B?QTJaTitqWkc3Ym5uWDV5OERnZ1ZVeElRZTRvSGNObGdKb205dk1lQmQ4Z0s5?=
 =?utf-8?B?d3NLd3pzUk9adGRuU2V2bmloT0NyUXBoekt1aUU1VDdqNFl2NFUwNEVzZjVJ?=
 =?utf-8?B?QmlNSzkxTkh0b1ZocXIraFlRTzhZU2RMdmRWenUzSnJ5ZisxbUpiaWRCZCt2?=
 =?utf-8?B?ZkhnMmlwb3JYQkhEa25BME9nQTQ1dmU0K0dMckNWOGtEUCtnUXkyeUdaNFFC?=
 =?utf-8?B?djlmZjlYTmQrT3VGaDJnUjFJSFdXZXZFQ3RvcjExSWtIRXNjemRFNmRjWUR2?=
 =?utf-8?B?UXZYWUdzdzU5U2tOVENmUWkwWW12RXlac2NMOTZENVE0d2FUTUFpSm1XUjlu?=
 =?utf-8?B?VHpTOHZwUG5JY0E1K0ZKZ2JvREEzMDBHaHJWYWZzRjVkd0l0RmxMQzFOWHp3?=
 =?utf-8?B?WWRnRFZOUm9PMy9iSnU0bGdyN0FMeEluMlNoV3ZiL0owUTl2YThYZ0JlVE9B?=
 =?utf-8?B?S2NrVWJuVEkrTUxtVVhMcnVKcE85ZzQ3ckFiajQrM1ZKdjM2U0xSMHRmQS92?=
 =?utf-8?B?SHVGR0xoLytXYlVKQnhyaTNVUjdINk1VM2ZnOHAzck5OZmI0akdzRkZPMTlP?=
 =?utf-8?B?N0lUemljNEhwZ2U4UGt6R1NReFVKMHdVVDBJM0tGSUsrSWI3ZEZnWTM3elBW?=
 =?utf-8?B?WlAxRUloQUVER2JiWFFhR3I4M0UzMm1nTXBUaVlFWU1OWkFwditNN2NYOUsw?=
 =?utf-8?B?ak1ZQVRsdmxrOHo2YlhyOXFNUWdiR2h3ZHFaNzBEQzVBVGg1bURKZTNqVzlw?=
 =?utf-8?B?bi95dHRIQ01GYWsxK1JaNlZRRGw3UktQYlAxdnBVcHE0aUs0RzBMTUJZK0Fq?=
 =?utf-8?B?T2NMQWJ2dTZTR3JpdTJvMXpvR3N1SW9ZQi9qazBPZ2llUnE3MysvREhLWnpo?=
 =?utf-8?B?Ti83ZHpkSHUvSWN1SFZaNldoTVhQUUdvc3h5SlNRSU1BZTBWbWQycXJscno5?=
 =?utf-8?B?QmNjZGZxTTk3Q3grMnNpUldVL2JNYlhZcmRGRWZTOGpLNUdvRWN5ekpxekgr?=
 =?utf-8?B?Yjd2ZHgycXh5WW5zVCtTRzNSYUZiWFNjNzhvWm9SRkR4a0VidmtncURYVTlD?=
 =?utf-8?B?VzdUV2VtRFdQdkg0T3d2VUVJNW5NUmFSZWw5RThubGdwY3ZaWEJMNEFDWU5R?=
 =?utf-8?B?NDVlK0ljdnU5OHNTcmxqakdPdXFPMGgwU0ZPZ0lXOVdKMENWSVRXOWs1dGh1?=
 =?utf-8?Q?EonAJlOapSolp6BkMbu8PN/9cOxnNTSh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmNaU3VFSHNRYm1WOHM1R3BvUjlzUEFoRHQrN1QzeW4xMk1nTkFLUlIxSHhL?=
 =?utf-8?B?MWtKZzJ1V2hTc0ZFS3NMWGt2cFhjWmNhbERJczN2YzltRm1KMDNCeDYzbGZ4?=
 =?utf-8?B?MzdQcmJIQkMyM2hFN3RQNjI1bjZXdnVNZ1oxQUZPNFdVMWM3TDVmQ1pVSnR6?=
 =?utf-8?B?dlhJVmpvQy9QZmw0WXhpNUZNQW54aVBwR1Q0Skwzc0NVTDFhVlpXN1JTblQ2?=
 =?utf-8?B?UnM1V2Z5U1VYblFEMzRPamN4TFZCaUZDWmpXNjZJT0liVkNyN0xWbVhVRytM?=
 =?utf-8?B?QUpGRFNOYWs0VnNmMlVxVlVyOHkyMnlrQnNieTVCYTVQTGJHV2lFRDJzQlJI?=
 =?utf-8?B?TVB4Y0lMUEFOY0dGSk9La1p4RG1kSXk4NXFRbnJ0dXpVb0RnSUZwZWkvLzlr?=
 =?utf-8?B?YzNWQXZtRGE5K0xDUnVTTzJGNCtZRnY5Sjg0ck5pSWdHci91eWp2S3RjM1dk?=
 =?utf-8?B?N2wyM2pKR1YzbVZPSXlsRTlLcmdudVpXZU5pT2VmR1I3VWlDczFBNFRERHFG?=
 =?utf-8?B?OUpwZnB1NlNEQzQ2eUlXZVlDakhzR3ZSSkRCaWRBZy9wQnFlSmk3UHdkV0Zt?=
 =?utf-8?B?V0JhN3VDQUU1TXlJQlhYSS83T1dwT3ZLczNBc2ZhZzlzSWxHQ2ZtcVpzVzJM?=
 =?utf-8?B?RmVySmZZblcwZEcxWFlQTjJvSHBrTWFZaUUwQ0RlOGN6WXJGYksxWVRUdGpt?=
 =?utf-8?B?R2h0clJmWWIwSEl5c3Fhb2VrajhaTnRuYk5hNDJNZUsvempzMEFhWGRCNGxj?=
 =?utf-8?B?RzZCQjlqWEl4cGlzVFFCTC8xWXBZQ01adU1oY0YrR2tpQzhZZXkxVGNBQUJH?=
 =?utf-8?B?dGxNR0hidEZTbWlLWmhxczFVbVBwdSt3MGtZWFB3VVhBWXgrdWt1UXIwcnZX?=
 =?utf-8?B?Q3Y5am9teERmamxUaW41YjJ6UUwxUDdaQ3IvdExVWkRncmNPTis5SFRMSklu?=
 =?utf-8?B?aUVyNGEzSHhHSFhIYzVSRzFyWDc2YXBnVkhwRWk1bVFoOVVPdGZPNW9mT0cw?=
 =?utf-8?B?OHhqUFhJd1ltOXZTZk5hUFBQSWJ3c1JWaUdyb1E1MVNId3hCdzZCVGwvS2Yr?=
 =?utf-8?B?Z1FUL2JFR2V4ZG1DSlRpT1BkaEVYeVNyOW04djJ3NlZBcHVtZUM5Nlc0ZlJs?=
 =?utf-8?B?aDU2UGh6clpzUEFuakxHMVZRc0pKT1BSdXFQM2cxaURCU0xFR2pFTzdUcHNP?=
 =?utf-8?B?QmZqNGNOMDFwWDlPWGhUbU1xcSt3YitNLzBVcStSOVpQOStjTHp0SjdaT1hV?=
 =?utf-8?B?aXpHeUpTV05sVm12SnhDK1F0N25sRGtrYkZ4YWtyUnlzMkJNUXd6VDR4eGJE?=
 =?utf-8?B?Wm9Ka0VnelZmdTFENWlDYWVGYm92OEg1byt6VDBRQUJLNjNnS3RSRkhSdmw1?=
 =?utf-8?B?aklVNmZiRTZudzYwTEFmVnhuTFRxdnlzSWx2NmQvdTFldVY0TnljT2U2T29I?=
 =?utf-8?B?bGN0QnlSTklDS1pMbkpTZGNrVWo3TTlGYmJhUXgyYmFXaWVNN2ZRMEM2ZnlE?=
 =?utf-8?B?dW9iZXl0TmlGSVpsSEV3alh3R2dvK3FNUjdmNm05czdjTjVRcnNzTGNYVG1I?=
 =?utf-8?B?Y2FINVdkZTd1WkVFYzF6Wkh5ZkRmK24xVGJ4RUNDR3k1TWcrWjN6bXFkZXFM?=
 =?utf-8?B?VTRBWmlHQjlrUTJzMW9RZHpNYllxMkVBRFlTT3U2UlJsc1NtRkV6c01Md0x6?=
 =?utf-8?B?MVBTZFdPVEZ6OHNOK203NEFzbGViWk1kK3RYcDdwK0d2aUczNEw4U3NjQzli?=
 =?utf-8?B?QmdKY05QQ2gzakR5a29iRG9JMDJyeEx3bDIyMjlLakN1K0RCTlE3eDg3YVdo?=
 =?utf-8?B?MmN4VmdTdTdjVlQ0S3dEaGtLWUsxTmZUZmJPTmZhby9Fb2F4T0FuenhSQ1VW?=
 =?utf-8?B?UWhWVG4vMEtLbW1BSDlVVmpuRVp3b203cGF5bUVuaHFpQTArOXQxTHpwcVpU?=
 =?utf-8?B?ODJBYlh3elJlVE1UOGlFSVhEWmpsbXNYWGsxOWM5dXRYSFlDM0JrT1VrRUwv?=
 =?utf-8?B?MzZIRGVlMmxLSnBtekx2eHJCODU4U2dCVFJpRWFpRjFLTU55Y2l1N1Z0VjhC?=
 =?utf-8?B?TE8wSWFaNllONGtEV1RSRERtRHRPWFhFZDgyZkhpWXlkU0tLTzZMQzRpZUc4?=
 =?utf-8?B?UzNvc1drNlYwRVRqWEZmZjhsd0haNkZ0enBON1FGSzE3SC9MOHVKWHl0enRt?=
 =?utf-8?B?S3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff0eec2-87c2-4cc9-81e8-08de0aae0287
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 23:12:42.4538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QJj6MQFGEq8udMsEq/tMR0oPZrVFvrm5wld3GT1Vj6a7tnoMW3QJZABTaIlF91sPahMHcOUhNDmm8v7HdqE2J1T7ThAw+x6tm2sdmJyqUdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9327
X-OriginatorOrg: intel.com

--------------7BgfRo3Q1I4L68nQV3c7y5TX
Content-Type: multipart/mixed; boundary="------------f7vUhjbtTrCMEuSENAawMw3w";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, Linmao Li <lilinmao@kylinos.cn>,
 netdev@vger.kernel.org
Cc: pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
Message-ID: <cfd30b2b-efb4-4bde-8a10-fa07b3a88fab@intel.com>
Subject: Re: [PATCH net v2] r8169: fix packet truncation after S4 resume on
 RTL8168H/RTL8111H
References: <20251009122549.3955845-1-lilinmao@kylinos.cn>
 <6d9956bc-6816-4726-9bcd-03bce1b9f027@gmail.com>
In-Reply-To: <6d9956bc-6816-4726-9bcd-03bce1b9f027@gmail.com>

--------------f7vUhjbtTrCMEuSENAawMw3w
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/12/2025 2:45 PM, Heiner Kallweit wrote:
> On 10/9/2025 2:25 PM, Linmao Li wrote:
>> After resume from S4 (hibernate), RTL8168H/RTL8111H truncates incoming=

>> packets. Packet captures show messages like "IP truncated-ip - 146 byt=
es
>> missing!".
>>
>> The issue is caused by RxConfig not being properly re-initialized afte=
r
>> resume. Re-initializing the RxConfig register before the chip
>> re-initialization sequence avoids the truncation and restores correct
>> packet reception.
>>
> Seems to be some chip quirk, as the RxConfig register is re-initialized=
,
> just after the hw reset.
>=20
>> This follows the same pattern as commit ef9da46ddef0 ("r8169: fix data=

>> corruption issue on RTL8402").
>>
> I wonder whether more chip versions are affected.
>=20
> What we can do: Apply this as fix for RTL_GIGA_MAC_VER_46 in net.
> Then switch to unconditionally calling rtl_init_rxcfg() in net-next.
>=20

I had the same comment. I think this is a reasonable path as well.

Thanks,
Jake

--------------f7vUhjbtTrCMEuSENAawMw3w--

--------------7BgfRo3Q1I4L68nQV3c7y5TX
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaO2HaAUDAAAAAAAKCRBqll0+bw8o6CBs
APwK+5LOX8cNLPMp7VmhcllZoY5AJTOMssufECNxVcBx/wEAubbgAPDaR8Qc+cwdhqozZSJgfFjp
Db1bm4BM17gQ2QU=
=F2tc
-----END PGP SIGNATURE-----

--------------7BgfRo3Q1I4L68nQV3c7y5TX--

