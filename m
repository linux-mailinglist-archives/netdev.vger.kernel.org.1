Return-Path: <netdev+bounces-152982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FEB9F687B
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 419F818873D6
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE22D1ACEC9;
	Wed, 18 Dec 2024 14:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C+/e0xyE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51161B0425;
	Wed, 18 Dec 2024 14:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734532254; cv=fail; b=fGW10G1FVe4u/rfMJhFHicakYLIBbxXEDWz/YRMI5QCg3Gmck39tGMP9M0ZPNuJwddWfoWLpuwqcZS7WayexszN0ipkj5H7hlDs870P0JHiGR3czHubZ1dzSjhl83Kxo3q7xBQzVzs9yG+tQcMPtVPPP5SfZmS96C+J3J+KwVhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734532254; c=relaxed/simple;
	bh=itDNalUMyeZ2it+I/zZwkRZMJt6QtvHn5AJr1+K3/r8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J45WJqWvHsvZBMqYaNeVqEyZtnHMpKwaGo+sKt9TgVJTSWgYS1CSYED6jp9HO8B5/vfOfAUo/exfIAsWjVL/S7IMb2wsjYBpYrSnu42rnHdf+kMXN2dEFtcBhGsYgQLBk/1xfmOCvVsLM7YborZBIjxOW+U82J8+xf2pDhGzpVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C+/e0xyE; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734532253; x=1766068253;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=itDNalUMyeZ2it+I/zZwkRZMJt6QtvHn5AJr1+K3/r8=;
  b=C+/e0xyE07htqLyhIGBdvdFP0WqHeN1a1+wUL1pKGAjUMlFjopahwJuS
   xTreyh0DSbqVN3zY7AulLO+B1sigjcGAuBfyWsA73vQD/IZgFC6Y5l19g
   aDKoc6Pr63riv449721QRpHQMzYZTIDKHzfvJkpqhY+LSMmQ3yOFfxaVI
   9kX0Ff+NN95UQ/5yHHXzrjw/qAXYvnSS+ZMLNZzq9o/H0W3wNHxSBLRwf
   lK0+yQ9YBqoDJe+eI3oKcJYFQd6/NPF0KGok4FP6wbRcJzvyXcoCwxR+7
   LvkeNkVpCBragdyoCLvdIbt+Xv7OeGdcqXVS9FhYcIvjyBKfpAlaswnAN
   Q==;
X-CSE-ConnectionGUID: MVtFxjBIQveUKv8wGdLqzQ==
X-CSE-MsgGUID: Ox3P0JHVQK+of8ZGaIGQAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="34900534"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="34900534"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 06:30:51 -0800
X-CSE-ConnectionGUID: J7TBkL5vQauzgHMC7NUDcg==
X-CSE-MsgGUID: GqZRJfClRCKt8AwWH70eyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128863484"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2024 06:30:51 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 18 Dec 2024 06:30:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 18 Dec 2024 06:30:51 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 18 Dec 2024 06:30:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGV7raktdjM5HWfO4e8xtreCtAYE0X+KOtVonCshB+Am3CvKgPL36YRFbD4GU8qL541jkXR/mXYqNnEMcJwrwwiSicnE3z7jyXSMkrthicNmVSnLiEISLdSa16SiLO4rAqUV3A1WxAW4DYSR9YN6F9ry75n9SWr9P86HxjXa4riczzkstSW2hWMCr9EeLtaiMcSQ0creQO5/OcU21zTp9fStDQLPrfAx4oC4Ek+AOsSDok9ILxfiEkMcujvivCE/K80HiWRJXwAu71xCIiDrjAIBYBYEoTzVRFL9ce+aI1nHtnhprXRGiF0U3XD65KQ6H9e1m02T+QGhF+W5t180KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHIJGdgBnvy5bgw3NH/g7IS8F7Xhezbu1Z7sIZ43+PE=;
 b=XczJJyLTunnXdUfHqEvVKDiad0PqVwmXar8jS4qMWHgXpOTDtuiPMYycjdI5iFyo64KEnqftxhR8X8y8kJ1DPE4Wj8dDU0IitZ6V+o7OsnDBdjbY99ggFl8Xfp0E984Cqw08C1dc2YjABhl+OD3T5J2D0u3tiB9kRnP217Knrj3ZmIGE8iCm/IJ6/T5mXOhBQx4LgzyahvksjQD3XDV6ezbo8YwkV2DxPBOuB9cH/m2rkYfMu+EVpdNxbz9CCv89nOzzReEg+SX3t8WOc2aHu+AelLXaQV2yqLELGVTQU7O4/L17GeFaoPX5WtKrMVmeTAhMeYWmLdxtxgQcseedDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB6769.namprd11.prod.outlook.com (2603:10b6:510:1af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Wed, 18 Dec
 2024 14:30:34 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8272.013; Wed, 18 Dec 2024
 14:30:34 +0000
Message-ID: <48f2de4d-1695-4d8d-834d-b306b17e09a1@intel.com>
Date: Wed, 18 Dec 2024 15:30:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 3/4] net: enetc: add LSO support for i.MX95
 ENETC PF
