Return-Path: <netdev+bounces-104539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A34EF90D229
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 15:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F0A1F24716
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3381AB8EE;
	Tue, 18 Jun 2024 13:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PS9FP1n4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7AC1AB8E0;
	Tue, 18 Jun 2024 13:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716604; cv=fail; b=ENYw6bKrRgz1R662rvpj6bfS/eUrEltX3hMUQAIbUmozffgbMjcHZxu4Ss2b0m7OgedNQUr4OXGc56n+n6aDWkW4y+JPYhTD0OftbsuJNzbjBeQ54MCKFwbdxq/I6geQp6N05vAXNTp/LKFAtNQRaTMxav491+y3F9eb83gyDKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716604; c=relaxed/simple;
	bh=j/v1pYjGax3LjLb9ZoB4xcIHEL3LyzsZKVSNWyAPrnw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y+3lyBSk8mrh/D9yi3hOij6xHChPCFnxmuGmM+gnxEFHaUr8veGhn1aWrhflwP5DoZTGNubO8AdDUX3GcI0omPAe4T/RWedvQq5jDdDvD4J4yXe1Ckgu5jS/YQi+wwudE3n2NSJKeySQidQjK5QdU7BVEsI0+gyQ3gpen7sgpmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PS9FP1n4; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718716603; x=1750252603;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j/v1pYjGax3LjLb9ZoB4xcIHEL3LyzsZKVSNWyAPrnw=;
  b=PS9FP1n4HTgeuCzyO2RM0yGYzHaRZI201+D741YBYlQcMLWMVVKRUVep
   Yq2/HSqIx7A/sjqC1VtqGUAVoxl5FEfhm3Obvi0XwSf0a3AarCCgsXdgF
   lPiV+PA1BLFo3IC8WlDU2J3fdg4xOyjNSwqaLYcB7/saY6Cr2U09wTB8T
   XViz1YiKarTmwuAjCJkcAHskkj7Fd6ktygvNbx5Fco9JUt73d4cKjNnY8
   YN3T9ET/HrkuH+NpmD9W3A7AJ2Ub/PwQnsIHRzsoci8wMxxzeOmPRS6Dz
   ypl9zMBMgxEeCGNGwYblDYewl3uryjklHa5JZbdKE39Lc6iV5lZFSG3oQ
   Q==;
X-CSE-ConnectionGUID: 9LZcPNOuQii8RDTS9jgrGw==
X-CSE-MsgGUID: PvK3NmBzQ1m1EbVjaXpXxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="41001098"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="41001098"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 06:16:41 -0700
X-CSE-ConnectionGUID: 2+MMLBttT3mQL0j/40Gj6g==
X-CSE-MsgGUID: jT15bDxXRtqEH9ImGJLCBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="46011076"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jun 2024 06:16:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Jun 2024 06:16:40 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 18 Jun 2024 06:16:40 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Jun 2024 06:16:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lW3RdNBayZljsVcSL4dtfI4TDdFSFyPwQuA1cYg9As++1TQ1NU2+FBe6eVH+np/zoqrAE0Z2a25dCDwQHG4Xq/WIJ0+kJY9t2jdvBKKPCBDCLTsXCpHLhpj7LJwTLL/51XD7XOfP+IfcwWudVs1y45Fa3Z6wmlBBp5Om+39hICbcQOCdRSXfOpk8bgcyfSbieyc4bBun0/y5WXenPuRRtG7P83rMlC06NIik4vNPo5C47TV7i4+tdLjdkxOQWwb9KLNMjdx4e/5gj6SbuM6T4bWghWJtNwqeAwyNcr+3/Zvm0Ph/1QsaiBwrHhKb3KL+W6zr8uq8QmLZYsz43RTlYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VheRVCghEW52bPVUUxMownlCDyvT22eAxF5wyb6VrgY=;
 b=UGPSgGW+A26JiH9Qfj8YtLb1owO25aucJZUTo2nQxXxP1T6XSFzC/fpU6G7HedBd9eLCP5xRz6KJln9OslgzUd4jTB0oBDZHMXet8Vf927vuyo4QEO9lVDB9HLlmUPebqoxxUMbwV89fyzyBzTdEk9fYIu+s8z7PyzgqQL5dOLL030ysjHrLybWQ/A2TV51I00duDuj88vpJaVms6YXeMxRo5za2xHvpgYmZ+G+22v8WIjd+mHa61/LIet88flC22+MUR/ZSNSEqShwSY3/K/ZjaxqavgU9AcexZreyWM+N2avQssU8Cv5iDyizMzdEM9BI7Vc2IhcX9JSI52R13/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by MN2PR11MB4581.namprd11.prod.outlook.com (2603:10b6:208:26c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 13:16:35 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 13:16:35 +0000
Message-ID: <246aa990-3e94-4372-ba49-7b2620240f2a@intel.com>
Date: Tue, 18 Jun 2024 15:16:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] net: dsa: mt7530: factor out bridge
 join/leave logic
