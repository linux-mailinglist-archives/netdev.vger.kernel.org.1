Return-Path: <netdev+bounces-122941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E1196339F
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 23:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57C9B281938
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 21:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429E01AC429;
	Wed, 28 Aug 2024 21:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZxGpYeSK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30D845C1C;
	Wed, 28 Aug 2024 21:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724879382; cv=fail; b=f9eOUY/LjJg5QjBZ1unk6EtIpbLr+aZm9avw44oGk9aoyUmw4mvrK1yMbjZvScuUEyODYURvq062VXy4aifCD6i9pCx9oYDb5SOgjtL4465M7ToZnhx2DxZzKn41Bp2wFm1eunhvhO1qBcoPHKefjRo+uTR5p28l/8dSVdw1+D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724879382; c=relaxed/simple;
	bh=ZNPMsGy3rZXmClBZjk+6AmdMQM5HZoy3yxRwlrTT1r8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E8exaOig1ezTxZMzYyEurKPD0UFIvntuJmthIPjRZTELv4QlXPyEFBHhDThF+Y1OlEtKlNo3s6js4Kcv23NjEQB3jYWPg7jAnkzgVGC2/16CPcQCRomtaoAPqhJV9Q7didegjYhJ4pHje+ZwXqsrReWfUNBBY+bAXMMvSZ3hhvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZxGpYeSK; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724879380; x=1756415380;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZNPMsGy3rZXmClBZjk+6AmdMQM5HZoy3yxRwlrTT1r8=;
  b=ZxGpYeSKIOEx64097pRc8kjalLcZtuNdLgYq5vn2vCk0/olrkDiafk2h
   NbdNvkMW5i81iyCtk2qSGsoNg/JaxGsIrvtGSzkVVE5WpVjHN5U/iSJnn
   CvXhIKlvqGoEOIHwDa0OiWkXIincMOHkcRuK53/W7BBPlu+s5NzarvyLR
   1EB7ocb+LDSnchbJQhHoiz/OI+BX+ccJYJqQ+x1JGUwLGLnhBPR95qpZD
   bpoqMcuPbt/WmYNQ0UyyFnsgfxEbLWou+wWX0qChU2esgv5Jb/kqRnoTS
   EbTsBN9GEMPv2YBYIot63z0tDGpcYAdq3zcAa8LuJ0WgkULRIzxW7eBpH
   A==;
X-CSE-ConnectionGUID: KsEYJrIgROC8jVyeayiDjQ==
X-CSE-MsgGUID: HSFYUw43SriZE3GJIRy7yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="48822032"
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="48822032"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 14:09:40 -0700
X-CSE-ConnectionGUID: bqTndT0mSyOkTnOWVKzpNg==
X-CSE-MsgGUID: KhHKJ/2ySrWogvEGjIT7Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="86551496"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Aug 2024 14:09:40 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 14:09:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 14:09:39 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 28 Aug 2024 14:09:39 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 14:09:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kckGRiR1XG02ysp6cnGUnNarwmytAcX5/w6+UZ/pcNXbWxg4o6g1VqEtjVlG2i94N4bSjoa0b50uGr9hQ53sFmIIEt5eYFeMUMF3ICQDjLlikC+wpT2qG+j9ku1vrmsfyKlluhOl68v7IWcBxhLdyL4kKRI/KrwJDG1jguYkqb1QTnGfrb9m8cyTz8snc5Ylm2LIcZRU/JIuDG1Wrzusshkf0DkzPljhw/ZGzPPUKClVAdSfcVzbitIyezgfVqQx64gkpX5Go8NSSWHEuroq54+DJaRGeVJ6Vat+1QdFEdVIa2k2vNSht5Bf54Zd5q3lg7CUdUfRuwNPJrXpfJBrMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gGBpbzq/37MtNIjIPftAJZaMPZi4wnac3Ju/MC6dGo=;
 b=hvRhR4nQl8ypnO2OFkWfr5kFFEZPiSy9pMVDYDiyq8ptbwDdDM+o8LnqUthCZ6ElXibLU4vNkOygocF9few7CMxvgPY37Uhap5BZ1hiX4+LcUBmdx1yTFd/R4AFP6UdBdQASQr1XCtZCN84OeEmzBKy0tPTKVZgBa5ZR4NIbURnmHWtWbM+xLDd5bQGdU4A216jCTc2swCwGymEjry/lDS0Lij6CVMAn9w8ZfG91gtM6efbLbvT+IVFy3kI0yafJUjDRKXDRbQJGciU5ziN9FXKD+fWvlALUNHJTaylQ/PTxQCZQyyI+8c8RpaQDkgobs+MVns8VtLTmFc2BcQVFqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA0PR11MB7816.namprd11.prod.outlook.com (2603:10b6:208:407::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 21:09:36 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 21:09:36 +0000
Message-ID: <aeef6dd8-694c-4056-b6df-b1e660daedad@intel.com>
Date: Wed, 28 Aug 2024 14:09:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 net-next] net: ag71xx: get reset control using devm api
To: Rosen Penev <rosenp@gmail.com>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <linux@armlinux.org.uk>, <linux-kernel@vger.kernel.org>,
	<o.rempel@pengutronix.de>, <p.zabel@pengutronix.de>
