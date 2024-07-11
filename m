Return-Path: <netdev+bounces-110840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A19C392E891
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 14:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5CEE1C21A1F
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 12:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD9F15CD6A;
	Thu, 11 Jul 2024 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XU2Tam0r"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D277155C95;
	Thu, 11 Jul 2024 12:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720702460; cv=fail; b=MpQ6gkRefvaKriChtp6cVYp9CL+Q7djUQqHWVeE8V0HZU/vYaDBRo8pPv3l4vVMsE5PXF7pVkRuCnTHwD81IyOKRm2mI/7p+kibEO0f7DQxjDRWGzXjVMKUlLm2KI+zIx+jJGmPoF+Y4xACrpG4hJk5hRGKI1vNunHbdO7x74oY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720702460; c=relaxed/simple;
	bh=RqvUJF2ocAhg91gfqZcwcssY90dSoIaCNSeiDIVOFhw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SAN+QK8eecX3nOcUkox69Ni5LJzgFdvytQUyD20DmfOQxS8pDhlD8p5YWTa5gtJSB/Q4i6Z1+vvtXgH/GgI0JvkfSiZWE5kVoa3/q5/bjVrSqjc/OuWqjztFuZYJZeBljvB/xWYIvx43OmKKoZCHpB4o3oQ+Z4RwLP0oZy3jqS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XU2Tam0r; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720702458; x=1752238458;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RqvUJF2ocAhg91gfqZcwcssY90dSoIaCNSeiDIVOFhw=;
  b=XU2Tam0riM+AEBvCv5djgCxkrxnzrZVIpUnrdXv2Y6VEgmi08hODFC7e
   tM4BQaVMkSX4vUhpsBD1IRyj1EUD3KqaUyvRI/4Ha/zmlrWXy+XsgRfzE
   umFQ3cdUqKFFAMpt6eGYTBhT/+Q4iORju3OT8Xny+LzIOhLhTW6YgNP2q
   Ox+bhdn9MgLy0AXwqXHb3DPtTDYYFntY42+N/SfYCARhdEckaAcR4khPz
   e8M5X4CNyzHO46UaHpbB/Q/QHn1EPfJqhdksKmM+ALcpGY0wGbfz8jrEh
   CPJ53nL5HLsYk5v0Rm7vHXZU0LPxUHS2+D520yAxXfLK66GQ626qyWKIh
   Q==;
X-CSE-ConnectionGUID: Td1dxjEJRDiJnmWA9s5qIQ==
X-CSE-MsgGUID: Uoy5274yRemv36qPov6HFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="29472118"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="29472118"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 05:54:17 -0700
X-CSE-ConnectionGUID: 0Gu/nneNR1ubJwjSKl4D+w==
X-CSE-MsgGUID: H76jeBfAS/aZ4JXTWgbTDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="48445638"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2024 05:54:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 05:54:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 05:54:16 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 05:54:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWzBqY+bqtcGd8J/3T13Na+dYaRJvN0OwR8g9eawDChwfRxTv5qqMM+zchQK4YgYfL/3krFubF8DnzQ/1c49fMcB94fZ5PZ+140wHAfSPWwVc/Pvh7JE7VU55JsmH81SOduuWwo2Y6cZukb54WkejL7Ya+PqHcXwx5eiwkF/h+kMFZ5Qf6BhHQj2FFdYwpk+6kuBL3DZ7uNaZj76ejYnYxrQcCP1fC9L3eBKy0PF2x+tXo2mnDtm75FEL9Gp4eHzoQU73ud8+7Oa2hvsuq8jg1cWNCIc2PKESwpjJn5o8JTLBx+4CxghpwSk9WVrsXKM/YkUUR5T4rGXDe6HHtlucQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHxCcqQg1gHXsKnkSMqEippQ5T/on7Rzg4fyt6dzcUU=;
 b=HcIUHlKgk2puirBbVkMdkhboxUlx4BMtbToVJg4qaPuJVm9RZ3avGItTXL67yw6Ha3AjyzenDjFE9w83BPmy8g+PZ3YEylqDdoyfnbZXULOld/NajNRaNmd8AdLUUbQCQDMgfImcv/vMQX8MfLw1LcAsD3C1U9aoLm7h1G69yHcoQgsbARmaQP1Po1JvwgHA6xWkWHl+R3kOkIh8D4fKtqW4uc8CUhyy+Qrl7doksU4dzW/h7W/cDKMbMALOkKh51H0FLJ7d09HF6QWaDEU13UPIgZFLC/0R8nxMex/TP56YSAnxTLQsxGRGqOXXjZdcQhYlcl79XHGBm+UXeR25RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH0PR11MB7711.namprd11.prod.outlook.com (2603:10b6:510:291::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 12:54:13 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 12:54:13 +0000
Message-ID: <279c95ad-a716-415b-a050-b323e21bec31@intel.com>
Date: Thu, 11 Jul 2024 14:54:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] netdevice: define and allocate &net_device
 _properly_