To: Matthias Schiffer <mschiffer@universe-factory.net>,
	=?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>, Daniel Golle
	<daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, Sean Wang
	<sean.wang@mediatek.com>
CC: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
References: <15c28e5ed5fa02ca7904c71540e254617d571eb8.1718694181.git.mschiffer@universe-factory.net>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <15c28e5ed5fa02ca7904c71540e254617d571eb8.1718694181.git.mschiffer@universe-factory.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0080.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::33) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|MN2PR11MB4581:EE_
X-MS-Office365-Filtering-Correlation-Id: e69b947c-78c0-40c1-80eb-08dc8f98e0f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|7416011|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TkNaMzJnQVVidlpZS29tQlVUVjlmRGxhZDV1SzFGSWRWOWtJbXlmNkRCdmJX?=
 =?utf-8?B?YXFRdlZOQUt6ZlRSMGxsZTNiWXNsb1EyOWR6YmxJWGFnUHdNV3FsSGVGOHJt?=
 =?utf-8?B?QXRXZU9MSUV3WE9hTlVEdytYTElMNWFWMC9wMmJHZVNqMnE5d3l4WlFtU1RE?=
 =?utf-8?B?bU5iWm0xVGdGdnFBSy9jOHdaSVY2TnFKMkJSWlBsd3BxY2ovZENsK2JzVE91?=
 =?utf-8?B?eHc4alZ3VTlRRGhVYUg4NlZ4cXRTYllGelhpUWs4eStJVWh5aHpmT2dqSEdW?=
 =?utf-8?B?NnI0cFVxdjhydGs4M3E3Vml3bFIvNEcrRDl4L0hsb2ZJM0hrVVIrVS96U0ZB?=
 =?utf-8?B?eUF4MGQ1VjhVSUZlTk9rMHQ4alppSk1xMDJadThlc0JWdjRpcENDcjhmTkZi?=
 =?utf-8?B?WFR2V3NZNldWanQySUlYUHp6SVhtVWtrdFpNWjRqRlNOYlhCS0dKOGhKR1Zo?=
 =?utf-8?B?aStXQXYwVnh2Tk9YaFdwSlVSeFhRelk1RU5BL3E2ZTdMTm5HSzFCS3Vub0to?=
 =?utf-8?B?UUZhMG9MMFY2M091cXAvQmpxcnVzaGkxTmlVTElaVGJUM0pIc21Yd0ZqeEg4?=
 =?utf-8?B?d3RqTEw2M1hqMzQ4MXFHT0N3SGovWENiak5DcXE1RjZ1RlhYMlBFL0VtRmZw?=
 =?utf-8?B?S2dSZVVpVnhXVWxheVI0Wk1HOUNEdFNkVDFYMWptRFBUdkU5clh2ZXVkTGd5?=
 =?utf-8?B?d2lNclVjN2hXZjlxTGw0Y0lJOCt1bHdUWlNSKzZ3eFp0MTFaa2NIMGphUzBs?=
 =?utf-8?B?ajVyWWhJbFJURHhLcnVjaHAxSVRaeFB3akNySVFMV000cjhNRk5MTDNTNVp6?=
 =?utf-8?B?OHhaaHYvRHdRVExMQVJlbVJnWE5KenRQeHZaN3lzdmtGZXRCOExmVUdjN0cv?=
 =?utf-8?B?ZVJqb0lubnhlS3NkOUhUbnZZdi91MkZZMlNLUWVuNnRxZUF2eGNLVVpCV29u?=
 =?utf-8?B?UGxRVFcyMi9uTytJbnZHdEw2RFhQNVRRMysvT20zWjRRcjBqTGFTQWZLdGNu?=
 =?utf-8?B?S0RMVUFLM3BKUDBoUFBXZWlPWkpSTjJXNGdTNjRuYURnYnplYTNiR01NUEIz?=
 =?utf-8?B?WW41aExTQ3dCWUtVaytrS3VyREJ0TkUxU240Q29RNnIreE42SkY2U3cxSnFV?=
 =?utf-8?B?aGF1eG1ucGN0NlkxMG0xT2p2Q0VDUUtnT3lhWWNrd2pibjZpZFBnRS9XTVNz?=
 =?utf-8?B?WVBkMnE1V21rNmVsckhsKzZDenlKbG9TUzBFWUtjeHJZTmhZQi8rZW5RRDNx?=
 =?utf-8?B?VmVheUN3UHltWjQ4TFBqZHRiOE5QNkVsdmhZa0lVYlp1dXNOYjJ0VnkwYmZQ?=
 =?utf-8?B?dzVXOSswWVNsMjlmbnBWRC9IaTd5RG5udlJwMHBFWElzU2hQVFgrRmp1SVE3?=
 =?utf-8?B?VGRaSFR2UkhkL3NQeHFGVnRaWnhEZllXYnlSWlJ4NDk0U0F1dzMzbXNlaStD?=
 =?utf-8?B?L1JHc1BmeDJnNjdhT0lTOGkzMDhlb1dWZkdJMFFjL2svZmhTK0I3TnRXeFNF?=
 =?utf-8?B?Y2NodWZ1NTVhekFMd1N0bWVMK2hHbVVrY0JWNDZXQ29yWnhBaVIvZDZERlFk?=
 =?utf-8?B?TWlTdGJrM3JWaFdIU3gya2lianFKaHBJMGtYa3gvcW5oK1ArdkZyME9aYUl4?=
 =?utf-8?B?d0ZKeGJXcHJlZ0tCREdDcm9hZ25lZG9Gbmdyd1lFUERLaTZXSGRJRE5ZaDJj?=
 =?utf-8?B?ck9IYWJZNWM1Q3NTYnFHeHFkOC8xU0d5RWplRjJxaW42MG9wQS8wckJLblFy?=
 =?utf-8?Q?t3xNPo5U7OTnOsKoriPjAl1BNvTdSX4kM2sVmUN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0Mzc3RydlFDRjBQTDBzT1gveVNKMkxUYmtoZXpuT0lyQXRTUGFVaTc5dFM2?=
 =?utf-8?B?T3RwcUUzWmd0dWMxcEZ2Y0Q1ckQzcWZzcEdSSXA1R0lOUlQrSmpSR0xyMjUv?=
 =?utf-8?B?eDhkNmJwelFBY2ZvSmN2U1o0VzJ1VWUzYzltOWJRZ3pxWnFhdlpxTmFHUG12?=
 =?utf-8?B?d0JjTHA4VnR3bGxsUEFDdzFsWHozeW5IOUh4NERmc29KNmVkcSt2dmgxb2xI?=
 =?utf-8?B?ZlVwdHo5Q2hQU0pobnM1YVFaS3IzNzJRZjJYS2VNZDVYb3pJSElUU2tkWGRK?=
 =?utf-8?B?T1E2YXp3ZFdpSDFBbkhDQ0Y3NTZ4Q3RmZHpCUm5mYUpiUWpSTEwzWlkySDRX?=
 =?utf-8?B?VUJSQXl1S0dQVGpnOGNXSVVlZExzZGdDYnBvK0VLTDZyeDROYTVRY2tDZkxn?=
 =?utf-8?B?TWJjcHNtN05nV2J6Y2lhZWErWVJWbVhtYzIwbVVXN2VqbklLcVJvaFcrTDUv?=
 =?utf-8?B?ZURpNTBsZHdQRk9kaExuQk1lckNjU2ZWWDRRZWFqTEwydHhoWWpRcWRJblRQ?=
 =?utf-8?B?dmZMdzBldVRRaTlKVDZpaGxKZitlaXZpbWIrZ1pWZlRUajVYTGF6TjUzQWhB?=
 =?utf-8?B?YUJaVTdITWc5OEVBQThPNG9BcVpESVdla1J3OG1iWWVMVlJIRnYwbDVYdnFv?=
 =?utf-8?B?WE5jMitYZjA5SWxpSGlPaFBUTlF1WDYwN1JkWGxFY2lBbnRod1NnZFZFZmZY?=
 =?utf-8?B?SEJuOXNlMXBZYWI3S0ZjWGx3Q2JDaGJqcmdVWk1uNytpUFVmd0FNWTdIVjU4?=
 =?utf-8?B?TnBRQzVXY2Q0NEJPOFIzL29DSDQ4aWw1dzY5U3RibTYvMUg4M3hBZUtjUDFW?=
 =?utf-8?B?OXNXWGZXNEtVc2FMSE1Iak5aMk56NjZFVVUzdjVrN1lVcmpsMTRWOGxpVDBa?=
 =?utf-8?B?ZnVHaVNFTWRxNXRBVnZkUHhlcnV0UEYrY1ZZM3lxVkdlM01taTI0ZzFLT1hk?=
 =?utf-8?B?WUdIVmY1YlRkdVpzc0FoSUdraWZMTGNUQVhOdEFiT1JFL1dvVWpxK2xZKzVN?=
 =?utf-8?B?ajdYUStsS0o0SVFsOWdYY2ZMM3oyN2pXVC9jL2RYV3ZiZW5UR0VFZGttQUhK?=
 =?utf-8?B?Qit0QUhid0t0ajhYSGZYWUZUczdTNm5tUlZ2dE1WNDlVaFdIUkp6aFdYUEtq?=
 =?utf-8?B?QmZ5TzJYNEFuNWYwTHFwb3QzcU1ONm4rYlNiSE5qbEQ2alpLeEYranhaQTRF?=
 =?utf-8?B?V2t0UTRCcHBrcHUxWjlOSW1DcW0zNUFUSjE2WFErK0hLdzYveEpFT2JIdFZR?=
 =?utf-8?B?QnhHSVZpNVJOK1A4UkR3dEwxanU1MnJudWl6Zm1HRkZOY0dpL1RROEgxNjl2?=
 =?utf-8?B?dDFMTjFHTDlMNjZiT0NZR3dlR0xML1J3TUpGWVZlQnZqOXZwTXlsOW9HTVJm?=
 =?utf-8?B?aWZyODFDNFhZZWhJcGJsaWp2OFNMc0VkbEJhNm5Md3YxTFFnbFpPMzBTWThk?=
 =?utf-8?B?VllVZGlSNFFQOUZiQ1ZZMXErNjVnOUtKOUlScXlONHZGU0Y1N2NIS3NnVElq?=
 =?utf-8?B?cnI0RXpzSStMSWVTWk9tUE5nMXJsa2U4NFRxSTNHTWFHT3paMnNBeitjRURP?=
 =?utf-8?B?bmY1czk0akloYTRMcmpQOEoxbkdOU2VadVcxZ1llcVM4bEUrWGhPbFk5NVg0?=
 =?utf-8?B?RmNGcU1vL3BFeEJoS1ZhdTc2c3IzNUZXU0VXZ1ZKcFloWXRPWStyZmNNcjNv?=
 =?utf-8?B?cW1TV2JnWFM4RytOUG0vUndhM0ZXZ2hFRjQyWU9Oc2UweEVzUjJhUkgxOXJl?=
 =?utf-8?B?TWo0TklYbnRjY0cwRTVva0x4aGp0KzdrWVNLSzUvVDhuWGF1YzZlN0RGTnd6?=
 =?utf-8?B?Z05JRTBBSTNXdC8wMHBOQ0ZEWWRFSE12N0RDaVpuNWo3RGMwc1BWSGNOTXFP?=
 =?utf-8?B?YnpzakVPT1ZnaElKOERBcnAyY2hMUXNCOGZZbjV5dEQ3T3dKeUlyenBlWWVy?=
 =?utf-8?B?ZitqVXVuWUU2V0hOa05kR0xCZ3lvUXpIOEhDNnZZUXRDTkJNYWJRSXNRanM4?=
 =?utf-8?B?T09tbTJ2NHUwdWFPTGd5UmhrRi9kRFFtdXJCSFRoRkpEWVR6d1IrUzE2Nmxw?=
 =?utf-8?B?Z29Pc1VPRFFVeXprWEtmaTE4TUFxYW5WVjdOakpESUloOG9ocXord0pSM1Bx?=
 =?utf-8?Q?28V55nUWO2j7fM6llfYenlZs2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e69b947c-78c0-40c1-80eb-08dc8f98e0f9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 13:16:35.4387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KHQIyV3scvCgFK63qNEAaP9oncJEnMmi8ZwxtPY3wI1pqw+OedcJFcgdaBZonVu+WC0JzSfRKQs/BMVy3MRrTLsAG9sn/FwXLch6awODwBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4581
