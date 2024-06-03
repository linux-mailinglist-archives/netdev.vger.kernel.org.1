Return-Path: <netdev+bounces-100198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7188D81F2
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 14:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DFDAB216C6
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 12:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DF1128363;
	Mon,  3 Jun 2024 12:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GX7iI7V5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7F1127E3D;
	Mon,  3 Jun 2024 12:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717416647; cv=fail; b=dvJhHlEhQQaLZ9MQR7XcmhECDUL3eyzfHOxWy5boJPhFdSLsAeqLze74cyEz/evKfApbeIfhWPgiE/ujtGif0L6IVAbwbwzWeBSsnn8/RweZqe83DapMl9wh1PjNtNPiu8GQN4CReVupuGZvufbEgALza+s1b/P5BOLfVYdXUL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717416647; c=relaxed/simple;
	bh=n47lfyxxNYC7JOwNCXIKLkKywwbrhf6SfnUWwMT9eVU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pYOq1ictIiMRnRbxG9Yb5duoUsY1lUbIlyXBd0p6j7+z+ra++ibrSTGZM6BN6NiCbVRnldrcnP9fRh3KC4O7QMCVSPy+RNe01sGN0qY9yIJ6Ryd3CRe4/7FeMrqTPvumHWDYTP3t4BH+56bE2ftApuWdDsy+d8MuZapi2cQaw1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GX7iI7V5; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717416646; x=1748952646;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n47lfyxxNYC7JOwNCXIKLkKywwbrhf6SfnUWwMT9eVU=;
  b=GX7iI7V5oJv17KXjR1UFsM3n7+eDoc/7XTjSjbtzvQoxbiBcsRXH0iR1
   7jD1tCv2jOvY9dUwc6ytyiO0UcLfi/lUKrhInN13MHEfjaLt+oBqXY6hb
   48DY2Cfya7clMDZX+zI4gqG1suqE+uHIgyrG/5PKtqHHnP3kGEYVJtf9U
   rek2AyL3+IdhfUIXSZJKmSfUKe9pZS1KNAMhs1hayh4urUVYaChDkOaNt
   8qTvM1ZmnlN/azPMJLo51ErptGRamFg1hZpIn4qoy3ENDxl8xqxRwqyIG
   3DGoljxRTGq4e0yMqrmAAh/vzKMp0dxLXRoq8iDbgO0b8W6TjN37AXW6H
   Q==;
X-CSE-ConnectionGUID: FqFuPNLLQN2v/FZGlHe1sw==
X-CSE-MsgGUID: rH8vbvogQx+ul1yZ4+lhqw==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="31401054"
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="31401054"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 05:10:45 -0700
X-CSE-ConnectionGUID: iSHMtXXrQmuqoXrs1PzOpA==
X-CSE-MsgGUID: pXU3NVlPSpuXRAACglthYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="41949119"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jun 2024 05:10:44 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 05:10:43 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 05:10:42 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 05:10:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 05:10:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKus8IEUUAbXEP//IHe3yyZzyBUAKoKQwEz2Ss9vaTu7VSfYsmsS60Eamz9RA+WqZy5C9vMc9jW5auxcgklCtmhVh742024Fx0LAVjP2zew7iaEyo1MR8FzBqcHBfxS0AwDoV7b3sDIoNOh4y7VKEcw4OHo7LguJCiZChzSdy5oB5pKp4XLvVm9G4boOblbKSK98DJ8jE1Tg4QMZ7RaDzjbDd+/YkWopqe0lMfNlO0mlffNtmv+gnEyYzpJQJ4MZmUF87tc9CdNK8p83tFGD9Pzpz4F5sjkKTkTXZzIWPLRVQnf1B+NXqzGE05REU/3dviYVJx21Nw5g2W2g0d/lCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1/PfTo4PuFIgbPnfnVIIeFR7AEicfo5CEdQqL6vxCQ=;
 b=laerJ9z/vf7OJ20gsZRwoQr7yaRjzzWVEwmE2fTJIBxty6Xi7VnCVojRP7aKS5xPeijvJ1bNNrtL7psTb12qRATGNB/FVw2+ybtqFmdqG+XzIUO2luapFxiSegGQa72UtJdIhAmJHD/PhrkJ0jsDn7D1aXPmFcsHK8bMP2ghINv3fBEo/hciQZc9MMHd1lTZp1p55/fDyMAQTcFaeqTg+E4YCQVAAlaPoH+pqc/iuP/KkaRRcfBwnYIOKND/aO2bPD24XyncRyo9KdTaqNztCZK6oNJClNnPPiUM4OQBxl3lHFEzgPTa2OgbAUpE067KF1Ygk/WTZd+fWQvvHhlvRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by IA0PR11MB7257.namprd11.prod.outlook.com (2603:10b6:208:43e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Mon, 3 Jun
 2024 12:10:39 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 12:10:38 +0000
Message-ID: <ccab5ce4-8b9a-447a-a197-d7f872d35eba@intel.com>
Date: Mon, 3 Jun 2024 14:10:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next] net: hsr: Send supervisory frames to HSR
 network with ProxyNodeTable data