References: <20240826192904.100181-1-rosenp@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240826192904.100181-1-rosenp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0260.namprd04.prod.outlook.com
 (2603:10b6:303:88::25) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA0PR11MB7816:EE_
X-MS-Office365-Filtering-Correlation-Id: b4b820fb-2f7a-47e3-a22f-08dcc7a5b8ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vm9LYjljbFl4ZmFQTzJieVErVlJJa2lOS1NYWkVDQytVSE9HTEo0MFNDbkp4?=
 =?utf-8?B?MysyNnA0aUYxc3Z3RU9VTEF4Z2hDNmNzY01LbFpJMnc2Y3lDTUVFQVJkK0R1?=
 =?utf-8?B?QVhsOGJRUDBSa1BlYnBGUXFYNUc4Wm9GWWNzV3VNMk5PcXRRRmlBSjZDVHlJ?=
 =?utf-8?B?ZnhCZnBQRzBBYm5waUpnNzVrbkVvVXlIZGZ6OWIrZGMvUWMzSjg4eXNxN251?=
 =?utf-8?B?MmtLN0wrVm1PdXNDQlRIVjhZN2tKUVNVMldyZmVNRTMvMWhwNUhiY2lpR1Nn?=
 =?utf-8?B?bHhDT1Jkbjcra29RK0ZCNTVPVGZFa0N2UU14b2ZHN0pYK0dkNTJwaWdaR05w?=
 =?utf-8?B?WG5SN0xlOXNLS0JWay8xSkljZWVoVlRuUmZMSXJaMldGWDlYR1BMdEhaZ3ls?=
 =?utf-8?B?TnlBQmMyU2JHK1JIb2lFZDU1SHQzWFRaZk8vY0dJa0kvT3hEYUQvSkQ2eDFB?=
 =?utf-8?B?aHA4ekdYZ0RKYVArTFdBOU5haTdyOUNodWQvRWkrVVhlazlFODR0cUI3NDFo?=
 =?utf-8?B?RFBWYVZ4VXdHaDk1MENEaWZJQmVtN1VORHR2K0hGazR2Q3I1VFM0aDZHbU4r?=
 =?utf-8?B?d0R2ZkRSZllKT1BkY2luMHJKc2hYcVhVajdSb09BR0FmTEttS28vTXZNWldX?=
 =?utf-8?B?VUVUSU9XTGt6T05zcmQvMDJUU2tqNzBJMXpObndCYm52T0hnSjdCcjRsdWtH?=
 =?utf-8?B?K1JISTVyQ21ScDQrNHVmYlYyeDg2M1R6SlRQUEV6QWYxam55ZnFuV2QxWFVC?=
 =?utf-8?B?Rzg4RXlxMjdkcTIycTZDK2xBaUVEZWxPaGtTTnlFWWVtbDdYajB3NWlGSjNS?=
 =?utf-8?B?OXhrdmNNYk96a3hCNmg3Rk5zSDRFTHRoS3NMUjR6WDZwS2ZXdys5aWNWbzY0?=
 =?utf-8?B?V2tyeEdBQmNPVVBJS3FGR2psR1pPbjBYa1F1aG9yS0p1bTdERFhHVDBCVVo4?=
 =?utf-8?B?bzBHVHFJcUxuRTZGYi9LVVVFUU9lVDJaZmx2THpERlh3ZTBhSlU0RkdibGor?=
 =?utf-8?B?ZHprZ3NGcU4vU0RVeWdScHRhSStobzhjNFNZTEhKbVBPUTl4K0FkazAyRnFU?=
 =?utf-8?B?VVJuQUdXdlVTVnlyU2hJODRiZjZxYk1nazk4ZGZIY00rL2VXSDhjMHRGVlE0?=
 =?utf-8?B?WXVxcGt3VnpzTHFoMWhIMFh2cmFOcThPb0l4VVBIdzU0M2prL0RtMGlTU0ow?=
 =?utf-8?B?bS8yK3IwTEg2a3pQbEdGM1lLTVdsU0Vxa2w1VCtBaWd4cUd2UHJERVZTMzc5?=
 =?utf-8?B?alhNNUZ5Zm5tSEtBUHNTUlg1aEJPYzdRQzg5d2szRTdvVEQ3SlM1R2lla1c2?=
 =?utf-8?B?WEpoT0VudncrZHBSUktocFdRTjY3cHVaZGJEMlgwamtDczJhMEtyQ0hnK2xL?=
 =?utf-8?B?aHZEOFh3d0FFUmtzTEcveC9xaDJvQjBsd2ExQ29KbGtLQnBERHU4dGF0Qmky?=
 =?utf-8?B?Vjl2TEE3WnBkV3JnV3dZVGNScnhHeWFERnV0MjlncENsR2IvUDY0bURGZm5D?=
 =?utf-8?B?Q2xBb2dSUUxiaVZKT0JDVTJMQWxrQWJnVFo4OFc3bldJNnhua0Z3U2VjcXdk?=
 =?utf-8?B?RGZ6bDA3c1ZlREltV3ByTHZSdHNjM0M3dXNtbnlpR09BOFMwc1VtUUlkZUQ4?=
 =?utf-8?B?NEdidGhNaXRBOWhaZlBvM2pPNkU0TXpLcnFSTXp3VTFMQTdWeWFIM2o3OGIy?=
 =?utf-8?B?SDFJa1ZCaUMxUjJlQXlsR0ZsKzZEb09jbkNtR3p6cHN3Umt5amMzM0d2dTMr?=
 =?utf-8?B?dmtES1VEb0liMEZqNldPYmtweGdsTkhpNHkvTlVrMUFydWUyNFdSV0RiY05j?=
 =?utf-8?B?c1RkdTZwNnVudmhQcFpuZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXAyMHI0UGtLNHdpSVVUUTNXN3pSd1cxWFoxU1RRVTlSU3FHM1FialVHaEVw?=
 =?utf-8?B?VjZvRHNyOEJaczRQZ1VNZGxNYmFVRTRlL3pLTHkzYk1YWWtGYkl6QnNXYlpI?=
 =?utf-8?B?V2tuTG5Xa040OGpKRk16SFQwT3IxdUZyN1lJcDVwY2FDdlJlY0U5MU5EQ2d5?=
 =?utf-8?B?V295WlczSjFacUt6R3VVNU1pUElNMnI0ZlhIb1JxTzUvMDBZNy93Yzh4ai9y?=
 =?utf-8?B?NWpuU0hKaTYzVkFVbzBOaDZUZlc4TUhkd0ZOVjJkQUI0L3cvRG8vYit3Z3B0?=
 =?utf-8?B?ZnNDc094RUpqUVNIRTVKQmQ0SXk0TXdyWnNwUXhJU2NXSFU1eElWazNrNXZZ?=
 =?utf-8?B?UFZTOVVIRjQ0WVRML0lsdUJxblg1bE5DV3pZWVNZekVNbWVyZVRDTElwb2NE?=
 =?utf-8?B?VnFMNStPQklGaGJ3ejN3NWxDTXdGVUdIblhXUThuWnVOSEI5enBKOWNpalhj?=
 =?utf-8?B?b2lDeW8xNUNPYU9XdXpNNDYyV2t0VDljRWZhN1kvc1grOU1nM2YvN2x3eXNz?=
 =?utf-8?B?QjdJSnkzTHM3Sk5WaStHbHRrSDZnZmdMbkNLV3pSdzFUVW1obkY1UVBIYkFi?=
 =?utf-8?B?YVlENkU2NEZESDdUQWNvcHFrTU5URDBaSHFyaFU4V2QveGZUSExrcjZTSzIr?=
 =?utf-8?B?NngvY0pheURwVkgzcGpEN2Rrdk00K3pKWFlpMXMxVUZvZTVDaTFlWlRPSWNj?=
 =?utf-8?B?TzlwQTBxTktaTnVPbFhKNmxKcUxXVzBhTy9HRldiZko0UUZCZW9CNzdBS21p?=
 =?utf-8?B?QzkwU2VQWkQzajVVNGZCQ25xaGN6Z0R1QnFzbTNydUhtWjFtNHpRa2NSZ3k1?=
 =?utf-8?B?WDJCYVRjMk9SUTlhc3U2alJUeUJLQUhyM3IrcTNmZ3BYUkhxRGVnaHhsOFVT?=
 =?utf-8?B?UUtLYlkyekFuTVJTdWZxazNjVjl5eXBVOENGeWxjakhjRmhmQkdOS2VXOHNF?=
 =?utf-8?B?WDVmeVdXSjRjZXVsUlZrVHFmRVc0a1RneEZHRkxzSzRwaW9kQllwK2pMK0Vp?=
 =?utf-8?B?MVpXRm5mTC9uazJpcWs5VEpId3BLNVZxUjFnWmFJWXpybjFXa01kRk9zZDNS?=
 =?utf-8?B?cG9LelJxY25uQVAvTDh5RGJYazRoWTgxOE9zcjg5Y3lKWllIQUFNVUUyZk50?=
 =?utf-8?B?L1FWcjJQOWUzVWZwY0dOZmxOZ3o2V0ZnNjgxbzY0aGVQRzJnUDZiVkR5RjZk?=
 =?utf-8?B?SExCYlNDak9EY1ZFL1Q5a1ZiYk1iU1AzaU5DdEtoTkRGcW41UFVCMnVwQmpl?=
 =?utf-8?B?UXdmaW91YVRLQWg4SDljbzFZY0E5alluSVFUUUFJbUhUQ3RRV3p0blRJSXdF?=
 =?utf-8?B?REM2dUtEaHgzS0E2VnVNMGpLTVV2eEU1M0d0ejY5QmRQdHZ4ZlFxOEU1dmFt?=
 =?utf-8?B?SFY3Z2tjYXNrdDdmRVlEbE1wdHlkUUdFVzhQRCt6RnlveUM0OTdwbFkveHBl?=
 =?utf-8?B?THZyczdIN1krVkNFTUxnRC9uYllqd2FnckNMZldSTElGa1VtK0g1b08vNXpa?=
 =?utf-8?B?MTdXWXJ6bHgxcFozalN0clVENytJSDJheFk1cklSRlFhcTFjQ0xnV09TVUth?=
 =?utf-8?B?MU9rd2ZGUFhTZnlyWm9GUUNpNWlYdksyVmxjYUZEMERLUEhHKzJxd2k1SHl3?=
 =?utf-8?B?N1RSdnptNlRHWVB6dTF0USt1S0grMGNyS0dQM0tnNkxZTU8yaTFBOGtZaEVa?=
 =?utf-8?B?VnJtMVE3VVJGWHVSNWVIVnJVOHozckFXZ2pibGNobjE3amFaS1BqTkliMTZW?=
 =?utf-8?B?MlBjd3BEVjZkYnRJd2NmQUNJOGh6akcxUjNmU1cvbVdyL0twTzA2MWxmMUYv?=
 =?utf-8?B?M1FrSHVhT0dYTVgvQmduYS93eFpPT2NEZmEwMnBoVGduanFMRkIxRXZCeTcy?=
 =?utf-8?B?dDUrNElsYVZ4ZS82YVlRUWFVQ0d4R1lHcWVvcWpGd1dTZHNOVklRdG11QlRr?=
 =?utf-8?B?Q0dTUEdHcTZsa2lkOEVDSXVqdHM5ZmtSWS9KS3ViMUdDeWxSNFQ2N1NCTnhW?=
 =?utf-8?B?YUFDeWI3aXpXdGdoV2FLS0RVdDVRTW5TMWsyZDNmWmlIYlpibXdCdCtRL0JB?=
 =?utf-8?B?azBNVWJyM21GdCt3Vmwya3puTzhlaVVQYzN4dXY5MzZHbkxPRDBaOG1OOGR4?=
 =?utf-8?B?Tkowb0pSTmFLcWJDU0ozMlo5cXE0amN0NGRWREM4dnczTzgyQ2FZRnZNOTdN?=
 =?utf-8?B?L0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b820fb-2f7a-47e3-a22f-08dcc7a5b8ef
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 21:09:36.6937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uvg6ap6RCjRIyrvw6CGkfyUioOA26l3gJCuEA7OxYqflKIbUPROvQ0FalTuW2OR4XD/FO4Ab7KmP2ucbOB3czf2WcKBOX+Jo0fvp6eGCLAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7816
X-OriginatorOrg: intel.com



On 8/26/2024 12:28 PM, Rosen Penev wrote:
> Currently, the of variant is missing reset_control_put in error paths.
> The devm variant does not require it.
> 
> Allows removing mdio_reset from the struct as it is not used outside the
> function.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

