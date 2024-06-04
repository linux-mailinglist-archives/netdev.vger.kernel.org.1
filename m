Return-Path: <netdev+bounces-100628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4E98FB632
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 523051C250C4
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 14:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57A11494BB;
	Tue,  4 Jun 2024 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UoRVH80W"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82486131BDF;
	Tue,  4 Jun 2024 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717512568; cv=fail; b=Uct5vPCHyPJwvDJ5C8fIRe8wQrFO6VFAF+FiWITSFuVzsDx0hpezbBNTBE7gWzjWJ8R54SU/XtNXEnBwyifNQTMmITaU6B7RX7ydTIUJ3NoNRN+D7jhDAKgW8hjhRLMFiNa6zbztU2anMfBrXmWm2kYqesQUPgvcWLaxYVtSw7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717512568; c=relaxed/simple;
	bh=R3HZTAmEup03WoyZiJgy8ug2tI5D+9D5jju1KC7It1A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t04zDfM219/jujy9YkK/cJwtZn1HUrffvon7NE3rKi13aCau0L1n8xRR0heSugVd1EI2Qmo2RMG+xs6d42OESTtGRbpdjU6vy5KV1oduizkwfIbLyPQ5ezayGI920BoO92I5ptigyRuNYn3tSdil86p7mcLdz+ry+Rw9oBO80Bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UoRVH80W; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717512566; x=1749048566;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R3HZTAmEup03WoyZiJgy8ug2tI5D+9D5jju1KC7It1A=;
  b=UoRVH80W8TgmdgaEicbS3kR5QJ67M2Fj8pZJeAaFdhKsbelKuGWB0LsS
   B7y07TmWydXW+WHsDlf1c9YllWvIEjuePvB0tBOGUIJcPJd9vMjMBqG5q
   I819UQJPxru400QWiS5LLQMjgL5xPzIZgElpYFkOqmdxMd+qYwyhs8Kbn
   IHCZPTBBl9V7jS7igucrgPR1qHKcZOXh19syLhS/g80GZRVX/8KWDvwFS
   1E2oKH+rh6algMamxx+PZiKzekQVSo7nOOzxSLt91jgk8MXziRnFhTcG+
   nDm3PRDfCaX6ik9f5kPHcnjI2bsqUvI+7VQohchNhFKdsO3l9mEXUrXpv
   A==;
X-CSE-ConnectionGUID: 6z3EaBeITMKDjKp/Cze1Mg==
X-CSE-MsgGUID: jS9zR0s2Se6ruD/RfuMypw==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="17000743"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="17000743"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 07:49:25 -0700
X-CSE-ConnectionGUID: fB1dA/H1TCi0whqJD7JEzQ==
X-CSE-MsgGUID: jg6Q5XxlTIOGrw113Wnixw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="42201160"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jun 2024 07:49:25 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 07:49:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 07:49:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 4 Jun 2024 07:49:24 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 07:49:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3cbOPGvvuQdfoVza9w0VeEM6NyX5M0HCQ0z7BB3iq3AN1YZTKuHiJx1BCMtBI8f7eFNw3ntUxR8roG8nwkJ8FE0CQVP6CDfG9ulc2r5r7hTOj9kn3be406F32iQcPku7+s1/yaXAH00o3GgRJOQdVJ+he4YftPvn7Q7OV2LnVRF3sWGAMs63Y7gpmYXgswqI+XOFXGRHsCc3Yg2efWzF3CB17BUZbpXA66ElZzrTI/qDepmTlTpS+pheKMPVbASQRk0I1Z0Re9BKcMKe11uDrjJm8c+Au5f+pmtce/DDr+be/dycncyNolZP0DHftSqccJsy817jxhLrSAvLQy/+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sW3YVjMuvevxS308wz1HboFLqaWhLGMmXMCaIA24R2Q=;
 b=YQREbduFiMoGvInK0azhW9FoHciOm8mk261+thOhg9XyQlbnEpIUg82UopNX1k4YaQyCc1dl7DAGK2vjROwec6tkn3cHM0fZgfzjgutVyxbZcuqAGhgMM2Cy5lQKkx2+nm45KONufXVRwicXFsiUaJy62Gv4R7Vq16oehugF77vo/wSENijCY5224/CBnUnwrtUVul0C9OTmiy6v4nIG58yfcfH3Hm6wtmUcpuITt5Ec12/YbVfOOnXS0cIwKtXsD1A2e21XIqKff2uv5aYTmZCwpo06q7vVm0FA3e9OAW/fzYIeyPY4jEyMXDaGbs3NgNBhHfBZ38ymZYeKTSQyjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by PH8PR11MB7991.namprd11.prod.outlook.com (2603:10b6:510:25a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Tue, 4 Jun
 2024 14:49:20 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%5]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 14:49:20 +0000
