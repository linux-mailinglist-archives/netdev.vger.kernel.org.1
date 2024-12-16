Return-Path: <netdev+bounces-152073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3E29F295B
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 05:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA51F1615F9
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 04:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DA7189906;
	Mon, 16 Dec 2024 04:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OlXy4+h7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53BE1B412D
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 04:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734324823; cv=fail; b=eEiKbdJZTifTnBYWN3BgZJcURUIkiG+OZAxzJD0JhU5dnKaJQxNta4h69bZnyz30QOvZzsZcRp2zzpUKJAfKjwzWOzxAjwyPgK58wcXNQSYiG5gCymu6FC4dB9S9esVklHqWDHlNwhjBbfUnr1s3jzNoerXtG8U+4ARP9s17YfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734324823; c=relaxed/simple;
	bh=4p2qN6/lKpG8RTeWrIB98Zccc4eZjsCju4tVLsx+BPM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BWgtJg0HaTQGNLPLCyCcIahPW1CIYpGL6+CIn2ppVY9oogZMq0WCQdp3n1r4iES12ymfx6fnTOqky00klv04qDLGb/Id4UKQ8V40gGHELcwbySIOa9nOf2kiZcxasOWi7UUa4i1RliFR4vTPHMPTxUQWWHJLJ9tnE9OBuSv/Azo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OlXy4+h7; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734324822; x=1765860822;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4p2qN6/lKpG8RTeWrIB98Zccc4eZjsCju4tVLsx+BPM=;
  b=OlXy4+h7cXi9EIWPj7kbzMBPsZwzfhQUTOgo00QLy0ldB6OL546sX3o+
   +aW+uViUNRqhGSUNeQ8AK3IGxPuEs+lFN+HqaSFKlbn2QAnFiej3WWzD3
   WPzAAJVkDzEGO703vTLKaiouT58tI0/vN6xMZMpoMTGggfOOkBqAU1h0i
   /2unLvNyb/j0KpkXQJjGaH/p1XPqgpTAyczpLL/d6T2h8Eiffutt0OwuO
   r3IQhWMjf4MKp9a0amfpgzE7VncWwNWcR0O3Or31+QuEEbTHAD+yqAY5/
   ifSIelzu17RicZwbHNFyRieQRTrBHH/VqpQTOL2n9yrHlRISD3X1sfPih
   Q==;
X-CSE-ConnectionGUID: ctuvH5kWQAic+NgBCjbYJQ==
X-CSE-MsgGUID: b2ucaymtSdKAav/befyq4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45182218"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45182218"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 20:53:40 -0800
X-CSE-ConnectionGUID: vH+gtt5SSWOcEfniLI//Iw==
X-CSE-MsgGUID: ZhBR9sUZSvmXq/0tg+yZcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101231914"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Dec 2024 20:53:40 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 15 Dec 2024 20:53:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sun, 15 Dec 2024 20:53:39 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 15 Dec 2024 20:53:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ni8zU6J6xABIA5cHv5eJmkfDuocFvX2T90JBq2dp3Vqf8rAFAHGYYYS4nM7ngloq7g8EW8sA1Db8+HMRHypaj1CZIvbDirLYVEc3gcWZitNbs9PIwup9OFHkY7SCxHop6BegVldPV5e8Ltm/qVpaXV+CVuvSotDznEQRDdA2RlzH48uBUFINem0uiEzKPFs8wEGdtUPyUpqn0AnHVdhUGIZ0eb1ApW9tV4ISGKDd30OIeT0Nb6gZZIsUhto0knbmDCq/gPH+ZnV2Fdzj47Lo9mqSBBkoKgLSdmeH7pDDhd7rms9pU0hNz90mTBzdi7B4qZOe/tauTyUeIto7yaWMsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4r8Kkz59h73UYUBwJiyhC6UERl0qT7js77Y7XRSBF4=;
 b=OoDTE2khPwYmjve3Qf03L2ANb6ajQV6SQPR68/V1uVo+P8nq1JTXd+Qxf//HPaiYttWi2/J3Tb6txt8g7PPO1Q7XkFR57vRXMV2iTHv4uJPq87XoHlJseOEoXd2UqoeJChJaw4U1TzZo46fZ+TzJzSFs1xf7W8kPZmHxoP+hMnQBIFag4VW9u4nAluDumW3Nn3TvHIGISiiIxi+KzckBYxmJDAvhk+l4wdCgAhtPLoOCJBo4JTvTO67NfRC82Tcn5hcb1IpGRypVrkIcoa9NrMVn5lQ/fOrcnL9/ZlkfTjhEJh1L/tnNc/UTg0WrlAZWReo+GiLiDMOGQYEIJeDtgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by MN6PR11MB8195.namprd11.prod.outlook.com (2603:10b6:208:47f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 04:53:09 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 04:53:09 +0000
