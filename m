Return-Path: <netdev+bounces-292102-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iComOw+IFmrznAcAu9opvQ
	(envelope-from <netdev+bounces-292102-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:58:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5715DFA13
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0CFC30325A6
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 05:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE552BEC43;
	Wed, 27 May 2026 05:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U36pwyo8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E891B78F3
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 05:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779861490; cv=fail; b=fr1TBFpRoNJeUQssZvWdHgwB3i6hauFXx17Ir6ZHcG/xmMIN84oMC9Vg2wGRtQOw2GoSNEmoZLYiP0aSSZ+jDbft14nTiH1yBEsuSVt2oSMu6VNMAWNEr/5wdGieTsS3MN1X/UQtaz+0JQ0PpcJhOWQ8uZAJJtC7GkJz/CDgBS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779861490; c=relaxed/simple;
	bh=2/YMVXVXdS4A1CYAXemJqHUwmZL880K/GV1W1qIAaCs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dHnLxhtQ3vCYW56qAxD1pJKSTdUtffgTdLzsbmfFD7LAcZfT6yk7WU7QKiXBcqUBmAQXan24/pAHe96y5UtJftbijKIXWwocaNCGXN+c3c0+YgqXPJkaDc0VBlQ6IzjgiFGUfxWExNFtERldrg51LFtl5ax4JaanUQynwBBvBkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U36pwyo8; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779861489; x=1811397489;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2/YMVXVXdS4A1CYAXemJqHUwmZL880K/GV1W1qIAaCs=;
  b=U36pwyo8VZ28k/qHTpWfhvE1ogGASFI1VvoVddhSFBD94dYJ6sLQEh4k
   15CrhT2swF7H3mq8YmOF1fbtxrdZ6LlQ7NmUsy8+kK2k4tyG93Gk947Tx
   8Vf3PpYQOXUFYIdcbJcgv6Wew/ehi9Owm7Q2txiesLDnn5Rjx5ImL5tXn
   1ZOM1A5vK3qzvUr16Luz09MbnowoAE5oE4s264kcAFpbBM+f6CcdkwBTZ
   rcGoOWolLkHX+zqyiG0FK4giVGR6JkPiCQUppcdh+UdTZGnkoNIC0mCBc
   GsJHCEmLHuKvfMUistfR5MkcST6QWXqJQq3+NMYGqjhWtpivU+i9kvnPa
   g==;
X-CSE-ConnectionGUID: 0ThHlXN4Qu6Ah7nRELlwMg==
X-CSE-MsgGUID: /rF+0GEgQ/SfjtUGO8kyqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="84308752"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="84308752"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 22:58:09 -0700
X-CSE-ConnectionGUID: gLYanM2UQR2IBavkW3xFpA==
X-CSE-MsgGUID: BcgPmBi/R8WxKKa1mcCzhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="247084135"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 22:58:09 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 22:58:07 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 22:58:07 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.9) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 22:58:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zrc+IunNLS3c0tvDHXssnS6K+saJQMsHCn78+B11dc9v5LYWVy9QuzUSjvHf22Jh4+cUaqbB7CXvvoMIDQoVU50g+A+zROitMXzyU8IJ0fUliVb/HrNoeDcKfvbA1kNYjIGE7nBX47vOPenUQiOJuVcrC5DritlNoKLI+Lhml7xfqW6Pm3yxTnmGBZsu0vOt29z9r7hjapTJReDz/FkmncgP6PrznKd1h+qN7IYzNWGq64cuOFxknQGp5OomAPldWOnZvfxvg5YUFZxKRXmlMVkBs4L0GS2FDEZCT2/qyNKXVB/b65dpwjJoQl/Rvv6RQCo1UPVMoEA6B04jhu0Feg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvDjP+fvurgol2GltW86bD8epulHZ1TwbvEc/jRQIRs=;
 b=Bnta/KYzYXNcmlOOp+IjUWCDapao9XrZkBxdlAex1XzN20K8q5qB50hrCQhO+n+yExOl/FCzVfxwPLAfWUlips9pY5yl3RmKq833qCIWV2IlmH0zymKmaespMr1f4OHsw/VKWneYh90EGuWEo/UyhigmCc18R5tjkJ5DqkdM42c+S1pP6pqRXHXQE4OlryqkUH4NpRTmTwBfzT19aAKAw+fgolImtm3c1QDH4EKH+1ySK7bk0y88FeKWCvKuIY5FWzBQjhO0C4qxtUqVLixiTF7YOnN3HQ1qNMUVQ2LfukNZMLmHv2Vizbm+IkqEKNMzpQSqN+kOYG43vduh832MCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 SN7PR11MB7440.namprd11.prod.outlook.com (2603:10b6:806:340::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 05:57:59 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 05:57:59 +0000
Message-ID: <4fb26efe-b144-4030-8bcd-05a5bb90fe59@intel.com>
Date: Wed, 27 May 2026 11:27:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] drm/xe/drm_ras: Wire up error threshold callbacks
To: Raag Jadav <raag.jadav@intel.com>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>
CC: <simona.vetter@ffwll.ch>, <airlied@gmail.com>, <kuba@kernel.org>,
	<lijo.lazar@amd.com>, <Hawking.Zhang@amd.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <maarten@lankhorst.se>,
	<zachary.mckevitt@oss.qualcomm.com>, <rodrigo.vivi@intel.com>,
	<michal.wajdeczko@intel.com>, <matthew.d.roper@intel.com>,
	<umesh.nerlige.ramappa@intel.com>, <mallesh.koujalagi@intel.com>,
	<anoop.c.vijay@intel.com>, <aravind.iddamsetty@linux.intel.com>