To: Wei Fang <wei.fang@nxp.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Frank Li <frank.li@nxp.com>, "horms@kernel.org" <horms@kernel.org>,
	"idosch@idosch.org" <idosch@idosch.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
References: <20241213021731.1157535-1-wei.fang@nxp.com>
 <20241213021731.1157535-4-wei.fang@nxp.com>
 <ee42c65c-cc35-4c6b-a9d0-956d06c56f7e@intel.com>
 <PAXPR04MB8510CFF87187B095D15DBD6088052@PAXPR04MB8510.eurprd04.prod.outlook.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <PAXPR04MB8510CFF87187B095D15DBD6088052@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0244.eurprd07.prod.outlook.com
 (2603:10a6:802:58::47) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: 462087af-95f4-4544-f246-08dd1f708855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WC9mOWp0bWJlM01Id2RPeENmZFM1bnE4YVdSckg3NVMybVBtaWExSjRSQUlz?=
 =?utf-8?B?a3dLNEVjL2EyZ3dlT3I1U0Mxb0xSNmNqZG9DTTNNenpLcU1hZTJoaTFMaXNH?=
 =?utf-8?B?a3N5TXZqbFlIdk9lWUtRL3E0WnI3M0dQNzFUWHJlOGpWY0YwWlNtQzFWdWxY?=
 =?utf-8?B?a3VTTExvWWRxWEJnSjdzNFE5OXJzODFEMWk0eTAybERDYit2VzJJZ1c5SEFk?=
 =?utf-8?B?MFZVRkNLZ2d3dkdTajY2cUgzNU9NSGhoOE5JVzdHMFJYb0N4V1p2djZhTVdi?=
 =?utf-8?B?SUhGQXlXZXducGRnZGVUalZ0NVA4NnFyUGgvc0l4MTBNTit0aDlheHpmNXpS?=
 =?utf-8?B?OWtKRXhQeDR3QjRqT3hSaHdJbStVeVYrU2k2R1lseXg5b2tHUGdEalg4SlRj?=
 =?utf-8?B?K2lBQ3NTbHd3VUY3ZmFZa2IzVk5zV0R1SHNDakhIN2lOVUJkTEtqaFEzYU9u?=
 =?utf-8?B?NUNUWkQ3cnJoU2tTM2RiVzF6U25iS3hIenZPdkhDbEtmZ1BLV29yVG9nQStm?=
 =?utf-8?B?aUlZSVR6bXNUMndGNFhRZFdLd005TUk0VlBkekRUenZJWDBZa1RGbGh5bkJN?=
 =?utf-8?B?TzAxU3F3WGljWjhDZ2hHL25nUmV1cWZ5YWdYNC8vUlcvWUluREhtMHZZTktY?=
 =?utf-8?B?eXMreFU3cGdLbFVKSm5Md3Ywb2o1bklHMFB5N21KaW4yb0RkQWgwTlZ4WVJY?=
 =?utf-8?B?MlJtUlZpNVZoNUhYSzlJVzh4bnp3STFDL0pJakVWY2F4RVcxK1lKUTgvTlha?=
 =?utf-8?B?cjZvQ2ZaU1hTZGdMQ0RtaG1jQ3VGKzJqdWo0SWVkS3ROU1ZFeHVDRDlIazha?=
 =?utf-8?B?SzF4cFBDUU9JTDNwTzJSS21kWWFoL1dkMmpIbmQxRVBzZzhxL3h3c25ITmtH?=
 =?utf-8?B?L1g3amRWYU45alJMcVFYQllxajR0RUE2dWJ4cjNsQi9JdWhRSDdOdnVMZXVn?=
 =?utf-8?B?RDZSbGR3S3c3N2NJWlhhSERxSnpVY2VqY1R5dG94SmJieSt6N1BVNmNuMFJz?=
 =?utf-8?B?NjQ3MVN0Mk9reE1STTJqdWpLMVJpZFkydnh2clRmY2EzbzFORG1tUlhVWU02?=
 =?utf-8?B?NkJmTkNFVU1SYnNweG5aQWFwc0d2cHdBNkRwOWl3OXRqVVlhcFpEQTlNbWtS?=
 =?utf-8?B?cVZ5TmJVMWJXbEdZdDZRYnhwdHdMQ2Nodk05YUNPcjl2MGFyL1IwNE5McDdR?=
 =?utf-8?B?TU56ZWpEQ2FMRzROMWRpNmhobnM5ZGxUOE4xK0J4T0ZjZXgvTU9xbm5aSTZa?=
 =?utf-8?B?OGZKb1lUd1JYckpMZ2lTMmZsSWlwWEk2eTVIbTdxdWpGaHJyNXIyeUhpRlVL?=
 =?utf-8?B?OWtKRzhxcDlKUmJCWTdrWmhrWUo0R1FkQjF0NGpud1NVZXJpZ0VWQUJNajlS?=
 =?utf-8?B?a0kwajdTL2tlSEs1a0dnQzVIR2p0TDc3UFd4NFlKMis4aUhuRU1zY1NwZ2pS?=
 =?utf-8?B?QUZyUWtGdlBLNFhrN0RmLzJsRURmMFNMK1k0d2FJY3NrNWp5ZEhMM3Fkck9w?=
 =?utf-8?B?VTlobUFRSVFxaVRlR09zbkFFdXFHMG1TRWE3UzI1dWw1RTlaQitLeHNqUFQ4?=
 =?utf-8?B?WUUvU2x5WHlHaHNlZ3hoN2lIZytlVzVMV29FdzNQNW5OenYwTis2bzVrRlps?=
 =?utf-8?B?cVE4NjJ6MEVnaDdlcERRb0UxUmE2aGdMbFhwdVBQekxEbkhIU0xwYmtvd2FQ?=
 =?utf-8?B?TjYxeXpCQkxQVkVGZFlVdFg3RnJTR2lVKzdQSkozTjlUQnJyaHJTMU1IT3lX?=
 =?utf-8?B?eW90OVRyb051Tm9pMkppL2luQzNxQ0lsN3JQMzVhRnIxZzhERUFZZ0VXWlM3?=
 =?utf-8?B?NXNBbkdRMTJoRDRLVkhIVWl2VWNqNnpxWFdTNVFUNWpwOUVyWVNGN1ZvbDcw?=
 =?utf-8?Q?ULMwlWv//yRDs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFBCbFB5SWhFdmFOekFsTVpHcTdmallpcHFQaFZld2dkQVd6S2N2Yjc2aXJC?=
 =?utf-8?B?aUVTWnhxSi9pOThGdVlGckFueGFrRFVEMjdianR3QmtmYWRtYTdENlJRTjFn?=
 =?utf-8?B?THgyUXRaYktCcGpjQW0wdTM4Z2orMVM5ZHRWMHVqcjRkMFVvNXo1M21jdlhy?=
 =?utf-8?B?dkl6YTFOZ1Y1Y29vb1RzQTdybUc3aGc4d0R4dUdhenFKNUpOZmFlc2J2MWJj?=
 =?utf-8?B?dkNNcDQwNi9IQ1hSSmIwVGdMeGpML3NVTXkxM0V4VnVpSWJMVnFIdnFrOUlU?=
 =?utf-8?B?TFZCdTZialUwWVRMRzhKSlMrQjVVRllScmdSN0ttRmg3NXZ3SlhJY0tORzdH?=
 =?utf-8?B?bmFRMjk2cFYyQ3FYV0I1Y1VGWktGcG53SWxZM2gveWUwRko0TVlEeURoNGVp?=
 =?utf-8?B?T3pHalBmZmcyWmJHOFZuUkNSUzBqcjNtNjZPS1FZOHNlbFBFUDUvNTRzM2ll?=
 =?utf-8?B?azF3cXFYNVQvNnF4VEtvVFM3NHZ3bG9qSlhOcFZrVWlVcTVzVjVMM1hnSHF5?=
 =?utf-8?B?dWRkZ3I5TDdzUUpKSEZ0WVRoOEVydVBJeERFUmE4QlJZb0dnS1ZuUEp5Tm9P?=
 =?utf-8?B?R2FjeTU3SDF1Z2lNdjR6aXFvbkVzZkU3eDlEMEdaZm1RTVRobkUydStQYjR1?=
 =?utf-8?B?Z0pNcjVHS0M1ZFk4dHptZm5MMXg5cXVBY1AydGxKUkFKZXN6QnZsdEZFWWJX?=
 =?utf-8?B?TEs4dkxYWkQ5NTFWVitENlNCdy9JLy9YVTdseGE5SGVtSmQ1MThoVHJLWEdC?=
 =?utf-8?B?UXNVaEltYmtaMmQxY3A3STBjS09YVGlVdkxJalVENktiYXEraXY4V0x3NVcr?=
 =?utf-8?B?a1JtWFVZMU5Rd1MrbTNIMVRWcXQyNmxxdElmWWk0Z0pwTitzZ0NEejkzcUFl?=
 =?utf-8?B?dUhlSkFQZ2RiUlozL0g4MEF0bkVRY3NqY1dnM3UrZXdrRTRmM2xTeEVkN1Vk?=
 =?utf-8?B?NmJWSlJYL09SVkYxNUthallvRUViMGxlMGJxNDdKWmdvZ1NpTlROK1QwOHln?=
 =?utf-8?B?eE8wemNlalFmVXpCdllZZC9ac3M4cWk1QWtLYTFabWxJQ1hmdXNvenR2V2hh?=
 =?utf-8?B?a3ZEOW9McXlXWEo5WUc0VWxhcy9QV0d4TVMzY3NoTGhRUnRWeG15MWUvNzRz?=
 =?utf-8?B?ZnJHcExiT0o2ajlTbXEyZnhLOUdUbmtXTTV0ZVhCM0NvU2dtUEovOFFHbmpP?=
 =?utf-8?B?czhZS2UxT1JteENkSFdMaXNhbVhWd3BNNUlBU2w3RCtwdkF5VUhhM2V3YXpo?=
 =?utf-8?B?RkRZaXFGMU85WExucGs5WHhUUlZZQ1VLbFpmQzRjV3MzZ2UrNENyZlVuYURk?=
 =?utf-8?B?cmtZV2RRNHpVcm5GY1FKZnFwMzFYMTJiMXlGaFZ4RnZaQmhEaE5tVmIxTFhr?=
 =?utf-8?B?eDloU3FYRzlsLzNVdHljQkJRSDdKcUhRVWdTS2tpTm5uOWtrMDd5MGxsbE44?=
 =?utf-8?B?elVidlhxdGNvd2xuOE1ad3luZTZUSXVlajJna294TGgyMUludFhZdklUMHRr?=
 =?utf-8?B?Q0hDd2hka3IwWkZMOVQ2blBaL2tYK0NJYmR3dlIvWTNuNDNHeTlaSWhjbUh2?=
 =?utf-8?B?clZGWmluS0lVNyszTzRXcTV5eUpjWk4rZEtHMW9RSXpUNlNndTRycEFPRm9n?=
 =?utf-8?B?MS96UDJZUlF0WGxyS2t4MFdud3UwbnBSbTN2ZFJueEM5Kzl6dE9aK0MvL0JQ?=
 =?utf-8?B?aU9ET1F6b2o5WGllVGlrV2RrTDd1OUdHZ1NEQVkrbUI5cmRDRmRSTGNYYTZG?=
 =?utf-8?B?ZFB5dm5xUlpiRmNWV0FYSnFxZTBhU1FzemJOUVM1Y29ad3pEK1JUc1oyK0w5?=
 =?utf-8?B?bGxNQWJpanBmS0h4WHhEeis3R2dyM2hkejVoVnEyK1FMaHo0YVd3b1laWGdy?=
 =?utf-8?B?cE1ETGhoL1IzMVMzYTJJSUtocTdvK1g2TDBYd0hsdFE3WDExQlBic09FS2RP?=
 =?utf-8?B?amZVK2ptSVdJUG5Ndnd5QXNXWFpDNFRIa3pWbXE4WWxCSUpMYjVLbzFrOEhR?=
 =?utf-8?B?SlA4WTBUU1FvazZTMW91K0NFdmtCOUp1Q0luOCtxaHEvWkhSTEdURnc1aEVU?=
 =?utf-8?B?NzFDNWtwaWhIbWRGSFBjWGRiUXlJazhoMGtVQzU4Mm0ya003OTRQSHhXWG5s?=
 =?utf-8?B?Z0tHRXdLNGh5bFpNRTJDY1JyN2V6ckI1Sm5pRVVoMlMvYnB1MzRQaXpqUSt1?=
 =?utf-8?B?RXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 462087af-95f4-4544-f246-08dd1f708855
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 14:30:34.3701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S8Si4Ms2Os6Nc35fFbuj8b5RMrv7Ln7twBFSPgyBvI/NhLURZ/vFGYLd8LhhJnd3yqt2bnWE2Z/bX0+hzOgj4kiI7hd3t/GlUt28V9Eb1zo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6769
X-OriginatorOrg: intel.com