To: Eric Dumazet <edumazet@google.com>
CC: Breno Leitao <leitao@debian.org>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Kees Cook
	<kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	<keescook@chromium.org>, <horms@kernel.org>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
	<linux-hardening@vger.kernel.org>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Jiri Pirko <jiri@resnulli.us>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Daniel Borkmann
	<daniel@iogearbox.net>, Lorenzo Bianconi <lorenzo@kernel.org>, Johannes Berg
	<johannes.berg@intel.com>, Heiner Kallweit <hkallweit1@gmail.com>, "open
 list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
References: <20240709125433.4026177-1-leitao@debian.org>
 <CANn89iJSUg8LJkpRrT0BWWMTiHixJVo1hSpt2-2kBw7BzB8Mqg@mail.gmail.com>
 <Zo5uRR8tOswuMhq0@gmail.com>
 <CANn89iLssOFT2JDfjk9LYh8SVzWZv8tRGS_6ziTLcUTqvqTwYQ@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <CANn89iLssOFT2JDfjk9LYh8SVzWZv8tRGS_6ziTLcUTqvqTwYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB6PR0301CA0094.eurprd03.prod.outlook.com
 (2603:10a6:6:30::41) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH0PR11MB7711:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec9dcc7-a6d4-44c0-ca69-08dca1a890b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TmVRUXY3eUc5YWE0NVA2dnRyQ013WWlEanBPaWRyeXZWdzVoSjlxMkY3ZldZ?=
 =?utf-8?B?SXhyMUJrRTlpUUI2MkVtcWkyUGxWWkp1bkdzM1FkNlIrL3BEdENyN0IyNmNC?=
 =?utf-8?B?ZXNwNzRacTRoRjNJcStQWGZvdTNOcjg3c2piVnhXTVMxVkVaQnFZUmxjOGhR?=
 =?utf-8?B?YnlzV1BoTUR0NXVyQm9tVmw3VjBaelVsek01VzhUZXgwb3p3ejFWNks5VDF6?=
 =?utf-8?B?OTRrckxQL2NIWXJEM1NlL1huMXJXVjFsYmo5d3RzZDdTM0kvZnJLQkFDNk05?=
 =?utf-8?B?YUlDL1g2WUVzZlFTRUZCWnROVC9vTjBhd1kvUCtlK3ZZVXI5RTVoWGppalVh?=
 =?utf-8?B?WEszMWV3SVkxOHRMSEdFYmlPampoVG1sT2ZGVHU2c25SVTZhbko1TDhqSHIr?=
 =?utf-8?B?c0QxRVk3T3M4eDA2aVpSUElXaW1lbXJ6eUY1MGJEdXNrT2ZVNjBvQXNCWE9I?=
 =?utf-8?B?YmhkMlhMcFo5d01NRVVDZDFrb1ZUNDlVNlhuTDNrUlA4aURHQk9MWG5DRlZu?=
 =?utf-8?B?VU16cGpRc2c4eEQzWVRKYTBnUlB5L3dseGpya0gvRXFCZFBJdUZrQXlVelFT?=
 =?utf-8?B?bThYdU0zZzhZWml2d0U0N2RyVXFnVGliRW82YkxVU1Y5NGpoeC9QWXdETm1U?=
 =?utf-8?B?UnFMZUUyUjhUSUZuUkRyQVg0cy9TZlVKMVZ0Z1cyN0RrNzhwSTdqQ1Y2MUl1?=
 =?utf-8?B?T3pvMDZ6MFhWM3BFczN2TitWUkVTVEtoSzZGVFlVNE1tdzB1WkF0MXloajdK?=
 =?utf-8?B?Z1dXblZmenZZZksvUHFXRnBvcDN4UHhwNkxFR1BUWGZDWkRFOFM1QnVzcnBC?=
 =?utf-8?B?aU1INUh6NzlaclJmNjJacmMvZ1ArQkZFYzF6a3A3eEZpTWhlZzRTbFEwU1B0?=
 =?utf-8?B?TXdyamQzRW1pZFNMVnEweDJ6eUsvUXJzVmJ6cHJ1bnlRM0k4dDIzb3BUWTBh?=
 =?utf-8?B?U0VJRUlkb003WnEvOHNkd3E3aVZzNFhyVGRkWEl1eXdHVW1sOEQrSEFoRkhO?=
 =?utf-8?B?WjlBNUNzOWxxTEl3cWtKRHBhdDZlbERRU1FVWFpWejFla0xZUStiYmpLWTJv?=
 =?utf-8?B?TTh1VHV4UVk4bDV4VmsrZ0liM2ZzUzRyenRRRzY2Q0NWQW5taWhNTjhJOXZq?=
 =?utf-8?B?Qm81bklQSHpnYVJDRkdhWUI0UmxNTVRuOFQ3NGYzcGlvQ1JkYnpqaTB4VnFJ?=
 =?utf-8?B?MEZUWTk0NHRYTmpneUZGQkRkeGE5d1R5R0p6WDdOTlI4Y3VIejNWcWZMVm5H?=
 =?utf-8?B?UUUvblExVkxLTFdscTdFZmJSVDlWWE5yVC9rbXdFWTVjUFNOSlFDb1VSNk1U?=
 =?utf-8?B?dlZlRG5oZ01sT1pteEtTV3hzKytoRk14VTlCbjBGZWRNQm1pYVhWSzlLbWpJ?=
 =?utf-8?B?ZWF2dFlCZ0QxaE1BVVNFam5KRE9MMmtGc2ZqcWswMkRoaXhlQTYxN2VSL0tL?=
 =?utf-8?B?Z0syMmQ0bkNWTTJiU3IweVZwV3JDUzdOdmd5RldTOGJvcmJ4a0JKYjJYQXZ4?=
 =?utf-8?B?M2JuOENHQ0gxbkpPT0J6WWV6eVhGQ1pDT1A4QThIaU1rRExIRHA2YkZaQWZp?=
 =?utf-8?B?TVlpcE1xeTcxY01OTW5GenJiZUlTNEZaVVRoSDhlRVZueWw3OWNEbFdSN2V2?=
 =?utf-8?B?Qzdxb1lWMG5qVUVjeU9lRk9kNUtDa2gxTG1GMXVTT05lcEFiTjhGNk1UUE5J?=
 =?utf-8?B?TWpTTk5QY3BRUHgzYTYwVzRLMzNNZDFxeDRSQVRYSHNCWEJLVlpjd200NWdr?=
 =?utf-8?B?eUdZMFBLcmJ4cEZIdTc0Smx3RXlkSWM2a0FCMG42SlRxWlpzTmErOUFMdC9s?=
 =?utf-8?B?TllVcEtKZzZjb0swREZvQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WndpN1RRbnpwWDlYdDJrcjFTd04xZXpCS2x4OXdnL3ZMdk5zNlp2RHJGMGZS?=
 =?utf-8?B?eTBLZmlxeDIxNEtveUFiUWMyMlhGM25wL3I5UkxtcGVTT0diNUJTa3podlVK?=
 =?utf-8?B?MHc5aWxnT0tiUkE3RGhsUmsxa2tqWVVUTi9nVXVmRWlSOVZ3Q2Zjem5iTG92?=
 =?utf-8?B?d0lOSFptNWhSM21KblpLbU5DdEFJVXNFYWxtZjVCeE0vQjhqOWIvSnVxcUZm?=
 =?utf-8?B?RnMrWTluOWFDOERzRXBta2hCVDYxSW1ieUdsUHY1ajNvWVdyWHRhamZySTFw?=
 =?utf-8?B?dHJCSVFhSU5BZjZnUVdpa3VtQkkvWGV6UHBMeW0wemU5NXJOa2NyRkdqbWJu?=
 =?utf-8?B?dERvZTE3OWZOajNrRXZZaUhZcFNyN0hvRFFDb2VoeWRzbTZXV0FkYzZtL2pJ?=
 =?utf-8?B?NHFEdXU0eTVnbC9rcjJvY2ZHd1dvR2NuS3laZUVqZHV1bDJMeFdNaGRpTlor?=
 =?utf-8?B?bWZINTRaYVBWazkzOEhOSlhJSHFScGdKdEhlaXRHdXdYa3VwWUptV0tnZGx0?=
 =?utf-8?B?R210aGZEQVcva2pXVjd3d3BRSERKSndpMTNBbzcxa0MrTGkrMmtXZ1RxTzJs?=
 =?utf-8?B?ajU5UWFkV0Rxb3B2ZmplS3JFSGZpMDFqZWx4VnpYOE5HNG1UR29mdmR3VHFr?=
 =?utf-8?B?aUZYVWpVek1rV1VaaWdRVnVDbmtpdkJTZDFoUDJvUmpnOEtua2hiZTFNWkxN?=
 =?utf-8?B?S000c01PVVliZXJncDJuRlNoQTVzeU12anhGbjVXS21nV1V1MmxQN0NSSGlv?=
 =?utf-8?B?RUJiakVmOUI0My9iVnJKSDJuRE5rV0o0c2piTGQybmJuWG9kcjVEL0NMcDJF?=
 =?utf-8?B?Rk16dkNHd1pzUXh4OXB3WitlWkFpbHJIdGo2bHJuNUNNNVFqcTBCZnM3MHYw?=
 =?utf-8?B?aldOWHdyWnVnOFZ3RlNKV0FYM0VleGxmbHRSMkpxSUhtYnUxQmxhMWx1TzN0?=
 =?utf-8?B?c2U0bWxJZTZ3a25NajZwZDNIeFJjaFdKY3N0WlYxRHRRL3JINWJzbzVVZFN1?=
 =?utf-8?B?UkRXbVQ2VktLMms4cTQ1VDB3V3JUNVJxMHRnSTdDNEhqeis1aHNUc3d4eThK?=
 =?utf-8?B?bll3TGQxWURtay9DRmRlSGNJQmYyM1ZHUDBkb3JSRjRFelBxaUdMUzFuSHBQ?=
 =?utf-8?B?VndZUUdWTXB0M3NLYmhxWE0rRU9Da2w3ZDMwSHR3VTJCVlV2UE1qR0hMN0VR?=
 =?utf-8?B?bDNkZ3BEdmI3aEg2dWFvWHRkY2FXV0FVKzgrbDVvN2RpTElJNkNaMXZIdnNz?=
 =?utf-8?B?UVBXdzl4ZzNNT2ZUTTIwS2drRXo2S0NyQW5wWWdOODZSWGFVaTdsaW5SdzhH?=
 =?utf-8?B?bCt0NkRtRUhyTUpMZVprSUlQb2U4KytWZEZtYk9pQmdVS0FOd2NZYW9TRUxT?=
 =?utf-8?B?bHVrWWxLdHJJSTF6cTFlek9ITnJqTVdNdHN1N0tVNUZQeHhKc280UElQUjcz?=
 =?utf-8?B?ZjdmMWVHZUtLYkNrcEFwVXNyQWlCaEZqZmRBcFp5VW5IdXRwaUc4aTdTK1N5?=
 =?utf-8?B?SmN4TiszeGNuY1J2cDdrSG9zWWZaZFdySEUzSVNKTnk3aGxraUpsUy9Xalp5?=
 =?utf-8?B?UVdQajMrL3ZFTUZlRzM1OFRiY1krZ293cFJ3Sno5WnREc3pUSVJpSDlUbFg4?=
 =?utf-8?B?VVdlMnBTOUtuQUgvamVvdEtGMGdrdkFYV200SVNQOUs4UkI4dDhOOVZIdkV4?=
 =?utf-8?B?VXFTNkdmNlZNc1Y3Ti9hOGFGd3I2Nm85bFVWRFhkbjFGa01Ob240RFQ5SlBJ?=
 =?utf-8?B?U2F2TmZjTXV5ZGh2VDdpMzBSNHdsN2h4VmhJd3ZVWlNNaldpWXFLeVhqL2Jw?=
 =?utf-8?B?anJyQThjMkxKaEtXQU1KTXl1dEV4L2orQnhwSFoxRUl4OXhERnlpT3BPUkhQ?=
 =?utf-8?B?eTdyT09uVG9SQTJCRDVFRUQvaUJuVWdzYitnZmZKbFBXMXNMTzQxSVdOWVVn?=
 =?utf-8?B?b3NpbC84WHgxMXh3SXhUM3FQeWQxdmJnbkVieTNqV08rcFZTcjFxanBuVkto?=
 =?utf-8?B?Vmo0a2VhKy9FUHdqcCtEREpiMnVkRVUzYkY1aW1Wd2hMbGZOZXpGbGFFeEd2?=
 =?utf-8?B?aDNqNXRIOFpnRVZuMGxGMzFnUjNyaGZSTHVmOHZGeFNvdjVWRlR2SVFxekpo?=
 =?utf-8?B?bXJOelkvc3VxMmFYNFh2c1BtVHF3NHRjY1NKQlRyN2NrVWRUNEVQVFdvMyt1?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec9dcc7-a6d4-44c0-ca69-08dca1a890b8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 12:54:13.6575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T+BJUMFFANFCMVqtCAqMW81tcqrNYrURybnxdiRrSchtkNTywlS064yNNKpOXktYpy4S8Go4zaXaPT2hsvgHEsy3ToH26ETD9A9nUwvk33Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7711