References: <20260512191610.1817578-1-raag.jadav@intel.com>
 <20260512191610.1817578-8-raag.jadav@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <20260512191610.1817578-8-raag.jadav@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0145.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::15) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|SN7PR11MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: 735af2f4-d8ca-44c4-e9d9-08debbb4e7c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099006|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: o5rEu3Ka91E19nfK0e+ntRwbmWQ7L7k4Mnk9AYcuQfm6ppIPuT1EpnCcOjj0b2rAty6C3bY0kzIYUu6cOuf08EY6xAcZUSHjlhAKWKQ+kylBcV5woDWg57XroczxwBdjN8zJ2/sVu8dy5scVauy20MCTCm8Iyp4IWdB/GMbQqh22pxyYRn9aVoMBvfbmzxCuWGUbMOV802sVtpeyidvl7P3u/6IHMjVXURH/x02MSEcx+AlX7wPxThaOsZwki7QpjC38IFs11W1kVT1X142ij1jap5TDIWWNbBhXHW1YsxqiAk8+lAArP5XHmtXgN69pCRpsqicDkn6KPMaI8oan6sR9655JUjddssxo2iyfqUg7sDF6WKYb9VEhgYr2c7kwarRdsudwK36Uwryh0wruba6YH1OAzd4sFO31j8Jf0p87aLTRuIBwkahcTJyNKmvhpvrRE/6xFtHTHuaiTam0a+p+8HB3TNn0Vs+f8gXjlxyguq2AuzbRyu7s9sbH+A7nwfHreKoCl9T7CFEYQsh/iCa/98aREh8hhwe14LZHUMmsX1393TyLOYj2kvRiWMpzeGcUn+4lx73JVCoZsBJ+JY859xdh6ib1C5Gx5ovshTD08QXzJdAvWPIcQM9p/gzxEOlLLw7X/vLTXI/PEFvPgsKG2x6+usfFv0sHoMp4hS++VsooQ+WmxsQ5YunZW/wZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099006)(18002099003)(22082099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEVydWo3dzN6T1poVzVRcDRoeHJjTVpCN1BuMHI2R1g0MjE4SUd3M3pBckZl?=
 =?utf-8?B?UjVUYzBremhVdkVLckhrZ0d2T1REUDdxSnV1YkFhWldOSndJMUNmNHA0RkJI?=
 =?utf-8?B?dU4wYXEyVTVOSTBNUlIrSDE4MGt3bG9tNG95OWhoNHh5eVhOOUprUkcrZ28x?=
 =?utf-8?B?c2tKaXZlbFREMUFzYjZ6Tmh0UnIvbXJjMzV5Q2NyNFUzK25wUlhQUTZ6ZjdO?=
 =?utf-8?B?Z29GODM0bVZES2NEQmgxQkNxQk0zOWxIRWE1RDFBS3Z6ODVseXd2a2JNMnZx?=
 =?utf-8?B?OWZVWlRTcUxKelc2OHg0TVB4MnBDZFlVWFFQVk9FTEVaTWloYUcvbm50OHY4?=
 =?utf-8?B?OXVxaSt2cUZCUVAxeDB0RzJhVnNDUEZaaXNGbWJQdlM0aEszVFYyajBHRzd5?=
 =?utf-8?B?N2VTZWRZWnFmajdkRlNkbW5WUTV5dnJtcFF2eXpMSEViSEl2ZUJxUXVxVEVt?=
 =?utf-8?B?NVp6MnJHbjkzRFF4eFF3TGtKekFXWEdxbHZzYlB2Zjc1WDVZbVJKMHBwL29I?=
 =?utf-8?B?UU1lT09DbEtPTEtOSnJmMURKLzQ0UThLdHNjVlF0TjBrOG9DNDljQ0diVDVK?=
 =?utf-8?B?d1BRM2J3ei9KdndyWUNqK2FLby81UkY5Uk9QTHdPMnR1bktTV1krbkhsZ21o?=
 =?utf-8?B?OWs2VXZ6cEJ5YVhoeFVoYXhlNklWMFBKc252MWNSVkhRSzZqUkJ3TVQ0UytW?=
 =?utf-8?B?KzNZVHVNL214QTE0V1E2OGVzY0xscHZiQzc3dGVKdjJGQ2w2TFlSUkN3ZzEr?=
 =?utf-8?B?cHE2VVVWUWo4dFJGVVlGMFA3T2tla0Z6WHNBRktCY0FqZ1pxQU9hU0hab0VN?=
 =?utf-8?B?aHZzbDhIOU5CMTJ3SUthZW5Ddnhzd1luUEF1ZDhFRUJXM0RGbGtPOU5NU1Az?=
 =?utf-8?B?c1I1VkN4V2thcFFXR2VLZElFK21JaVNsMWJyejNNQlplOUFHS3BLaHNuSlNW?=
 =?utf-8?B?YkVzR1ZxeFZRQklyYVZVdzZ4am1ReloyRW9JalNLRER6TzNKSit5enNtUmdx?=
 =?utf-8?B?ckNVR1Q5NVlrVXhtczVxWU5kRm5aTHhxWlRQNEhzUjNMOXJ0d2tzSmo5QXdz?=
 =?utf-8?B?R1hROTJiYXJuWVpGdzV5bUlMRUdrQzdXNWszL0xTT0I5dW5zNW9OeTFveU1t?=
 =?utf-8?B?dGx1ZGFIRzAxdVdXNWZCWnUrOXdRS1MySGhYbVgyRE9pbWI4U0QrZVNsYzh1?=
 =?utf-8?B?Y3VveUlnQS8zZjNqaXdpd1RBL29nNFVEWWV3Y0FGYjVzVi93U1UwL2lrMG4w?=
 =?utf-8?B?Unl5V0I4Z0RRRjVKKyt1TzgwNDl6RFB6MUFJNXFlU1g1NmNmMGliQWZsZGNj?=
 =?utf-8?B?NmkwcHQ4eGNOTGRMaVNGYzBhY252UVY1REVoUDA5UjE0V0pNV2VtOXU5T3V5?=
 =?utf-8?B?QW5wa2xCUVlXQzRSVDRuT0FwdjlmZUMvMmNoWnBreEFRWVNXVE10R2hmbkxy?=
 =?utf-8?B?SzZPSUtmeU1sdXptL3ZKejBqTUwzSy9NbFBFWlkvQ0xuYVd4U0x6YUtJKzly?=
 =?utf-8?B?Sm1qSWVrVjl6dVFvMGpYc2pMWk5ORG50OWhGVjdSeTBnbUVsQUkzK3kvRFN0?=
 =?utf-8?B?ZktrLzZuemVCWWg4R05OeDJtT3h0WFJLODI5UUo4dzRnN3FUcS9EZ3B0VVZF?=
 =?utf-8?B?c25OUXdlYVJrVnRCZU5GYjVLRy9ydzJySk8zUnhZWWFFSGZCRDJWeW4veTFn?=
 =?utf-8?B?M2lzbjVUYTM5d3hBZWdTWUI4WnczR1ZVeWdBb2lwM1AzTnU2RktadWlHUzJW?=
 =?utf-8?B?cVMvRmFHQkdhbzVGYnBzZ2hBemJXMXZzMlhhYzR3TVJBdlJscmw2NnJrMW1v?=
 =?utf-8?B?OWNMVjF2WUF6OW8vWWREWktXQ1lXczhmL0dVbkcwWi9SZERGWkRlZlB1aFJW?=
 =?utf-8?B?TDR6cVcvQmxVUkFycUVwUDBlUE4ycUVFenBsSmQwS0ZNNmQ1ekJOK1p4WG4z?=
 =?utf-8?B?cDgwUEZ4U1JIZXdraFhGSDZ3V1MzYmVlMXZ3TURwTU9VZklFUTAvMW5CYUhO?=
 =?utf-8?B?bXhIajd4YXpmM3IvUzgrYXl0ZVJEVDMreDVnNEJBbDlhejlUY1ptVFgvRmJD?=
 =?utf-8?B?VXZPQytRYmFlYVR4eFI2SEoyQXQyemdtWWFieUF0OFhUMW5pZUh5S29oTThW?=
 =?utf-8?B?OEhhcDlpOEdpOTB2MWF5Ymk1Ni9pK292UFBJd2RpKzVpMHowV28rKysxWEpm?=
 =?utf-8?B?UVU3c0JlaXk1WHphL2dyUzR4azVmUjRGN1dESEMreisyN3BIVTJIUW8rMjZ6?=
 =?utf-8?B?QVYrQ3VpR3ppT3VGbnNpLzBHcm5rWTNwZThwUWlScDVDa3N6dG44WFNJSTFN?=
 =?utf-8?B?TXkxZm1TbGdZOC9JQUNlMVc4Vi9uZTBaUUhlcXdEazhlYm1HdGVsUT09?=
X-Exchange-RoutingPolicyChecked: V+Yc7PxTNPolR2X4hINOgBhPzBxHRP+H9lusQtOq+ehx7DQ9uX/dkRqQY4OMVe2ik0o5t+PDlHNvnPz8XXEoDnKD3wbqfVCbiqyC9RtQ7yBW9nTM5K+7TR7Nf2BhyoSP7veMBra14bfKPEE8uy8Z+QdcVc5CAy8WbVbCcHxNuIRCxU9pagW/v4IG/ubuhVLx6s37I5WXNctFbFhO15nySW0Hzr3+eFXH6d1KQF8rixALWqEp93xRGtV56gtZduN19SDRYcDVMzaBgnZQ56q3SpHP6W7L7YHalhKQcT7NWp0XHRzntAFmDXyRP+Ajay+uK66ZwrekH9dbGOSyN0+yFg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 735af2f4-d8ca-44c4-e9d9-08debbb4e7c8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 05:57:59.3799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /GB9T5l7iJGv5wgcYTyps98eZESLpaoSpXGip5PmwsESvlj+CJd8u0ysmimW5UZ1Av3v1jbLW0bNSUl1idDPkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7440
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-292102-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com,linux.intel.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 6E5715DFA13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/13/2026 12:46 AM, Raag Jadav wrote:
> Now that we have get/set error threshold support in xe driver, wire them
> up to drm_ras so that userspace can make use of the functionality.
>
> $ sudo ynl --family drm_ras --do get-error-threshold \
> --json '{"node-id":0, "error-id":2}'
> {'error-id': 2, 'error-name': 'soc-internal', 'error-threshold': 16}
>
> $ sudo ynl --family drm_ras --do set-error-threshold \
> --json '{"node-id":0, "error-id":2, "error-threshold":8}'
> None
>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> Reviewed-by: Riana Tauro <riana.tauro@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_drm_ras.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
>
> diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
> index c21c8b428de6..31780d8af7e9 100644
> --- a/drivers/gpu/drm/xe/xe_drm_ras.c
> +++ b/drivers/gpu/drm/xe/xe_drm_ras.c
> @@ -11,6 +11,7 @@
>   
>   #include "xe_device_types.h"
>   #include "xe_drm_ras.h"
> +#include "xe_ras.h"
>   
>   static const char * const error_components[] = DRM_XE_RAS_ERROR_COMPONENT_NAMES;
>   static const char * const error_severity[] = DRM_XE_RAS_ERROR_SEVERITY_NAMES;
> @@ -75,6 +76,30 @@ static int clear_correctable_error_counter(struct drm_ras_node *node, u32 error_
>   	return hw_clear_error_counter(info, error_id);
>   }
>   
> +static int query_correctable_error_threshold(struct drm_ras_node *ep, u32 error_id,
> +					     const char **name, u32 *val)
> +{
> +	struct xe_device *xe = ep->priv;
> +	struct xe_drm_ras *ras = &xe->ras;
> +	struct xe_drm_ras_counter *info = ras->info[DRM_XE_RAS_ERR_SEV_CORRECTABLE];
> +
> +	if (!xe->info.has_sysctrl)
> +		return -EOPNOTSUPP;
> +
> +	*name = info[error_id].name;

Please check if name is null and return -ENOENT.

Thanks
Riana

> +	return xe_ras_get_threshold(xe, DRM_XE_RAS_ERR_SEV_CORRECTABLE, error_id, val);
> +}
> +
> +static int set_correctable_error_threshold(struct drm_ras_node *ep, u32 error_id, u32 val)
> +{
> +	struct xe_device *xe = ep->priv;
> +
> +	if (!xe->info.has_sysctrl)
> +		return -EOPNOTSUPP;
> +
> +	return xe_ras_set_threshold(xe, DRM_XE_RAS_ERR_SEV_CORRECTABLE, error_id, val);
> +}
> +
>   static struct xe_drm_ras_counter *allocate_and_copy_counters(struct xe_device *xe)
>   {
>   	struct xe_drm_ras_counter *counter;
> @@ -123,6 +148,8 @@ static int assign_node_params(struct xe_device *xe, struct drm_ras_node *node,
>   	if (severity == DRM_XE_RAS_ERR_SEV_CORRECTABLE) {
>   		node->query_error_counter = query_correctable_error_counter;
>   		node->clear_error_counter = clear_correctable_error_counter;
> +		node->query_error_threshold = query_correctable_error_threshold;
> +		node->set_error_threshold = set_correctable_error_threshold;
>   	} else {
>   		node->query_error_counter = query_uncorrectable_error_counter;
>   		node->clear_error_counter = clear_uncorrectable_error_counter;