Message-ID: <2a71791c-a73a-4a3c-8573-7b80d1c39d57@intel.com>
Date: Mon, 16 Dec 2024 05:53:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/7] ice: dump ethtool stats and skb by Tx hang
 devlink health reporter
To: Jakub Kicinski <kuba@kernel.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, <jiri@resnulli.us>, "Knitter, Konrad"
	<konrad.knitter@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<wojciech.drewek@intel.com>, <mateusz.polchlopek@intel.com>,
	<joe@perches.com>, <horms@kernel.org>, <apw@canonical.com>,
	<lukas.bulwahn@gmail.com>, <dwaipayanray1@gmail.com>, Igor Bagnucki
	<igor.bagnucki@intel.com>, Pucha Himasekhar Reddy
	<himasekharx.reddy.pucha@intel.com>
References: <20241211223231.397203-1-anthony.l.nguyen@intel.com>
 <20241211223231.397203-7-anthony.l.nguyen@intel.com>
 <20241212190040.3b99b7af@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20241212190040.3b99b7af@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0001.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::8)
 To MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|MN6PR11MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: 05ded81e-7a2d-4f2b-5794-08dd1d8d896a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tnpuc2NMS1ZZZElYOFptQzlwdmdWQTZQeXZnV2JRUW94d2svU3A2OG5INFND?=
 =?utf-8?B?eWhaQUZlL21EbE4xY0doVWhZNEE0UTg3MzBmT1k5SkNDQjkxVEd1TTgzaFZO?=
 =?utf-8?B?eHhuMGN0cFhVaTgzYzl6ZXpSbmNBYnBIUWZBd1BidElXZGdyQ0NIZHE0S3lZ?=
 =?utf-8?B?RHNySGFNUUphMW9SakVHY002enhrSnJwVGlNUVB4VVIvbytJeXNLVVB0Y2JL?=
 =?utf-8?B?RmhtcUdyZEZtbjk2OGoyOUJtUEV1ckczcEZkSzVMQm0wWTNTemZmME9yMWJl?=
 =?utf-8?B?Qk8yVWhLekh2K1dHczhpSkw2RUFQbE9OU0htSjFLWmRCUmMyNnFCN3RXMDdp?=
 =?utf-8?B?cjFyQ3IrdTZJaEJGQzhjNW9aV0N2c002ZHFLdjhhSXNIUXhDOFlMbWUrRUc3?=
 =?utf-8?B?WXkrMkJLWVFrd05ydjBHNFl5K2VGVHdzK1BRMWZkRlplR2xQS2treEQzUzNN?=
 =?utf-8?B?disxYjFadFhHdjBTcGVqaXVqMXdoa1lpQnh0TitFVzA2cmNzM1BkVDVTNWVk?=
 =?utf-8?B?bjhnYmJYTndhbDJ3TDhoYUpoYkRyKzVxbzdtNzBReUNrRmVmY2IwdlFVc1Fa?=
 =?utf-8?B?M2JDT29CQmJ0L1B2WnRPdTRWeUE0OTkydU9QY2x0NkZDQTFvSGxsNFFHL1pj?=
 =?utf-8?B?enlwekh4MGFLajU0SktmQXl4TGNTVWVnV24zL3hKMVI0ZUZibTViMjhPWWpq?=
 =?utf-8?B?TEowUFo0MVg5c3ZXcnlxMFBGTlBNbEpScWxLNnVEWHRTZ3Y4aElpQjltYjRS?=
 =?utf-8?B?Q2ZhTWVJRXB5SFg5NWpHaUdNUzIrUERuZ1VTOEhWazZMQ1MzR3c1WWJiYTd6?=
 =?utf-8?B?aS9CTkZjNU5ocFFJRjJMcnZ3Tm12WkI5TEg1VmszbGorQmU4b2txVDNXdlRD?=
 =?utf-8?B?dU1MRlNtT3NSK3FrbEdsbWN2ck52T3FuQ1pwVUNuT3BTRTc2cnFLRlFKNUtC?=
 =?utf-8?B?WFNBRC84RFhmbTBXY3EySFZvcXM5aGFGMFNrV1ZHeElpcUFEd3RMbTRBK1Vi?=
 =?utf-8?B?ckxodWVSL0ZWcGRiWldMZGlTWGlCa1ZYRFNTempmbThKOGRtUWNUZnVIeFVU?=
 =?utf-8?B?a2JQbDFMb1Uxb1hLNThmZjdISXJ6NWNvMG9nM0lQTHRNSlVGNGZ4UFVneGdz?=
 =?utf-8?B?K0RFMVNYeGtEM3hPYXN5SjhSMEpRa2E1UTk4Mm92SmZBTEVUVzFra0hGejRa?=
 =?utf-8?B?Yyt5SUIwZUJGdG5wdUF2WlV5dXRkVnF6QVl5eFlEcG9iOEpBL2pQSUNscWR0?=
 =?utf-8?B?bTg0U2xnZ3owVGRSMnpmUVVQanNiVXk4R28yYjRiRUxadWZONEpUQVB1T0Ni?=
 =?utf-8?B?MDRBM0dJR2R5VVBia2JEVXkzZUlmeFE1RUFFWU9Vc29ueGpnSzlCOUZGbDhN?=
 =?utf-8?B?dTNGc1grcEJCM2U2NTYramtZMUF3M0JFeHplMjFGc3BlSis0Mmk4OG5VWlhL?=
 =?utf-8?B?WmVEMTBXWVExdkJLVmoyckJRVjVaN2Q1SmtHTFhweVV6cWE4bUhvSCs2KzhK?=
 =?utf-8?B?NldVS1JMZENrdVpCcnN5T05GbTFwK3l3ZXhKVXdrY3VBb3BkemQ0RXEvb2xT?=
 =?utf-8?B?bVYyMHhtZktUejd6VEtBUS9MSGVmZ3lLT0Rxd09TNFZQMTRocEFURzlsM3pI?=
 =?utf-8?B?N2Q2T1BEMDN1b1ltaWxKRGtWdW5sbEdQTVhXZzljRDVKR213d0ZudXVYVXA1?=
 =?utf-8?B?d0Z0R2FLMThGTDFKYmNZa0l3OUhvU1g2ZXhYNXNyek03bk5rTkxnTkczc0dQ?=
 =?utf-8?B?YjIvdHh1UkRyY0NWMlVuTFkybzEvR0JLQWZKOHRRNCtHbXVaSWNaRlBRb2J3?=
 =?utf-8?B?bnlpR3g2Ym93dGJKVGFWRHZ2N2NjYWQ4d3pmTVdFbVRWU3RHYlZLZkZOeFpX?=
 =?utf-8?Q?772a4Bmr89i5r?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmovQ0xZMFZkTkRSYTlOWldqZWVFMXJxd2xLakZPWUN5NWkrWlJ0SXRyUzZM?=
 =?utf-8?B?N0VPODNud05Qd0V1cVVjYVNuVzgyMmtXQU1HdVdWT0lURVhGeG81S050Ym9H?=
 =?utf-8?B?NzBUWVRnd3hJL2x0cytSaGV0U29vaGpKRjdha1dSYmsrei95NGxRWE9iMnJB?=
 =?utf-8?B?WUZFNjdkazNRUlZwR0Q1NGQ4SVp3VUdoMTRQWFZQOXo5YWZLemRKSlM4bGpk?=
 =?utf-8?B?QlE0QjhaQnkvTHNqbzJ4aERnWGJBNkJ2QXJ0aDYvYzFaNzhtSlZlVDZveXBJ?=
 =?utf-8?B?aGpDNmdvbDRQVk1TazNwSmtkN01wRXNEMnp1OElkTTc0MHg0ZEtYYWtyUjVU?=
 =?utf-8?B?ZTg5N2daQm9MT3JpUXJlaXJCc3JQdEo3SmtHSG5YTlp1NTUzbkcyZnJJNW5h?=
 =?utf-8?B?OVpwT0JkdUtjcnNxUERudHRwMitQMU9EWGU2QnVKQjJnb0s0TzNWRGRYWE9q?=
 =?utf-8?B?UzM3Mm81QzFHT3R3am11VjZBbkZUM0UyYnlibVRScVhoRnlCd280RE1NeDk4?=
 =?utf-8?B?VEk1cHdJRlZ3TExubCtzMzV3QXROc1kyaGd2Wm5HeGg4MlJSei9hbVI3Q2dn?=
 =?utf-8?B?RDlDSTdwbURyQjBwYVNaNDRNYUpqMnRMUWdCMnZTRU0vNmxsbis3Ulc4MXQ4?=
 =?utf-8?B?dUgwamt3T1NBY05FcERwT1J4ZnR6cGVYTnJvNmRBci9qYXYxSVFUV2l1RWlR?=
 =?utf-8?B?YzkveWpoNzBxQzdIdmlrbEhvcXovNjlraXprT005ZDRHSHEycndyaWR6Yy9Q?=
 =?utf-8?B?YlFyOWsyRWlwUDlNY0pKam5qNmFmUlJCQVpZMDFDOUtQdGVJVm9Kc0NPNWRP?=
 =?utf-8?B?aS9vSWNEOFdCb3hBV2pQczQrNERGUHBBNGpYMmdjQzdZcUtHeVF3MEVqZUl0?=
 =?utf-8?B?T0drbDZkQ21sTDd6bnZyQ2QxWExXdUJmRVJ4K1UzczE2ZEVEaTBGTGVTOTVt?=
 =?utf-8?B?M1NNMXRtSDlhZXljazJhS21HK2Q5VW52REtMNVcwaDFkbENxL0JhbTNrWERH?=
 =?utf-8?B?RlI3cmhFT0xqc1VTcGdXa0xFRDl6OGJLZjl5ZDJtUk02MmNPV2xNWXdIWGhV?=
 =?utf-8?B?dUNFTTVPTmRCbXVNMWE0QVJra09sSy8wT294SXc5Y1N1b2ZWN3RjVXQ1VUVC?=
 =?utf-8?B?eFI3eGQwNUxFbTdYS1BCNzdWTDBWNVZNekRWNnlsZlpqazQ1ZFlpNXB1cFRW?=
 =?utf-8?B?SFMyQWV2ZWtSazIxZ01ETE1SeWxpTEtoRTRIZUorQVZkUU8xQnZEY3FYK0hq?=
 =?utf-8?B?ZVlzNXEyUHY1SDN5WkorNzYvRm1pMDhDWlVsWmxLeW9MMGhDL01IUFo2UjNa?=
 =?utf-8?B?V0VUcE4xZnVVRWREb2tKNzdUNER1eHZKcktURjIxYUpIcUtmUzYvRjhEVDI0?=
 =?utf-8?B?eGJNWlBBNXRuc3hCTE1jc2ZWU2JncWh0MVN1NDdTNkVEbkoyMG1nOGF1aytT?=
 =?utf-8?B?RjRvSy9VNjdvU2tYdC8vbHdkcVd1WU9ET1VRRGNxUmpKT0U0LzJSOU9HejRT?=
 =?utf-8?B?dGZOSUEvQUlzSGpsRmJlU3ZYbDAvb3ppcUVIMEQ1SDlXelhpV1B0MkxwZjV3?=
 =?utf-8?B?ZzRTUERxcTB2MDVPNk1UUnh3czd0V0F4L09oemVFYkFjdllDV01sc3hEWWZB?=
 =?utf-8?B?OE1aRXNTOWpZL0VvNUxjNUZHa25wOTBBWkZOUGcrUFlwclhMZThXUFJncnJR?=
 =?utf-8?B?Y0xWVFN3aWNSNklTNzVhdlNxbVJUTlBaakdzWjAvbDcwM0k1M2ZtMlZYcmtM?=
 =?utf-8?B?WmZjM2o4M1FHQTk3b0Vkc3pQQmhqeHJIMTlZa2Z2ajM3WUhpU0k5U3Y5UWdF?=
 =?utf-8?B?SlVSckt0eUdLVGVHUWRxb1Jyb2dXbXVmYXZHQU1XQ042bzk0cjE3QmxZSS93?=
 =?utf-8?B?cGhyNG5MbzdQeFJUaWtvYkdDVnNBOHAyVFhkV2xIRkYvcWluRUJCT0tGZXVH?=
 =?utf-8?B?ZjYvS0JzbTh1UU8xYjJveDFTZUNhLyswbTE2TVBBaXZsMVA4ODl2SkRQQTh3?=
 =?utf-8?B?cVhmeUI0SWh6WHo3WXFKN0dRN3JVRXRSYmJJV2NzTGczU0Q1cmNRa2VvODJX?=
 =?utf-8?B?ZkpYM2ZXRFFuNWtXQSt4ZFdBNEtRR1NnaWpGYjlRaUo5WmUzTmc0NzBxbkJI?=
 =?utf-8?B?dXRSNmt3WHo0aTZGN2t4VmxaZHZJK0FEM1ErL3ViZmZZek9KOE1wdmZEdDAw?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ded81e-7a2d-4f2b-5794-08dd1d8d896a
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 04:53:09.1584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O21kDnLe7ABVTvmu93a2crkuwPI3jghFhZw51/T/WjHwFdUjMySoh6IwMNyKKQDMf9pAbAfxXVsBd5x+AWFJ9o3HIAMKkobIutAFnCu3cjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8195
X-OriginatorOrg: intel.com

On 12/13/24 04:00, Jakub Kicinski wrote:
> On Wed, 11 Dec 2024 14:32:14 -0800 Tony Nguyen wrote:
>> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>
>> Print the ethtool stats and skb diagnostic information as part of Tx hang
>> devlink health dump.
>>
>> Move the declarations of ethtool functions that devlink health uses out
>> to a new file: ice_ethtool_common.h
>>
>> To utilize our existing ethtool code in this context, convert it to
>> non-static.
> 
> This is going too far, user space is fully capable of capturing this
> data. It gets a netlink notification when health reporter flips to
> a bad state. 

It really pays to split your patches into trivial vs controversial ones.

Will it be fine to merge this series without patch 6 (and 3) then?
Patches 2, 4 and 5 are dependency for another health reporters that
Konrad did:
https://lore.kernel.org/intel-wired-lan/20241211110357.196167-1-konrad.knitter@intel.com

>I think Jiri worked on a daemon what could capture more
> data from user space ? I may be misremembering...

We would love to read more on that, then with more knowledge revisit
what to do about our needs covered by this patch.