X-OriginatorOrg: intel.com

From: Eric Dumazet <edumazet@google.com>
Date: Wed, 10 Jul 2024 10:04:39 -0700

> On Wed, Jul 10, 2024 at 4:19 AM Breno Leitao <leitao@debian.org> wrote:
>>
>> Hello Eric,
>>
>> On Tue, Jul 09, 2024 at 08:27:45AM -0700, Eric Dumazet wrote:
>>> On Tue, Jul 9, 2024 at 5:54 AM Breno Leitao <leitao@debian.org> wrote:
>>
>>>> @@ -2596,7 +2599,7 @@ void dev_net_set(struct net_device *dev, struct net *net)
>>>>   */
>>>>  static inline void *netdev_priv(const struct net_device *dev)
>>>>  {
>>>> -       return (char *)dev + ALIGN(sizeof(struct net_device), NETDEV_ALIGN);
>>>> +       return (void *)dev->priv;
>>>
>>> Minor remark : the cast is not needed, but this is fine.
>>
>> In fact, the compiler is not very happy if I remove the cast:
>>
>>         ./include/linux/netdevice.h:2603:9: error: returning 'const u8[]' (aka 'const unsigned char[]') from a function with result type 'void *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
>>          2603 |         return dev->priv;
>>               |                ^~~~~~~~~
> 
> This is because of the ‘const’ qualifier of the parameter.
> 
> This could be solved with _Generic() later, if we want to keep the
> const qualifier.

I tried _Generic() when I was working on this patch and it seems like
lots of drivers need to be fixed first. They pass a const &net_device,
but assign the result to a non-const variable and modify fields there.
That's why I bet up on this and just casted to (void *) for now.

Thanks,
Olek

