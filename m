Return-Path: <netdev+bounces-293285-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2G1lO9weGmqx1ggAu9opvQ
	(envelope-from <netdev+bounces-293285-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 01:18:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20291609AF1
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 01:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8FC8302EEDB
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 23:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D243630A7;
	Fri, 29 May 2026 23:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KXcPuP6o"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73429351C2D;
	Fri, 29 May 2026 23:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780096730; cv=fail; b=EI2dgoWfYTJZeoi1zJ+AqQGaAQrQo9/T/z5v62T4FidJUymO9T2qdeCkeW7iYfJ3xIlP6qafGw8zt596nMTMsmaLotWlhBsUgRsAYxn82/V2qOSFszCQtw+TqWqQlFeExIT2YF7f52s2tkg2/svpl7bEtRDZJUgr42QoV8Wk0GM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780096730; c=relaxed/simple;
	bh=8FUMF4pqndKE+vLE6TnevNzFSn8bFmacVTqmJHXVh7k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ANHmvd9EmfvdCkCVd4K7KjuE2o7kqeeYxXQ5HGqrGpMWeYR9jm8OIMrEbEZeG+6xwfxEme84oMoYATXqdzBffUcmN8rMcEDRqVAPRXiYtc82GoahpZIwh4vBmD6h1fM2HMY1iO1aLKAXlRzFdx9nyxvI5R+zSoM9TXaV9P8Sb80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KXcPuP6o; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780096728; x=1811632728;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8FUMF4pqndKE+vLE6TnevNzFSn8bFmacVTqmJHXVh7k=;
  b=KXcPuP6o5FQcvq0/MDlGu+Y1FAw8GXqfiAQFzR7tyD4yQtAd3XzDBGLp
   vgVl2DsWgjaTkYiOiiCU1ywrOYZyDtr22+ti+onOvDkhO+GtLHouLs0Fs
   6VGBO6JeUCAW5YsFY7aFmM9Y91hBKAbAk0I/3+hZqnCbdBgcechH0yCbo
   1ClIeWUgxqcdehmMwHCBJ/nlnQDH02gqkVRhM+QHxY0OzLSt8Ck82T7BC
   WNha8BM3DtOf6fBPXzBy/NXTxF8WpUzt6EwL8B3V/3MZ4G7rw1fDxnaUg
   r+H6zjM9vzWtwfx5At0c0yaQOB6Vf0oejRx2f5OmHBoJLzUu2ZsUM3SND
   w==;
X-CSE-ConnectionGUID: awPX+zehRqeKyMa5DZxoNg==
X-CSE-MsgGUID: 626N9RIWTCao3yELL9lS2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="80683046"
X-IronPort-AV: E=Sophos;i="6.24,176,1774335600"; 
   d="scan'208";a="80683046"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 16:18:48 -0700
X-CSE-ConnectionGUID: WGtAQR5sTqCNY+kCTl0clg==
X-CSE-MsgGUID: 6od5kK28TH6QmYEBjTdWGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,176,1774335600"; 
   d="scan'208";a="247252720"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 16:18:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 16:18:47 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 29 May 2026 16:18:47 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.19) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 16:18:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9Far3RIAU08KENFkFokZioH7eHBshFsVB9PR7h3KsHdNRccmtosX6f2SkR5gX8pOsK/IdgW9HeFMoYO0aalekaycn5QRH0/YE+8CYTMnFOAKUTaOeIPE5v1ighSomKmw2sQjgghgF+HDkkbr9T7fih/0JAnq5sy1j5mwLrJ33b1Jh1wF9cpFj0AazrwFHnpTO9+OIbrmAMRPF3Z96PrEm2cI6K7GYjFhxLEmT+FkPVYv6T5tsmc6wXeUdg+9le9BxTuv+EYYZJBgf007h5gvROA//j8+Jq2E1XWOQ72gUrDIAShYCqsuHjwr2HIVnpDmOY4wSlijptTu/9kd/8G+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMVDJPT6PAWHeQJFMm9rCcK/3nVbdAjGSSey3PoUFeQ=;
 b=QgR0h1T7oWUzeXQioLiz/+uUKHjRCAm8gP3Gmwq3TKVtTX7Uv/WnL5F8umTTm8SjbL1yy1xxUgYp/UFvVvBcpWXI2n6IrqeQCLoxkJX+To87G7m/KENpczOhEuocu+YruBCZKuCBW4zeTbCFrENak+kw34xJf3Bix9JhaoNgC0Qlsgkyg4pNx+nKdKdawZLP1dINNDCvkUau1PxfaE9uc7W62kxKpR16AiqUuMyNPrifP0aQQ7MRrU6IrM4rZ1ZnPL01E/Gzuslm0+fDNgnrA5gHEn6hFmwN75JlBixpu4y7ybL4CzH2OBsHPC8WrT8pxAALwHyumqmqeQ2B25Cxgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by PH8PR11MB9952.namprd11.prod.outlook.com (2603:10b6:510:3d5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 23:18:45 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 23:18:45 +0000
Message-ID: <625ecceb-3b0a-45a8-817d-337b37df7335@intel.com>
Date: Fri, 29 May 2026 16:18:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ibm: emac: Reserve VLAN header in MJS limit
To: Rosen Penev <rosenp@gmail.com>, <netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, open list
	<linux-kernel@vger.kernel.org>
References: <20260526202247.13823-1-rosenp@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260526202247.13823-1-rosenp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0192.namprd03.prod.outlook.com
 (2603:10b6:303:b8::17) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|PH8PR11MB9952:EE_
X-MS-Office365-Filtering-Correlation-Id: ae59c9d8-13b5-4ff4-55c2-08debdd8a17a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|6133799003|11063799006|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: b7I857hxJepI265rmlPUKk81KXo9fVGJodUXqcVHxPAFu5MUwXG0N0oAEQ8+76zhG/2Kj4rgCMmhCixFDYybGQL+NBwHNNv58k60FPFBjr0UxKqFUp0WVqLqT7YWdws5GFMJmFVsiRLN1EJ+naFpyvqAo6mx4CxvEAdBob/X/f8bRyKYBGe6x0t7/z9PsHMPy3Zz+yoh3/b7+zwe38GKV0nIBeZCNDdzFl1624h1xh2UTtxMgfQkUaD4JVP/XGOzNZtDMxd+sYMz9MK4E5sQriRKXN0NtOBplzfpuucnI35bPtTw1ta2dkHB6JRhlSnAs1ViwBSe0KfHDavdKgZytNHv9USIR5BQZmoMFeYv4u1u87UKzhXNQRiIB9d9bHEDWPUhg5rCBcgHsBsDT2ky4BGObifhelEwbeD7Xp6yrh8H9o1J9ZrhENHMdPjyHB8xWRu8notcd3GAwjnLvWtkX6sCO6RHz1l94qKqLttKrh8UakRKbRy/MbrV6DBv8csoD0I7xkOCnd9QyQn4KqZZfgUV5VeN/G1Q08la2k0eHMz5HWG1+a5x7I6W4cAmbb0c1jHbB66tlxXSqQI3K1llxsiDCYONPa3YeHLIgtwBfMCIN5Bhv0xj+2E57TVLcg6/1Cg4qCwHFjkKGg2opE1vIX2692+dkp67cQKczsiyVJWNjE9xjs79uWgkLahATiUz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(6133799003)(11063799006)(5023799004)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1A1ZEk3OTlpUU9DS2E1TnRDL0I0MjY1bUNQZUsvWG95NVNKWDkxYVBLeGJE?=
 =?utf-8?B?YWwvbGdyTzEwME90R3graUxEMWdlUmtKaHJuTzBmYkVrOGJOc0h3Qml4bTBH?=
 =?utf-8?B?dnpXS01WM3N4NmExMGlBdDE1bEZzK05WU0RHQWd0aXA5VmlOZnpRUWxhMFAw?=
 =?utf-8?B?ZU1LeTJHNkYrdTJ2anc0c2xhMjFuVitGQ0hLSjJHQ3U5b3lpdVliSE5kclBF?=
 =?utf-8?B?MlB5aDM4MEZNZ1VxMGZEb2pxamlJcjgydlFWeGlPQXExSjdMT3RncEhOQ0VQ?=
 =?utf-8?B?dE5GTXlXbWxXOU1Ed2JjRVFSVGU1dW56VWl5Kzh1cUJDVVpNM3AxZFFkOFNH?=
 =?utf-8?B?Nm04bXFYdWJuNGdwR2ZKMVZ3MW5zaFJQM01RYXJxNjlFaTd3UXcyYkMzaHRj?=
 =?utf-8?B?NmlJNWZ1ZHBnalhLb1ZnaXRuNUJrbzQwL2FDQzFLay9Jck5KaDNFbXJLclFU?=
 =?utf-8?B?SEpwSWhkNkJmUS9wTnhLUWtDTzVDR3BUZzhnaTVwVXRRTEw5NkJPdHJSbUpU?=
 =?utf-8?B?aHdaeStCQUUvbURvYmRadCtlUmV5aVluN05lN2dnZkVIaDRDbXFzQnFNMFRo?=
 =?utf-8?B?cjNaZXdXQkhMMWx4NzV5YVVqaFNkQUdiVnU5ZGFvbG42a1RwQllnb09pM3cv?=
 =?utf-8?B?OVZNQWRSUWdOUWtxeTJkTVZPd2NGL3oxUEt6MmY4Y1h6UlkrOGNmcDJ2RllW?=
 =?utf-8?B?ZVo1TlFmZndzVUtHUFdDcDQwdDZXQWpKdXRrZUdkVE1PTTM1ckpnWkFub0tL?=
 =?utf-8?B?TUZ3WnY3Sm95N3dlMnlWWUNHUDVvdTViMnU3dGI3Q1g2a2QzNHRMZTZPSkN6?=
 =?utf-8?B?MEE0bUkySnZJWVRocTF0Mk9LUDdKc2d5bmhrakpHb0s5aE5mSlE5YTNHVWhp?=
 =?utf-8?B?NUxBbU5QeXh5Tk80WDBTbjUwN0w2WWc5TitrRXR1R3dpbHBzcmtTL0VOaWIr?=
 =?utf-8?B?Z3VpdUtoVDkwVlN1SzlCRmpLV1liVmNRS3Z6MWZmamdJOUEwOFU1TmRaU1Ry?=
 =?utf-8?B?OCthRXlDZ1d6UStyM3dEZW5hZXlYQVkrVWRucVFDMEI5anhDK2lmdEw2Vmps?=
 =?utf-8?B?K1hNR0QrRHpuN0lHT3hRUy9XWmdlK2hZUGMwZnZNakhkNXJLNEVhL0JCVEVE?=
 =?utf-8?B?dlhYaFlrOUtadldaMEduN3d3MS9WS1hlTEw3OWFJM205Ylo4aHpWZXB6S3hI?=
 =?utf-8?B?RUR5NTZtc0xxcnpxV21XVkQ5OWE4ZkhxSmY0UjdjNGo5YVdGQ08wK3RKR29E?=
 =?utf-8?B?MWpMNmxQM0hvdTZtSHB1c0U5ZWEwb1d5UTFKV2xZejlKQzhOV1BrYWx6Vjh0?=
 =?utf-8?B?M1ZLY3JENWxMM3hQZ0tYaGdnblI5WUEzdTIzOUpCL1lHR1JZZHlNRHBVMDhF?=
 =?utf-8?B?S2JqUllYcW1yazV4R3ZwVWdLQWJXc3ZJa1JsRS9kM215SHo2d1FOOHVkZnRI?=
 =?utf-8?B?WFhCN3BmdEtjRDYvV0o5L0RSdHp2RC9IajRxRHQ1Z3ZqK0xoa1JldE81VVZQ?=
 =?utf-8?B?UlJBTC9mWWQzQXNMYnR4cEtIcnpNMHhSOWpWWGF4SkpVb1FIN2c2SndnZ2FO?=
 =?utf-8?B?eEpOSDUzTzQwazZDZzk0cVR1MXZacG5NZ3lXOHhMWUd3LzVtcVpuM1pqcXNU?=
 =?utf-8?B?WjdBOHQ4dXF2QlZiUStqemVFNWlWUmJSUFpOUklzdWwyb0hvTnRYZVRFTzhP?=
 =?utf-8?B?UTF1UzJ3U2c5ejdkK25GQnduMGJrd01XT1dCU0RBd3g1OC96azBlMXlJZ0Fw?=
 =?utf-8?B?czArVEl1V01Ld2xPME1VQ3loMjZPRWh6U2U1cFRIcU9aWkdFREZZbmNuankz?=
 =?utf-8?B?MC9tRkRSUjZPaGJPTG1tWFBvOXY4R1FqT3oyV01EMVBhMldIdFN3Yzc0Zk1q?=
 =?utf-8?B?a1lNMkFuVjUrWWhNSTBTQklVRmtuOG5TcmdJVTZRb3FMV1lySFFpcE1YUCty?=
 =?utf-8?B?WnRxTmIzaHdvalQ4cDFhZGttZ21KY2xqbVhmdklsOUJhRktEV2ZVaGZFUVhW?=
 =?utf-8?B?VzBKOFIycnZIQU5Gckc2SmJSY0RObTNYWmd1bWhhNGFCeERPOUV4SDlzTDl4?=
 =?utf-8?B?U0JhTWl6aUNuYVMxUEtuVEtJbSt5MGZrNmVxMnRPWGp3V3NNWnU4akhnWUsr?=
 =?utf-8?B?MFN6OEZxNEZxUm1FUjRrQ25zTDE3SDluYUx6Z0dqMVExOGVEYzErajMzand0?=
 =?utf-8?B?ZXZpNDhGUHpkZFJqVFg0Sk1TcXpydkNCM0pBdjJzZlkrcWhKd2l0ZzhQbmw1?=
 =?utf-8?B?d3NzRDA3bWpQY0hsVDAzamRLdDdRTExxMEFCV05zbFJ3bmJWakg1RDFSdWRr?=
 =?utf-8?B?Y2JmSXh2V1V2T2ZyUWkrRzR1TFVQMVo1eUk5SzRVVTRESmZkbFhKUT09?=
X-Exchange-RoutingPolicyChecked: jayaBFJyqavvrRn5cbqV5BOdnUJhy0ZCwqNHAo/VhtRAzjh+nN0BS5hhjrvxV3bcubMSaQun2PWqbN0hJj7LvZ9XBF/4keqJlhLz7p/Rr9zt1zzrmT3zxTGSYjbHeazXNiot52IztgHZQmRsdNv+XqAWRO00p9nrLhvaLbQ74ZLguhVF76qwkeu3RMqLDLP4kygqFdm665EqxVpllHlI83SFPEkmhJ3cW7vlv6iEVfatlkHfBZa8EXQIIhWJmbernRJLrembHdpohRDrVzF2Mxlu98HSuMcDcozXvtVHGgsyftGzAZsTfazE5UqrvRxXbXf05eTbxi7ug65ZtCmKyQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ae59c9d8-13b5-4ff4-55c2-08debdd8a17a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 23:18:45.3650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RTL/z51lvGr+fwbNY0mgJIEiiBCraM14SLbKRPa1ysr+anDA2jlLVNzlHrABoXOFR81rSLg9OFRixWM8UYpJgwT+clbn0HIreiqedsPn/SI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9952
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293285-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 20291609AF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/26/2026 1:22 PM, Rosen Penev wrote:
> The IBM EMAC programs its Maximum Jumbo Size (MJS) drop
> threshold from ndev->mtu directly. The hardware sizes the threshold
> against the L2 frame minus the ethernet header, but does not
> discount the 802.1Q tag, so a frame carrying a VLAN tag and a full
> 1500-byte payload exceeds MJS by exactly 4 bytes and is dropped.
> 
> This is normally hidden because JPSM (and therefore the MJS check)
> only engages when the MTU is raised above ETH_DATA_LEN.  With the
> qca8k DSA tagger the conduit MTU is bumped by QCA_HDR_LEN to 1502
> during dsa_conduit_setup(), which is enough to enable JPSM and
> expose the off-by-VLAN-tag in the limit.
> 
> Pad MJS by VLAN_HLEN so a VLAN-tagged full-MTU frame passes.
> 
> Reported on Meraki MX60 (qca8k switch): tagged VLAN
> traffic drops at 1500-byte payload, while 1496 bytes works
> and untagged 1500 bytes works.
> 
> Assisted-by: Claude:Opus-4.7
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

If this results in dropped packets, that seems like a user visible bug..
Should this have a Fixes tag and target the net-next tree? I guess its
not a "regression" since the driver has always behaved this way, but it
still seems like a bug to me.

> ---
>  drivers/net/ethernet/ibm/emac/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
> index 11d673a9f119..90471cff37dd 100644
> --- a/drivers/net/ethernet/ibm/emac/core.c
> +++ b/drivers/net/ethernet/ibm/emac/core.c
> @@ -30,6 +30,7 @@
>  #include <linux/skbuff.h>
>  #include <linux/crc32.h>
>  #include <linux/ethtool.h>
> +#include <linux/if_vlan.h>
>  #include <linux/mii.h>
>  #include <linux/bitops.h>
>  #include <linux/of.h>
> @@ -457,7 +458,7 @@ static inline u32 emac_iff2rmr(struct net_device *ndev)
>  
>  	if (emac_has_feature(dev, EMAC_APM821XX_REQ_JUMBO_FRAME_SIZE)) {
>  		r &= ~EMAC4_RMR_MJS_MASK;
> -		r |= EMAC4_RMR_MJS(ndev->mtu);
> +		r |= EMAC4_RMR_MJS(ndev->mtu + VLAN_HLEN);
>  	}
>  
>  	return r;