Message-ID: <b95de69c-5b49-44af-95d3-fbcc0d75d449@intel.com>
Date: Tue, 4 Jun 2024 16:49:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: ti: icssg-prueth: Add multicast
 filtering support
To: MD Danish Anwar <danishanwar@ti.com>, Dan Carpenter
	<dan.carpenter@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, Diogo Ivo
	<diogo.ivo@siemens.com>, Andrew Lunn <andrew@lunn.ch>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>
References: <20240604114402.1835973-1-danishanwar@ti.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240604114402.1835973-1-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0057.eurprd04.prod.outlook.com
 (2603:10a6:10:234::32) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|PH8PR11MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 721c4af0-f8af-4a19-fdd3-08dc84a583fa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|7416005|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUJqS2VIQXgrVEdYejJpRFJULzJadGJlS2pwNlpzNk01bjk0MXhqWXQwcXNz?=
 =?utf-8?B?am9zN1dQVHY2ck14L3prM0drbkd2czR3VnplMUMvdWJpTW9ZS1VNbGhkdTdq?=
 =?utf-8?B?U3VtR0Vmc0orVXExQ1k0amk1dG5Xb2RyejdxR1g5TzhqNGVCNnJCRWFlVXc3?=
 =?utf-8?B?SU8yZWoraE1Lbkl3MGpqeS9USnZzQUMxMlJDZ2FhMTQzVlF5eGc1dzN5WVli?=
 =?utf-8?B?c2VaS0ROUExxc21GcGFrcm51ZTNkR2RDeEh2NDY4WEJVTm9SbGNrT3ZFL3RI?=
 =?utf-8?B?eDRienVMSnVHVGhuaWpmT0JoYUdGZDd2MktwRXFRRmdySGJrZ2JESGtqelVL?=
 =?utf-8?B?ZE9zeTV0OFV3Q0dCU2ZlUXM5dThTaHE2NURoU01UalE2MnJGYVRlWW9lYkNh?=
 =?utf-8?B?RzExcHkycnh2eHFFMHBnbk03aTcrSlFuNjd0UU5SUU5nTmY4U1FBWDN3M2NV?=
 =?utf-8?B?WnBIdWVzSlBQR1VWNGUzZ1FVYXlOdm9DOVY1c1czZXIzOVNRdEtWU0pucGtV?=
 =?utf-8?B?OFRnRUxCcllXUlBUc1plNGtQV2JnYjZtT0ZDQUk1R3UwVE5sWVJBOW5ZNENP?=
 =?utf-8?B?T0hhbEFPbHA2d2hNMFhvT2k2Ukpxd1VPSmtQRGdZcmNlUk9FT1NlRUxlaHY5?=
 =?utf-8?B?eXNSM0pTTFJKaE9aL0JCdThhTjRIU25lbVNuVjJqek9JaVg1clJmNWFVL3p2?=
 =?utf-8?B?d1NLV01HVFZJVUVKRHVpSjdoRnl4TWQrNkpldXdaaE9BclN3d1VJdms5djlK?=
 =?utf-8?B?MCtBNXJGelBlN0prenpWeThTdityRGRqREQvQjlQMnFIUlU2ZXdqeGc2SGRi?=
 =?utf-8?B?enZmcVo5SjA3dDYwTU5SVk5oYmI5UWt6OVRzdEdlOXY0bEZDTytiV2luNEtV?=
 =?utf-8?B?VFNLbDE2U1FIeFNKS0N5WnlEOGx5YXBQVlNlTG9XMTJuTUFLaFlGUkJBNjBW?=
 =?utf-8?B?a1lWSDFQenpPY0NpL0E0dEhvc2JhN21oVzBKcDJWb2QwOVh6eVFpVmVrd3Rs?=
 =?utf-8?B?NktGV2N5ZHgydDdocGkxbmdaVGlyR25GVlFIVW9hM3hrNzFINkoweGZYY2lC?=
 =?utf-8?B?djNxeUV5S0ZQOFJ4elBwVjVlVCs3ckZERUkvdjBJMC93SlRIdmVQcHZ4RUZq?=
 =?utf-8?B?QkFzMjFSdXYyZzZ6S3A3NWVtRkNIZHpBeFpjYjJJVlpta0FwSVphaFkzSC94?=
 =?utf-8?B?VVBIQTFYMmdFQVBLQjVJNXl2cG1BcmNnTGhjNldPM0I0SUtLNHFMdUp0TkhQ?=
 =?utf-8?B?Y3I2TWZvWFI4dkJzaStyNXJSa1h0RUlRdXhlb2NWYzlLM3BRRXgxL2IyRmRT?=
 =?utf-8?B?bFdPWkdyTjFZSXl2NnB1UUFnVXRzZ0FGOUNtOW5zdC9vQ3VRUmR5NEZuMkhV?=
 =?utf-8?B?aTJ6YVNjVHVSS2hYQTBjUWcvcWZpMElwY1ZJTVNlVEJVNFE4NmtJb0VMd1Zm?=
 =?utf-8?B?QnN0cXZjbDA3d0pSeEdrb1IyNjN4MlpNNlVZOFpWUHBkd2pTMGcrTGtaeUwv?=
 =?utf-8?B?YXp4dCt2WEJLSExlQVhUcm56OUM1d1pUY3F3UjBJSUR0aFRiTTY1R01aY1ZD?=
 =?utf-8?B?U09KQ09RMG42empkVnVCbFlTYzlKWFczQkg1K0d4K1VzWlVVOHhUOW1oVVpW?=
 =?utf-8?B?aDQyY3dyeW85QlVQZ3RsR1FLL2t4R1hpVFR0QmlaYVBYQkROcWF0UXRFcWZH?=
 =?utf-8?B?c2dCUXFzQVllSEY2NWRHVUJ3RzNXTzR1UmdLWmpvWkdTQTNrT083cWNvYUp0?=
 =?utf-8?Q?o67LqRF7UxKynMzIAY8eucfU+Jmf1nObh3AXeVt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWZlRWdxYUdJUFNvSU1oaTJLU1NRODJUOWFkUXdNZWo0Yy9QT2ZCbGVOeG4y?=
 =?utf-8?B?ampxd1NIY3ZVTVcrdHRkd2FQTTBXV1dMeEw3Y0xnWGswcGhXQy84Z1M4aytu?=
 =?utf-8?B?eUo5c0tTSHNkSVBJejkyVDcyakVnZ0Y5L3FLVUQySFlHb2hKc095Tm5sT0Z3?=
 =?utf-8?B?TWVJUENBZEpZV2lEeEtxQnVWd2YrcDBhNlV0dVF2OXNaUEpQMDA1eWIwTFho?=
 =?utf-8?B?dzFRVTZBODNmUElHR1htYUtaNlFyZ3NHOEdaK2h1Zy9CZDVYRWNKUWVEVkNK?=
 =?utf-8?B?QjQ2LzVaY295ekNhODJFVktYbXJKb3BBTnlpSXhPTktQanduOVZKZUhjOFMy?=
 =?utf-8?B?TWx0UnlBWG1RZVV5N1RDc3FlSUE0N0REQWFTY0pYK1BrUzBvVUR1dEpSS0tT?=
 =?utf-8?B?dWFocWhXQ2F4YVVIOXJoNDhNRHU2MWZWU0VJVXQ3clFEOGZwVVQ2RXZFUUto?=
 =?utf-8?B?VUliUy9JNmRaeUhPT3g4ckk3alE1WjErUnFud2VGa3JzeEozYUZTNDE1UzRZ?=
 =?utf-8?B?TFFLWlNkVGFZVzZOMVdLZFEwdjE4T3AyRnU1Z0FCSHdQU1dQTm5naDNFNyt6?=
 =?utf-8?B?cmtCRHZRSVpISWpka1Y3dWE1MjVaSllGcGdIT0xSYS8zM1pTQXZ6ZTNtKzFT?=
 =?utf-8?B?eEptN3NaYzBXR3pGQXhnU0ZPais4MzE0cFp6U0lUU3lXbnZnOGVaK3J3T1dS?=
 =?utf-8?B?VG13Mm9wSzhIVm92RUdPcjk4Z3ZhU0lMdXpPeTBYaTdycWVNN2gzd1BhVHFi?=
 =?utf-8?B?dnk4YXlDOHZ3Ti8rL204L2kvR0RBK1BBd2dGYnZNTFM4SW9Wa1pOaDBxVTda?=
 =?utf-8?B?Tzd3VzhHbXErZ05rWDVGRTgvWDJ0bW14enNNMjI2dU5yVWNVT3ZnbDh6ZUMy?=
 =?utf-8?B?YnNwWWdGQXJiU1poUlQrSENQWlppTlVIcG8xTVc2bm5GbGpTTmxON2kzUVJZ?=
 =?utf-8?B?a0kwSUtSVTIvTklaZkxxZXphdXN2NE1lSzAyVzhCRk45V1ZBbFJNQWRic1Qr?=
 =?utf-8?B?RDBia0VDZDZZL2NEUFRvNTE4ak9BUUFodFd4c3JWb21LWGJnUExqdk5uMkxS?=
 =?utf-8?B?U1BsaWdTV0VqTUVDa2JHZ3piWXJOMGE5NW9FeFlKOTBpeDkwRWdXWEN1QlIx?=
 =?utf-8?B?MnpqQXVyQW5FTTJCODRXNENKVTZrNmt1MS8yMEIrbmtnYnNySFBvWUFIVkdH?=
 =?utf-8?B?R2hwWXJkZ3o4UE9WQ1JMWVE5ZUZzcDFMdDIyQk00QVBnSDhWVHQ4aTJsbmJL?=
 =?utf-8?B?YVQ3YVJMY2UxdDAyRzh0SlVtNUs5K284QXhnTStZOTBSbmJoanlRWmtaTm1p?=
 =?utf-8?B?MW1FZWRacUlKZlVyUFdpNFU5Y2pWSVU0WFE2L2hseG9scWNhMGhCdXk5Umdo?=
 =?utf-8?B?bkJCZFlxSjAzZDc0WW5JOC9Mb0xaSkozbitHVFhEOFdOZEFNNXIvN1RaSnBT?=
 =?utf-8?B?MGZzcUwvbU9IM0ZwUW90WHJOVnZoS2FqcTVqQnZTNWlFVEZNbWZOWlZtSU9i?=
 =?utf-8?B?R2g2MkdDb1pKT3FaN2JzVmdJVmEwV2lMWXJCY0U1SjFmVHoyeFVkUWxQVlRK?=
 =?utf-8?B?cGQrelN3bHBPUUFrZ2lHRXhqL2JteVhibFcyZVNiMTJidDhlUGdsWWw4YVNU?=
 =?utf-8?B?TlppaFRVWVJvQjd4NU40Yk9NcVFrOTFrYUFWbWpZbzZKYUQ2RjhIUThieHZG?=
 =?utf-8?B?Q2l3VG9odUx2OGQ2T3MwYVFDcUNZQ2I3U1RqbDluSm9FMjJtUlhsNG1OckFk?=
 =?utf-8?B?S1F4VzJGd2RLTytWaThQb0ptdVZGa08wWDUzZ2lHSHVVWXpaSEI1ZmQ2Rk5h?=
 =?utf-8?B?MnZmVitBV1VaYnU4QXM5c0x1djhpUEFhUGpEd1ZGcENEVlZwZ3dYQm50Vktt?=
 =?utf-8?B?RGVVQlF1WXJ4N0ZUU1JYK1FuZTVMZ3lYWWJNVkdzcEJkWis0UFJPQmxtaWs3?=
 =?utf-8?B?N2JiTGhFMExnSUpFWGVGWHhMS0lWL3VWUDBIdEhlcmtWMGIrcWhXcXRBbVN5?=
 =?utf-8?B?TlJMc084K3BTNmI0cy94NE1nQUEwdWx2YTd1dCtTZElwaWJPU3Y3cUJRcTJx?=
 =?utf-8?B?Q2xjZnNrL25vdURMWmpPWmdJcHpVV096aFo5UkVmRDZMWGphNWVMVzgzWEZp?=
 =?utf-8?Q?5qnhGQB5Isl2Zxj3MrGAy5LZc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 721c4af0-f8af-4a19-fdd3-08dc84a583fa
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 14:49:20.0962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PFvOh6Bb/ige0HWdCvO1K5foPJkbIuFyF0MrUs0wDKOM5DDowwTJw0Dr3jj+7F0xJa33Iflfr8p5QDHBBbaM3ex0KQnI9p77ZL4KQH6TqBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7991
X-OriginatorOrg: intel.com