To: Lukasz Majewski <lukma@denx.de>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Eric Dumazet <edumazet@google.com>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, Oleksij Rempel
	<o.rempel@pengutronix.de>, <Tristram.Ha@microchip.com>, "Sebastian Andrzej
 Siewior" <bigeasy@linutronix.de>, Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Simon Horman <horms@kernel.org>, Nikita Zhandarovich
	<n.zhandarovich@fintech.ru>, Murali Karicheri <m-karicheri2@ti.com>, "Arvid
 Brodin" <Arvid.Brodin@xdin.com>, Dan Carpenter <dan.carpenter@linaro.org>,
	"Ricardo B. Marliere" <ricardo@marliere.net>, Casper Andersson
	<casper.casan@gmail.com>, <linux-kernel@vger.kernel.org>, Hangbin Liu
	<liuhangbin@gmail.com>, Geliang Tang <tanggeliang@kylinos.cn>, Shuah Khan
	<shuah@kernel.org>, Shigeru Yoshida <syoshida@redhat.com>
References: <20240603110329.3157458-1-lukma@denx.de>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240603110329.3157458-1-lukma@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR10CA0090.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::19) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|IA0PR11MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ae3cad5-cc25-4705-abea-08dc83c62e67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUFzQUphSjUzM2NvdWd4eHQrOE81M08xNG44VVN0T1RaT2NEYXpPSnlZelMr?=
 =?utf-8?B?M0pUSlVjNmIzZFFVN0crK3RUZlVVc1lZTmxMbVFxWURsUVhaRzBqQkNvMUN4?=
 =?utf-8?B?dHdrV21kWWo4YUhZVDdkTVBUK1ZZd3ZzZ1NNMExLV3cvMTZwQk54NTBUR3hk?=
 =?utf-8?B?a21TSHI5ZHh4b2phRm85VGE1a1VZVUVwOWhaeitlWjhWa2tmdVlabnRrdnJ1?=
 =?utf-8?B?MUUxNWxnQ2s4UTUrWFdOTEZ4MFRrOGgrTWhpZWJvUllKOGVVTlgrbFQ5RFJy?=
 =?utf-8?B?UVFQUGlGNzZDNy9Oell5ejhFcldHNmVJWkx3VDF0blJxRUtxd21RSVVoUWFn?=
 =?utf-8?B?WHFlQzA1M1B5ci9RZUVlaTgvdi9BZzlmY0hrMHNIak1sUWcwRThsSjl1ejUy?=
 =?utf-8?B?L3Vvc1FSZ3RmU2VpRHF1WDA5Mjg2VGdhbkhmL3BYaVBFZ09rU0JUNU1UQ21T?=
 =?utf-8?B?a3ZVR3ZYdEFnRFlCNDlFeUpZM0FVdHI0T1NEZUIxeUUwa0pTQTBhSkRRWjJi?=
 =?utf-8?B?VWs4QUNKK3V3T3BRNEJQKzNKaFlOS0NhZDFlOEN1aUEwUTN2MmgybEJQTm5w?=
 =?utf-8?B?WGJNajc0ZmJxNU5sS2toT2xYRmhac1BWNmljMW1seTV5RmRvYTFCOUhXS3lH?=
 =?utf-8?B?SWNwS0tFTFhWNWsxd2F6Z3hMajVCSC9SbHYxWVQ0cGpmRHZNRTd4UGZ4cjFO?=
 =?utf-8?B?Uk9sOExqSHZ3anZGckdzSzd2RnpMS1JqNXROK0pBRzk4YlI2TzhDczRIQisy?=
 =?utf-8?B?Nkx6dGlhbUZMTmtMZUI5dHhWTXplbHhQclhEN202OVdnRllDbi9rNERKZXlz?=
 =?utf-8?B?VzlpYmF5UjZ3cGNkMmRSUTB1cVVNcEM4UDhhMmZYNEY3WTdSV01zQVF5UjIw?=
 =?utf-8?B?U2dKeSt6NnpuVStkalpkOXE5OGVqQm9nVmEzdUxxRURzR3RIVCtvbGJrRC8w?=
 =?utf-8?B?TUhxVldpdngzL0kyN3lDOWlPMHF2aFNySUxmOEIwTUVjeXVyK2RIUkxjSlNj?=
 =?utf-8?B?cGtXR1ZaamVYMElYNWU2TUZGUGErNER3N3hnZkhLeGREd0JOWWVieHVuRG05?=
 =?utf-8?B?L1JscGl1NEo5SGEvbFJaYUpkdmdHVGxkUGh3eng0bDlaS2NUSndMRU1OVlA3?=
 =?utf-8?B?Skd5TjIrS0ZzeUZDOEJTNURDYzJ0ekhoQ0MxRWZpVCs5R3RSc1E4dGs2dmww?=
 =?utf-8?B?MmN0RE4zOE5kYlJMTFhKVERMKzU3MndWZE4vQTRuL0swL1VyYjNXZE0rbStr?=
 =?utf-8?B?aVR0WER4RHlYZEtrSG9xR1EyWmtTVTJ1eXpNQWtFQmwzcGhETEd6ZXc3bmc2?=
 =?utf-8?B?ejhvdGhZM3dpNHBKWlY2eWEvVW1jRUR6R3E4MmQ0TTJaVnR6cmgwQy93LzBF?=
 =?utf-8?B?Zm1JVmI2d1pNT0hBTDRtZmFocEpsQlUxbCs2K0dEUHhJS0dtdzR4MTNMbW9n?=
 =?utf-8?B?SlFXdE5JQXNTYWpNWm4vZTlZN1RQTFZQejkwSitDNlNWM3lONDVLRG5HdExv?=
 =?utf-8?B?MDJoZTVpTXA5U21lZ0lXU0cxVkxJMzcwZTYvclFpK1k1V0txaGV3aGpHWTZ6?=
 =?utf-8?B?Ym82RXJnai81aVpuL1dYNTNoa1JEZTRvaENkQ1c4dVIrQlZQQzVwdlk1OVlE?=
 =?utf-8?B?dHVSdGNFd0RBekF5ZERjZkJPelF4ZGVCblgrajUwZlFSSmNOa3lweEZ3cUJw?=
 =?utf-8?B?SjhTSDQzcHJSTU04WWo3cHlOQjBvZFZ1ZlU4eXFqaVVyeE9xM24zZ0FnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWxPbzdiUDlKMkV0UDlsOU9HMDd4MjRwOFZJdVQzdVJqMTFOSURMZHhLOU5W?=
 =?utf-8?B?NzFpOERYS2lPdmVjTlJ2ajFrejBtbUh1UUk2UlowVmFad2NFR3EzUE9tREdQ?=
 =?utf-8?B?Q0ZSOWRDRzhlVE5tMHFTT1lkM3ZKU0ErNnBZRGprYnpOVjFtbkg1YVdXTVY0?=
 =?utf-8?B?Z0lnR0J6TWZjcU0yVUg5eW4xK1JBN0Zic3cwekFHNkg5WHZIVVpXeVRwbTY2?=
 =?utf-8?B?ODBMTTdOTEVCZTMvbGJxRXdmbDFiUVI2aXpycFgxRVF2dDhMMExKWE1Dcm54?=
 =?utf-8?B?MW55RHB2SHpOUHFkZmh4YXZaN1hMV0lGYmtDL1RDOVdSUk1lbDIwY1ZGTHNK?=
 =?utf-8?B?c2hpalJQdEorQllyZFlvY2ZFMVpKSGlUeE9POHlXZXNrbmZIaVFjWG9rU1Zy?=
 =?utf-8?B?bkRZc2drbE5BTHJmQUt5bE5RZm81QmJjaUMvSUNhajNWT2xnN2NTRzdRRjM1?=
 =?utf-8?B?RVM0TUhoYjZvODZJTlRITGh2cmpwNmgxL1dXTXM2a05yd2ZuSVRqMXVLQTlk?=
 =?utf-8?B?VmxNemhyaitENjV4RENDSVFBTVJiWkMvOXJidGJ6M2dvSHVoMEhnRXM1UFMv?=
 =?utf-8?B?VzRBTVdnOW5zdWRtN21JZG93cy9YaDB5aFo4L0J1TkFiVTRPMGhRVlNMT1BX?=
 =?utf-8?B?V2FjRmZoU04rRmFHSXhiY1dZdlFnbnAxRkRSWTFCc1hnYTNtbGp3R2RGaU9G?=
 =?utf-8?B?SGhpSlZ0T2FVNml0ZTlBdWtqVDl3dHRvWGhiOUkzMDhROHZYZXU0WkovL3hm?=
 =?utf-8?B?ODJaaTAzdFlHWGRJRUZhdExIM2xZbk10ZElMRnk4NFpURnNWK0tXalNaTXp2?=
 =?utf-8?B?ZmdXcC8rUlh0WFVQZ2ltRjYxVnRzcXgyWG9xR3pjTkJFYUhHcUtZbVFJTlhR?=
 =?utf-8?B?ZlRqNVAvVEpMeTNOUUVmbUxrUE5rNlpmRThOSHZIV0kwUmEyUzV1SlVvN1N4?=
 =?utf-8?B?dmJiWWo3SzlpYm5xOENZaDZJNXQ2R0ZLVmJqdjJacWdNSW1RRDNZZktKdzdU?=
 =?utf-8?B?Qm9Nd3VWWWw0TVRTRERrSTZwSDRkZEkzb1A3UnYwVmsxdW9VT29WNDh6djR0?=
 =?utf-8?B?NHAzaXRqZUM2QkNkVldCeFh1ekh4c0llUjR5bWxZWWphSTNBSFFIZ1o1TkN6?=
 =?utf-8?B?TGl1ajdTRy9KR3c0VjUxNnRtUFZFaFY5VmZ3NWpFSXNEY0FKTnc0UzV3RkI5?=
 =?utf-8?B?cENJWU1pWTJNdDhmM2pXYmZ5WlVPNFZoRmx5MVpDaGZmNkhHMmJyYlEwRzNs?=
 =?utf-8?B?MzZtVHNHYmFBbGVlUk1rYVhzZ3Y1eFhrY1U0VEI4UTk0d2Q4RDRQMEJPVkdp?=
 =?utf-8?B?TmtQei8vVjFCWFNHVjQ3cWhwYkpXQnhuRzhuL2NGWHRlNjV6ZTF0MlZtUytH?=
 =?utf-8?B?Vk9tdkdDbHZnZ0dUUm5CQWF6b0VPNXdrb00vbjRZMU9DbTQ1UHlqS1VRNnl2?=
 =?utf-8?B?ZDBha1RkNWlDRlBBM2RhQTJvYXpGQWxJWWJ3M05TVkE1V3dueCtSblBhdURU?=
 =?utf-8?B?Qld2TURsd09LQlJNMlVwWXo4UjR0bG5OZS93MlpBSkJPTTVydWtyVGRmY3hZ?=
 =?utf-8?B?UFBkZWtDZytIb0dUMHRyZng3WGVOQkhiWHgyWW9MbVIrOTVxOUdoM21mNU1i?=
 =?utf-8?B?cExaQys2TlkxTGJyVnliNzliS0pFalJKRDMzTDJNdUVPZ2E2ZVdWZXZ6dUN2?=
 =?utf-8?B?RmZhSXByV1hQNXR6QnV3V0JXcmI5dG1rL2s4OEZpUExXSnBPNEFUcW4xSnVW?=
 =?utf-8?B?THFSYS9FaHdkK3h0VDUyazdacHkrWE5xSlp0WUQ5cE5RWVNhOXZTQm1VMHJR?=
 =?utf-8?B?ek1SSjArVGlRRnBlaC92aEZ6L2srSGVBOG4yelR3M0JRa05meEpicWVPNHFu?=
 =?utf-8?B?dzEyS2hJbVA5UFEzcVdXUHQzNit3V2ZoWENrckVhMHFYUDJTbENhU2w5YkU4?=
 =?utf-8?B?RHA0WlN5SjlMSWJWcllzeU5BZzJVcklRYkFMRGtubWtCWnc2SW9rTHE3ZHBG?=
 =?utf-8?B?ejBwTE9wVlRsWnFJS2tQdVNqai9hUm1UVGFXaklqV3BGWWlJRUtUaUhOdVJW?=
 =?utf-8?B?QVVDUmE0RUNwZ1V1SndsdGtsTlV6UFZ5dUF1QWcrMnhFazdRY0N4dzlORkJt?=
 =?utf-8?B?WnNTRWgxbGhzazFIVUVVRVFGaTNGWTdhc3JyRTBrTXhnOU5LdnlaZGF4YkI0?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae3cad5-cc25-4705-abea-08dc83c62e67
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 12:10:38.7458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KnoW74OeiPc7dogKp8kCgV+pjwlf1fM2XNuwPXCeaEmvoe7gqGwUgipEz55OYbX3J0hfpI3KXcW+YJpwMm2KfdugekBZWcnwqg7Kn1MU7r0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7257
X-OriginatorOrg: intel.com