From: Wei Fang <wei.fang@nxp.com>
Date: Wed, 18 Dec 2024 03:06:06 +0000

>>> +static inline int enetc_lso_count_descs(const struct sk_buff *skb) {
>>> +	/* 4 BDs: 1 BD for LSO header + 1 BD for extended BD + 1 BD
>>> +	 * for linear area data but not include LSO header, namely
>>> +	 * skb_headlen(skb) - lso_hdr_len. And 1 BD for gap.

[...]

>>> +					 ((first) & SILSOSFMR0_TCP_1ST_SEG))
>>> +
>>> +#define ENETC4_SILSOSFMR1		0x1304
>>> +#define  SILSOSFMR1_TCP_LAST_SEG	GENMASK(11, 0)
>>> +#define   TCP_FLAGS_FIN			BIT(0)
>>> +#define   TCP_FLAGS_SYN			BIT(1)
>>> +#define   TCP_FLAGS_RST			BIT(2)
>>> +#define   TCP_FLAGS_PSH			BIT(3)
>>> +#define   TCP_FLAGS_ACK			BIT(4)
>>> +#define   TCP_FLAGS_URG			BIT(5)
>>> +#define   TCP_FLAGS_ECE			BIT(6)
>>> +#define   TCP_FLAGS_CWR			BIT(7)
>>> +#define   TCP_FLAGS_NS			BIT(8)
>>
>> Why are you open-coding these if they're present in uapi/linux/tcp.h?
> 
> Okay, I will add 'ENETC' prefix.

You don't need to add a prefix, you need to just use the generic
definitions from the abovementioned file.

>>
>>> +/* According to tso_build_hdr(), clear all special flags for not last
>>> +packet. */
>>
>> But this mask is used only to do a writel(), I don't see it anywhere clearing
>> anything...

Thanks,
Olek