On 04.06.2024 13:44, MD Danish Anwar wrote:
> Add multicast filtering support for ICSSG Driver.
> 
> The driver will keep a copy of multicast addresses in emac->mcast_list.
> This list will be kept in sync with the netdev list and to add / del
> multicast address icssg_prueth_mac_add_mcast / icssg_prueth_mac_del_mcast
> APIs will be called.
> 
> To add a mac_address for a port, driver need to call icssg_fdb_add_del()
> and pass the mac_address and BIT(port_id) to the API. The ICSSG firmware
> will then configure the rules and allow filtering.
> 
> If a mac_address is added to port0 and the same mac_address needs to be
> added for port1, driver needs to pass BIT(port0) | BIT(port1) to the
> icssg_fdb_add_del() API. If driver just pass BIT(port1) then the entry for
> port0 will be overwritten / lost. This is a design constraint on the
> firmware side.
> 
> To overcome this in the driver, to add any mac_address for let's say portX
> driver first checks if the same mac_address is already added for any other
> port. If yes driver calls icssg_fdb_add_del() with BIT(portX) |
> BIT(other_existing_port). If not, driver calls icssg_fdb_add_del() with
> BIT(portX).
> 
> The same thing is applicable for deleting mac_addresses as well. This
> logic is in icssg_prueth_mac_add_mcast / icssg_prueth_mac_del_mcast APIs.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
> v1 -> v2:
> *) Rebased on latest net-next/main.
> 
> NOTE: This series can be applied cleanly on the tip of net-next/main. This
> series doesn't depend on any other ICSSG driver related series that is
> floating around in netdev.
> 
> v1 https://lore.kernel.org/all/20240516091752.2969092-1-danishanwar@ti.com/
> 
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 50 ++++++++++++++++++--
>  drivers/net/ethernet/ti/icssg/icssg_prueth.h |  3 ++
>  2 files changed, 49 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index 6e65aa0977d4..03dd49f0afb7 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -439,6 +439,37 @@ const struct icss_iep_clockops prueth_iep_clockops = {
>  	.perout_enable = prueth_perout_enable,
>  };
>  
> +static int icssg_prueth_mac_add_mcast(struct net_device *ndev, const u8 *addr)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	int port_mask = BIT(emac->port_id);
> +
> +	port_mask |= icssg_fdb_lookup(emac, addr, 0);
> +	icssg_fdb_add_del(emac, addr, 0, port_mask, true);
> +	icssg_vtbl_modify(emac, 0, port_mask, port_mask, true);
> +
> +	return 0;
> +}
> +
> +static int icssg_prueth_mac_del_mcast(struct net_device *ndev, const u8 *addr)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	int port_mask = BIT(emac->port_id);
> +	int other_port_mask;
> +
> +	other_port_mask = port_mask ^ icssg_fdb_lookup(emac, addr, 0);
> +
> +	icssg_fdb_add_del(emac, addr, 0, port_mask, false);
> +	icssg_vtbl_modify(emac, 0, port_mask, port_mask, false);
> +
> +	if (other_port_mask) {
> +		icssg_fdb_add_del(emac, addr, 0, other_port_mask, true);
> +		icssg_vtbl_modify(emac, 0, other_port_mask, other_port_mask, true);
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * emac_ndo_open - EMAC device open
>   * @ndev: network adapter device
> @@ -547,6 +578,8 @@ static int emac_ndo_open(struct net_device *ndev)
>  
>  	prueth->emacs_initialized++;
>  
> +	__hw_addr_init(&emac->mcast_list);
> +
>  	queue_work(system_long_wq, &emac->stats_work.work);
>  
>  	return 0;
> @@ -599,6 +632,9 @@ static int emac_ndo_stop(struct net_device *ndev)
>  
>  	icssg_class_disable(prueth->miig_rt, prueth_emac_slice(emac));
>  
> +	__dev_mc_unsync(ndev, icssg_prueth_mac_del_mcast);
> +	__hw_addr_init(&emac->mcast_list);
> +
>  	atomic_set(&emac->tdown_cnt, emac->tx_ch_num);
>  	/* ensure new tdown_cnt value is visible */
>  	smp_mb__after_atomic();
> @@ -675,10 +711,15 @@ static void emac_ndo_set_rx_mode_work(struct work_struct *work)
>  		return;
>  	}
>  
> -	if (!netdev_mc_empty(ndev)) {
> -		emac_set_port_state(emac, ICSSG_EMAC_PORT_MC_FLOODING_ENABLE);
> -		return;
> -	}
> +	/* make a mc list copy */
> +
> +	netif_addr_lock_bh(ndev);
> +	__hw_addr_sync(&emac->mcast_list, &ndev->mc, ndev->addr_len);
> +	netif_addr_unlock_bh(ndev);
> +
> +	__hw_addr_sync_dev(&emac->mcast_list, ndev,
> +			   icssg_prueth_mac_add_mcast,
> +			   icssg_prueth_mac_del_mcast);

Is there a reason __dev_mc_sync can't be used here?
net_device has mc list already, no need to keep your own list
in prueth_emac.

>  }
>  
>  /**
> @@ -767,6 +808,7 @@ static int prueth_netdev_init(struct prueth *prueth,
>  	SET_NETDEV_DEV(ndev, prueth->dev);
>  	spin_lock_init(&emac->lock);
>  	mutex_init(&emac->cmd_lock);
> +	__hw_addr_init(&emac->mcast_list);
>  
>  	emac->phy_node = of_parse_phandle(eth_node, "phy-handle", 0);
>  	if (!emac->phy_node && !of_phy_is_fixed_link(eth_node)) {
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> index 5eeeccb73665..2bfda26b5901 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> @@ -155,6 +155,9 @@ struct prueth_emac {
>  	unsigned int tx_ts_enabled : 1;
>  	unsigned int half_duplex : 1;
>  
> +	/* List for storing multicast addresses */
> +	struct netdev_hw_addr_list mcast_list;
> +
>  	/* DMA related */
>  	struct prueth_tx_chn tx_chns[PRUETH_MAX_TX_QUEUES];
>  	struct completion tdown_complete;
> 
> base-commit: 2589d668e1a6ebe85329f1054cdad13647deac06