On 03.06.2024 13:03, Lukasz Majewski wrote:
> This patch provides support for sending supervision HSR frames with
> MAC addresses stored in ProxyNodeTable when RedBox (i.e. HSR-SAN) is
> enabled.
> 
> Supervision frames with RedBox MAC address (appended as second TLV)
> are only send for ProxyNodeTable nodes.
> 
> This patch series shall be tested with hsr_redbox.sh script.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  net/hsr/hsr_device.c   | 63 ++++++++++++++++++++++++++++++++++--------
>  net/hsr/hsr_forward.c  | 40 +++++++++++++++++++++++++--
>  net/hsr/hsr_framereg.c | 15 ++++++++++
>  net/hsr/hsr_framereg.h |  2 ++
>  net/hsr/hsr_main.h     |  4 ++-
>  net/hsr/hsr_netlink.c  |  1 +
>  6 files changed, 111 insertions(+), 14 deletions(-)
> 
> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> index e6904288d40d..f85331d75454 100644
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -73,9 +73,15 @@ static void hsr_check_announce(struct net_device *hsr_dev)
>  			mod_timer(&hsr->announce_timer, jiffies +
>  				  msecs_to_jiffies(HSR_ANNOUNCE_INTERVAL));
>  		}
> +
> +		if (hsr->redbox && !timer_pending(&hsr->announce_proxy_timer))
> +			mod_timer(&hsr->announce_proxy_timer, jiffies +
> +				  msecs_to_jiffies(HSR_ANNOUNCE_INTERVAL) / 2);
>  	} else {
>  		/* Deactivate the announce timer  */
>  		timer_delete(&hsr->announce_timer);
> +		if (hsr->redbox)
> +			timer_delete(&hsr->announce_proxy_timer);
>  	}
>  }
>  
> @@ -279,10 +285,11 @@ static struct sk_buff *hsr_init_skb(struct hsr_port *master)
>  	return NULL;
>  }
>  
> -static void send_hsr_supervision_frame(struct hsr_port *master,
> -				       unsigned long *interval)
> +static void send_hsr_supervision_frame(struct hsr_port *port,
> +				       unsigned long *interval,
> +				       const unsigned char addr[ETH_ALEN])
>  {
> -	struct hsr_priv *hsr = master->hsr;
> +	struct hsr_priv *hsr = port->hsr;
>  	__u8 type = HSR_TLV_LIFE_CHECK;
>  	struct hsr_sup_payload *hsr_sp;
>  	struct hsr_sup_tlv *hsr_stlv;
> @@ -296,9 +303,9 @@ static void send_hsr_supervision_frame(struct hsr_port *master,
>  		hsr->announce_count++;
>  	}
>  
> -	skb = hsr_init_skb(master);
> +	skb = hsr_init_skb(port);
>  	if (!skb) {
> -		netdev_warn_once(master->dev, "HSR: Could not send supervision frame\n");
> +		netdev_warn_once(port->dev, "HSR: Could not send supervision frame\n");
>  		return;
>  	}
>  
> @@ -321,11 +328,12 @@ static void send_hsr_supervision_frame(struct hsr_port *master,
>  	hsr_stag->tlv.HSR_TLV_length = hsr->prot_version ?
>  				sizeof(struct hsr_sup_payload) : 12;
>  
> -	/* Payload: MacAddressA */
> +	/* Payload: MacAddressA / SAN MAC from ProxyNodeTable */
>  	hsr_sp = skb_put(skb, sizeof(struct hsr_sup_payload));
> -	ether_addr_copy(hsr_sp->macaddress_A, master->dev->dev_addr);
> +	ether_addr_copy(hsr_sp->macaddress_A, addr);
>  
> -	if (hsr->redbox) {
> +	if (hsr->redbox &&
> +	    hsr_is_node_in_db(&hsr->proxy_node_db, addr)) {
>  		hsr_stlv = skb_put(skb, sizeof(struct hsr_sup_tlv));
>  		hsr_stlv->HSR_TLV_type = PRP_TLV_REDBOX_MAC;
>  		hsr_stlv->HSR_TLV_length = sizeof(struct hsr_sup_payload);
> @@ -340,13 +348,14 @@ static void send_hsr_supervision_frame(struct hsr_port *master,
>  		return;
>  	}
>  
> -	hsr_forward_skb(skb, master);
> +	hsr_forward_skb(skb, port);
>  	spin_unlock_bh(&hsr->seqnr_lock);
>  	return;
>  }
>  
>  static void send_prp_supervision_frame(struct hsr_port *master,
> -				       unsigned long *interval)
> +				       unsigned long *interval,
> +				       const unsigned char addr[ETH_ALEN])
>  {
>  	struct hsr_priv *hsr = master->hsr;
>  	struct hsr_sup_payload *hsr_sp;
> @@ -396,7 +405,7 @@ static void hsr_announce(struct timer_list *t)
>  
>  	rcu_read_lock();
>  	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
> -	hsr->proto_ops->send_sv_frame(master, &interval);
> +	hsr->proto_ops->send_sv_frame(master, &interval, master->dev->dev_addr);
>  
>  	if (is_admin_up(master->dev))
>  		mod_timer(&hsr->announce_timer, jiffies + interval);
> @@ -404,6 +413,37 @@ static void hsr_announce(struct timer_list *t)
>  	rcu_read_unlock();
>  }
>  
> +/* Announce (supervision frame) timer function for RedBox
> + */
> +static void hsr_proxy_announce(struct timer_list *t)
> +{
> +	struct hsr_port *interlink;
> +	unsigned long interval = 0;
> +	struct hsr_node *node;
> +	struct hsr_priv *hsr = from_timer(hsr, t, announce_proxy_timer);

RCT :)

> +
> +	rcu_read_lock();
> +	/* RedBOX sends supervisory frames to HSR network with MAC addresses
> +	 * of SAN nodes stored in ProxyNodeTable.
> +	 */
> +	interlink = hsr_port_get_hsr(hsr, HSR_PT_INTERLINK);
> +	list_for_each_entry_rcu(node, &hsr->proxy_node_db, mac_list) {
> +		if (hsr_addr_is_redbox(hsr, node->macaddress_A))
> +			continue;
> +		hsr->proto_ops->send_sv_frame(interlink, &interval,
> +					      node->macaddress_A);
> +	}
> +
> +	if (is_admin_up(interlink->dev)) {
> +		if (interval == 0)

if (!interval)

> +			interval = msecs_to_jiffies(HSR_ANNOUNCE_INTERVAL);
> +
> +		mod_timer(&hsr->announce_proxy_timer, jiffies + interval);
> +	}
> +
> +	rcu_read_unlock();
> +}
> +
>  void hsr_del_ports(struct hsr_priv *hsr)
>  {
>  	struct hsr_port *port;
> @@ -590,6 +630,7 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
>  	timer_setup(&hsr->announce_timer, hsr_announce, 0);
>  	timer_setup(&hsr->prune_timer, hsr_prune_nodes, 0);
>  	timer_setup(&hsr->prune_proxy_timer, hsr_prune_proxy_nodes, 0);
> +	timer_setup(&hsr->announce_proxy_timer, hsr_proxy_announce, 0);
>  
>  	ether_addr_copy(hsr->sup_multicast_addr, def_multicast_addr);
>  	hsr->sup_multicast_addr[ETH_ALEN - 1] = multicast_spec;
> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index 05a61b8286ec..2aa2621d8517 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c
> @@ -117,6 +117,38 @@ static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
>  	return true;
>  }
>  
> +static bool is_proxy_supervision_frame(struct hsr_priv *hsr,
> +				       struct sk_buff *skb)
> +{
> +	struct hsr_sup_payload *payload;
> +	struct ethhdr *eth_hdr;
> +	u16 total_length = 0;
> +
> +	eth_hdr = (struct ethhdr *)skb_mac_header(skb);
> +
> +	/* Get the HSR protocol revision. */
> +	if (eth_hdr->h_proto == htons(ETH_P_HSR))
> +		total_length = sizeof(struct hsrv1_ethhdr_sp);
> +	else
> +		total_length = sizeof(struct hsrv0_ethhdr_sp);
> +
> +	if (!pskb_may_pull(skb, total_length))
> +		return false;
> +
> +	skb_pull(skb, total_length);
> +	payload = (struct hsr_sup_payload *)skb->data;
> +	skb_push(skb, total_length);
> +
> +	/* For RedBox (HSR-SAN) check if we have received the supervision
> +	 * frame with MAC addresses from own ProxyNodeTable.
> +	 */
> +	if (hsr_is_node_in_db(&hsr->proxy_node_db,
> +			      payload->macaddress_A))
> +		return true;
> +
> +	return false;

return hsr_is_node_in_db();

> +}
> +
>  static struct sk_buff *create_stripped_skb_hsr(struct sk_buff *skb_in,
>  					       struct hsr_frame_info *frame)
>  {
> @@ -499,7 +531,8 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
>  					   frame->sequence_nr))
>  			continue;
>  
> -		if (frame->is_supervision && port->type == HSR_PT_MASTER) {
> +		if (frame->is_supervision && port->type == HSR_PT_MASTER &&
> +		    !frame->is_proxy_supervision) {
>  			hsr_handle_sup_frame(frame);
>  			continue;
>  		}
> @@ -637,6 +670,9 @@ static int fill_frame_info(struct hsr_frame_info *frame,
>  
>  	memset(frame, 0, sizeof(*frame));
>  	frame->is_supervision = is_supervision_frame(port->hsr, skb);
> +	if (frame->is_supervision && hsr->redbox)
> +		frame->is_proxy_supervision =
> +			is_proxy_supervision_frame(port->hsr, skb);
>  
>  	n_db = &hsr->node_db;
>  	if (port->type == HSR_PT_INTERLINK)
> @@ -688,7 +724,7 @@ void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
>  	/* Gets called for ingress frames as well as egress from master port.
>  	 * So check and increment stats for master port only here.
>  	 */
> -	if (port->type == HSR_PT_MASTER) {
> +	if (port->type == HSR_PT_MASTER || port->type == HSR_PT_INTERLINK) {
>  		port->dev->stats.tx_packets++;
>  		port->dev->stats.tx_bytes += skb->len;
>  	}
> diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
> index 614df9649794..8d2a5e8adf83 100644
> --- a/net/hsr/hsr_framereg.c
> +++ b/net/hsr/hsr_framereg.c
> @@ -36,6 +36,17 @@ static bool seq_nr_after(u16 a, u16 b)
>  #define seq_nr_before(a, b)		seq_nr_after((b), (a))
>  #define seq_nr_before_or_eq(a, b)	(!seq_nr_after((a), (b)))
>  
> +bool hsr_addr_is_redbox(struct hsr_priv *hsr, unsigned char *addr)
> +{
> +	if (!hsr->redbox || !is_valid_ether_addr(hsr->macaddress_redbox))
> +		return false;
> +
> +	if (ether_addr_equal(addr, hsr->macaddress_redbox))
> +		return true;
> +
> +	return false;

You could just return ether_addr_equal here

> +}
> +
>  bool hsr_addr_is_self(struct hsr_priv *hsr, unsigned char *addr)
>  {
>  	struct hsr_self_node *sn;
> @@ -591,6 +602,10 @@ void hsr_prune_proxy_nodes(struct timer_list *t)
>  
>  	spin_lock_bh(&hsr->list_lock);
>  	list_for_each_entry_safe(node, tmp, &hsr->proxy_node_db, mac_list) {
> +		/* Don't prune RedBox node. */
> +		if (hsr_addr_is_redbox(hsr, node->macaddress_A))
> +			continue;
> +
>  		timestamp = node->time_in[HSR_PT_INTERLINK];
>  
>  		/* Prune old entries */
> diff --git a/net/hsr/hsr_framereg.h b/net/hsr/hsr_framereg.h
> index 7619e31c1d2d..993fa950d814 100644
> --- a/net/hsr/hsr_framereg.h
> +++ b/net/hsr/hsr_framereg.h
> @@ -22,6 +22,7 @@ struct hsr_frame_info {
>  	struct hsr_node *node_src;
>  	u16 sequence_nr;
>  	bool is_supervision;
> +	bool is_proxy_supervision;
>  	bool is_vlan;
>  	bool is_local_dest;
>  	bool is_local_exclusive;
> @@ -35,6 +36,7 @@ struct hsr_node *hsr_get_node(struct hsr_port *port, struct list_head *node_db,
>  			      enum hsr_port_type rx_port);
>  void hsr_handle_sup_frame(struct hsr_frame_info *frame);
>  bool hsr_addr_is_self(struct hsr_priv *hsr, unsigned char *addr);
> +bool hsr_addr_is_redbox(struct hsr_priv *hsr, unsigned char *addr);
>  
>  void hsr_addr_subst_source(struct hsr_node *node, struct sk_buff *skb);
>  void hsr_addr_subst_dest(struct hsr_node *node_src, struct sk_buff *skb,
> diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
> index 23850b16d1ea..ab1f8d35d9dc 100644
> --- a/net/hsr/hsr_main.h
> +++ b/net/hsr/hsr_main.h
> @@ -170,7 +170,8 @@ struct hsr_node;
>  
>  struct hsr_proto_ops {
>  	/* format and send supervision frame */
> -	void (*send_sv_frame)(struct hsr_port *port, unsigned long *interval);
> +	void (*send_sv_frame)(struct hsr_port *port, unsigned long *interval,
> +			      const unsigned char addr[ETH_ALEN]);
>  	void (*handle_san_frame)(bool san, enum hsr_port_type port,
>  				 struct hsr_node *node);
>  	bool (*drop_frame)(struct hsr_frame_info *frame, struct hsr_port *port);
> @@ -197,6 +198,7 @@ struct hsr_priv {
>  	struct list_head	proxy_node_db;	/* RedBox HSR proxy nodes */
>  	struct hsr_self_node	__rcu *self_node;	/* MACs of slaves */
>  	struct timer_list	announce_timer;	/* Supervision frame dispatch */
> +	struct timer_list	announce_proxy_timer;
>  	struct timer_list	prune_timer;
>  	struct timer_list	prune_proxy_timer;
>  	int announce_count;
> diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
> index 898f18c6da53..f6ff0b61e08a 100644
> --- a/net/hsr/hsr_netlink.c
> +++ b/net/hsr/hsr_netlink.c
> @@ -131,6 +131,7 @@ static void hsr_dellink(struct net_device *dev, struct list_head *head)
>  	del_timer_sync(&hsr->prune_timer);
>  	del_timer_sync(&hsr->prune_proxy_timer);
>  	del_timer_sync(&hsr->announce_timer);
> +	timer_delete_sync(&hsr->announce_proxy_timer);
>  
>  	hsr_debugfs_term(hsr);
>  	hsr_del_ports(hsr);