X-OriginatorOrg: intel.com



On 18.06.2024 09:17, Matthias Schiffer wrote:
> As preparation for implementing bridge port isolation, move the logic to
> add and remove bits in the port matrix into a new helper
> mt7530_update_port_member(), which is called from
> mt7530_port_bridge_join() and mt7530_port_bridge_leave().
> 
> Another part of the preparation is using dsa_port_offloads_bridge_dev()
> instead of dsa_port_offloads_bridge() to check for bridge membership, as
> we don't have a struct dsa_bridge in mt7530_port_bridge_flags().
> 
> The port matrix setting is slightly streamlined, now always first setting
> the mt7530_port's pm field and then writing the port matrix from that
> field into the hardware register, instead of duplicating the bit
> manipulation for both the struct field and the register.
> 
> mt7530_port_bridge_join() was previously using |= to update the port
> matrix with the port bitmap, which was unnecessary, as pm would only
> have the CPU port set before joining a bridge; a simple assignment can
> be used for both joining and leaving (and will also work when individual
> bits are added/removed in port_bitmap with regard to the previous port
> matrix, which is what happens with port isolation).
> 
> No functional change intended.
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---

Nice cleanup :)
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

> 
> v2: no changes
> v3: addressed overlooked review comments:
> - Ran clang-format on the patch
> - Restored code comment
> - Extended commit message
> 
> Thanks for the clang-format pointer - last time I tried that on kernel
> code (years ago), it was rather underwhelming, but it seems it has
> improved a lot.
> 
>  drivers/net/dsa/mt7530.c | 105 ++++++++++++++++++---------------------
>  1 file changed, 48 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 598434d8d6e4..9ce27ce07d77 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -1302,6 +1302,52 @@ mt7530_stp_state_set(struct dsa_switch *ds, int port, u8 state)
>  		   FID_PST(FID_BRIDGED, stp_state));
>  }
>  
> +static void mt7530_update_port_member(struct mt7530_priv *priv, int port,
> +				      const struct net_device *bridge_dev,
> +				      bool join) __must_hold(&priv->reg_mutex)
> +{
> +	struct dsa_port *dp = dsa_to_port(priv->ds, port), *other_dp;
> +	struct mt7530_port *p = &priv->ports[port], *other_p;
> +	struct dsa_port *cpu_dp = dp->cpu_dp;
> +	u32 port_bitmap = BIT(cpu_dp->index);
> +	int other_port;
> +
> +	dsa_switch_for_each_user_port(other_dp, priv->ds) {
> +		other_port = other_dp->index;
> +		other_p = &priv->ports[other_port];
> +
> +		if (dp == other_dp)
> +			continue;
> +
> +		/* Add/remove this port to/from the port matrix of the other
> +		 * ports in the same bridge. If the port is disabled, port
> +		 * matrix is kept and not being setup until the port becomes
> +		 * enabled.
> +		 */
> +		if (!dsa_port_offloads_bridge_dev(other_dp, bridge_dev))
> +			continue;
> +
> +		if (join) {
> +			other_p->pm |= PCR_MATRIX(BIT(port));
> +			port_bitmap |= BIT(other_port);
> +		} else {
> +			other_p->pm &= ~PCR_MATRIX(BIT(port));
> +		}
> +
> +		if (other_p->enable)
> +			mt7530_rmw(priv, MT7530_PCR_P(other_port),
> +				   PCR_MATRIX_MASK, other_p->pm);
> +	}
> +
> +	/* Add/remove the all other ports to this port matrix. For !join
> +	 * (leaving the bridge), only the CPU port will remain in the port matrix
> +	 * of this port.
> +	 */
> +	p->pm = PCR_MATRIX(port_bitmap);
> +	if (priv->ports[port].enable)
> +		mt7530_rmw(priv, MT7530_PCR_P(port), PCR_MATRIX_MASK, p->pm);
> +}
> +
>  static int
>  mt7530_port_pre_bridge_flags(struct dsa_switch *ds, int port,
>  			     struct switchdev_brport_flags flags,
> @@ -1345,39 +1391,11 @@ mt7530_port_bridge_join(struct dsa_switch *ds, int port,
>  			struct dsa_bridge bridge, bool *tx_fwd_offload,
>  			struct netlink_ext_ack *extack)
>  {
> -	struct dsa_port *dp = dsa_to_port(ds, port), *other_dp;
> -	struct dsa_port *cpu_dp = dp->cpu_dp;
> -	u32 port_bitmap = BIT(cpu_dp->index);
>  	struct mt7530_priv *priv = ds->priv;
>  
>  	mutex_lock(&priv->reg_mutex);
>  
> -	dsa_switch_for_each_user_port(other_dp, ds) {
> -		int other_port = other_dp->index;
> -
> -		if (dp == other_dp)
> -			continue;
> -
> -		/* Add this port to the port matrix of the other ports in the
> -		 * same bridge. If the port is disabled, port matrix is kept
> -		 * and not being setup until the port becomes enabled.
> -		 */
> -		if (!dsa_port_offloads_bridge(other_dp, &bridge))
> -			continue;
> -
> -		if (priv->ports[other_port].enable)
> -			mt7530_set(priv, MT7530_PCR_P(other_port),
> -				   PCR_MATRIX(BIT(port)));
> -		priv->ports[other_port].pm |= PCR_MATRIX(BIT(port));
> -
> -		port_bitmap |= BIT(other_port);
> -	}
> -
> -	/* Add the all other ports to this port matrix. */
> -	if (priv->ports[port].enable)
> -		mt7530_rmw(priv, MT7530_PCR_P(port),
> -			   PCR_MATRIX_MASK, PCR_MATRIX(port_bitmap));
> -	priv->ports[port].pm |= PCR_MATRIX(port_bitmap);
> +	mt7530_update_port_member(priv, port, bridge.dev, true);
>  
>  	/* Set to fallback mode for independent VLAN learning */
>  	mt7530_rmw(priv, MT7530_PCR_P(port), PCR_PORT_VLAN_MASK,
> @@ -1478,38 +1496,11 @@ static void
>  mt7530_port_bridge_leave(struct dsa_switch *ds, int port,
>  			 struct dsa_bridge bridge)
>  {
> -	struct dsa_port *dp = dsa_to_port(ds, port), *other_dp;
> -	struct dsa_port *cpu_dp = dp->cpu_dp;
>  	struct mt7530_priv *priv = ds->priv;
>  
>  	mutex_lock(&priv->reg_mutex);
>  
> -	dsa_switch_for_each_user_port(other_dp, ds) {
> -		int other_port = other_dp->index;
> -
> -		if (dp == other_dp)
> -			continue;
> -
> -		/* Remove this port from the port matrix of the other ports
> -		 * in the same bridge. If the port is disabled, port matrix
> -		 * is kept and not being setup until the port becomes enabled.
> -		 */
> -		if (!dsa_port_offloads_bridge(other_dp, &bridge))
> -			continue;
> -
> -		if (priv->ports[other_port].enable)
> -			mt7530_clear(priv, MT7530_PCR_P(other_port),
> -				     PCR_MATRIX(BIT(port)));
> -		priv->ports[other_port].pm &= ~PCR_MATRIX(BIT(port));
> -	}
> -
> -	/* Set the cpu port to be the only one in the port matrix of
> -	 * this port.
> -	 */
> -	if (priv->ports[port].enable)
> -		mt7530_rmw(priv, MT7530_PCR_P(port), PCR_MATRIX_MASK,
> -			   PCR_MATRIX(BIT(cpu_dp->index)));
> -	priv->ports[port].pm = PCR_MATRIX(BIT(cpu_dp->index));
> +	mt7530_update_port_member(priv, port, bridge.dev, false);
>  
>  	/* When a port is removed from the bridge, the port would be set up
>  	 * back to the default as is at initial boot which is a VLAN-unaware

