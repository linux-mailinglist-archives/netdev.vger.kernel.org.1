Return-Path: <netdev+bounces-139145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3202A9B064B
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 16:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93A6CB2188C
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 14:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CB113A40C;
	Fri, 25 Oct 2024 14:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fX+m5eTt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2CD1384B3;
	Fri, 25 Oct 2024 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868024; cv=fail; b=UhCLW2O5d0cOLDR/ROZ5QoCalDwWR/yXTWw5vcNmOyEpcjcdqyayrwR0oc+HKEfnXdhq2oBnv9k3BuJHk/Fqr1/7m5q1sSAehtLe/yHR9AHlDwoA2V3iw7BwW+/RwEegycXaK92Wf8pb/06oYdcS89J2uL1ln4bL5yq07Q+gUl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868024; c=relaxed/simple;
	bh=mH24FSzLSfj98tcFj53A3prTHoWPrsCqLrPJZ06ku/g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e5mJgjqCSJgYA60lzy0C5N3KARvesDZO5DyMBTdnUPXeiW5zgXhN7ycLw3B11XdM+lWyHxI61RqW31LU9Z3tL1aRJfWP9DkEk0V6M2WydHCBIE537BtRBljTw3RpFIQM5fB5ZhIR71zZJriRfmNMX/EBmc+d8JU2sXrXWdXEFns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fX+m5eTt; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729868022; x=1761404022;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mH24FSzLSfj98tcFj53A3prTHoWPrsCqLrPJZ06ku/g=;
  b=fX+m5eTtgCoVLe9omcuw0uLlw+f+JuM0s2Z5w6CHScLI+B6sm0eZ+Ajr
   gMDEfXuIEZlA3jjFmktO7jYm0OFBDE98GmWlqKxMRmH/kim+JKzsReews
   zvQIBn+NozKeofRj/uaYtVfzL95Wdge/0J3fmiOql9Ca5E+bOe46gu9k+
   q/Byv9zsR1hsp2apdGxnb5lkiYGvgkLLSZUJ77pLVqDED4zIa6MWtxBIT
   OdD1AOLAUJEjFtC+w43cwqLoxp73V1I5eFmP/GLJe3Jll5stb8uSIqsvu
   nnynl8cU5oqKCnCTQdJqNpz4ITXN7RpTk9V+loQnkqz6IOd5pdPR98Rd4
   Q==;
X-CSE-ConnectionGUID: lqvm1weySjCRb5Dfe1t8xA==
X-CSE-MsgGUID: WDTzvQggTb6vNHmbJaSl6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29758345"
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="29758345"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 07:53:38 -0700
X-CSE-ConnectionGUID: miy9gWN1TwqBHTz+mynviw==
X-CSE-MsgGUID: nulWmb9CR9edgDZzRGnNNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="80866513"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 07:53:37 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 07:53:36 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 07:53:36 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 07:53:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PlBeukqq6ElkXbZQz71q6qRvRwrH/G/04sf4nBv8Su3P4HlH/bAzk1t721hhXsa+5REGY7nxqqCd+xQ9ri5BC2nrxyLIZMZSWltGHYK24C5n/OeAXGdiK8XMZDFzQ1i/1WkGBeQ1803HUsQdMS2judbhPnjqa3CPXYYFSfhZbu3XPmD5TSK5bVh761sX/BQopmSnrJbEvdMuU0iOZ1M2VuaRvTVVw7T1tjI0PIVIC3MqDB0djXZsZu7l9/Oxd9EOH1c6X3wRP9lzB0XvLxf+TV2tpTtBoGeMiNwNV6x5qARKhQwzrjivhAQLLaRSKZp2T9L0ML2r/pAStHzaXoAlRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUqM/Pd5xJWWPkIFSer5ufrsFgxJvu1rvX0SUfiWmGA=;
 b=r3EnkOzzIqdYcNdp7Q6nfAOS/6l7875O1hlgADUXe8HvvhkHYKQkHeEa93dzK81N5AJs6yEK4sDthdf3j9v6eE5L2mx1ptLyhRhgZXXYgc8xuHRNW3BzCO0pJSEuzSNUJWMQ+OYT4lBXAWSGz48MAtPgoNlhLk5HfEfnPjy4hcZebsfm1QSLK/qef/ar6yUyRkucOp8ZgvLiFVdIHuupSWJmE5qJmUE/X2dsMTO3eG/T3itYCrT7gW6vfPjK1YFlp8QuIj/O3/sUkVWH1BzrJB/rpP5QxzaPWkpypozt2zr1VtmR/MwKfJ5OqFI8sZ2Mlfysn0Fzm+ET4PGt6ls1bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by LV8PR11MB8723.namprd11.prod.outlook.com (2603:10b6:408:1f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 14:53:33 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 14:53:33 +0000
Message-ID: <e00a0277-c298-47ba-9fdd-8f740f7490cc@intel.com>
Date: Fri, 25 Oct 2024 16:53:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] net: stmmac: Add glue layer for Sophgo SG2044 SoC
To: Inochi Amaoto <inochiama@gmail.com>
CC: Chen Wang <unicorn_wang@outlook.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Inochi Amaoto <inochiama@outlook.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
	<joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, "Richard
 Cochran" <richardcochran@gmail.com>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Yixun
 Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-riscv@lists.infradead.org>
References: <20241025011000.244350-1-inochiama@gmail.com>
 <20241025011000.244350-5-inochiama@gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20241025011000.244350-5-inochiama@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DBBPR09CA0011.eurprd09.prod.outlook.com
 (2603:10a6:10:c0::23) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|LV8PR11MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bd8751e-569f-4394-0a99-08dcf504cc2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d2lWcjF0MzNZM3Eyc21JU25GdnJkMVVBUGl3bEdNZHRodWZRV1Y3L2drODgy?=
 =?utf-8?B?TUp5dlpDUlEzZXdSRDc0bEtHSHFHdHJ0ZFh1c3JybXIzK3B6TitEL0ZwNWs0?=
 =?utf-8?B?U2svelp3MVdpcTRYKytvWDBZL1lwUXVpN1JXbDR1dXFPaWRqWWZweWxWbDI5?=
 =?utf-8?B?WGFTR0xKWFBQMGxRbnF5VVcwWWJ2QUhESzAwbW40bEhobTd1ZW1rcnlvM09a?=
 =?utf-8?B?UGEzQzZqdDNZcFI3T3VwNXhyUlZKVE1TaHk4ZUVFY2xsSS9kc0prRW1remdW?=
 =?utf-8?B?WG5UYnJYUGVEaHdQQXBBV1ZjbHNDejN1b3k1djU2M3Q0QVA2Rlk4Nyt6Q0Z4?=
 =?utf-8?B?RXJUUW5UdzRqdUxFMzNMclZobTJnZmViTXROTGFTTWhVVmwvNXI2M0tJZlpp?=
 =?utf-8?B?WkhWeGhVQ1hEcjNpZ0E5OGQ2WTZWSHN2MGZOVXBNNTBaZUJ6S2lHRTljWFpo?=
 =?utf-8?B?WGRDOVdYaGsrRFpMZm9qUXUxZW51OFcvQmFzckFCTG9sZ0F0OGhYcXdkZnVF?=
 =?utf-8?B?bmp3ZjRLOXdmdmhPWlVTRld4R0pna0haWFpoQUhhUGRGVndsQzZDVkcrYW1P?=
 =?utf-8?B?SjBnSU5BMWVzVVZDaUQyemhsUy9lSkpRL1RjUno4bnBDUWh2ZUdLU25MbnVR?=
 =?utf-8?B?SVBEWE9qTlcrMFVyeEtCZ1FzN3NIbmhVTEtGUmFUcTlOdEtkSTNJbWxGOERT?=
 =?utf-8?B?U2FTcmU4WVU2MG4zVmJBVVFaTTl6WHZycnBkMndpSG9LZVRwd0xveGV5NjEr?=
 =?utf-8?B?QWl4TFFVdlE4emxVMXAvRnNvcDM4U3RHT3Z5MzhGZEFZWEV4V1E0VU12Q2d1?=
 =?utf-8?B?QTEra1ZmQjJzWDc4WEU1bTN5OVBBQmJxU290R1Rvd3VRdFZvYmhrd3JmZEcz?=
 =?utf-8?B?d3ZQQnp0ZFJMdjd5SWZ2dzRkallweUp3SFlXTmFsc0FHRS8yV1liYnhJVVdy?=
 =?utf-8?B?MzdQWjVzUUlxeEdYaTNZcnRtNW5BWlVKTTJqQ3ozWlU4S2pzcDVKOTIwcHhS?=
 =?utf-8?B?QTUzdENhV3FkOWQwa05DZW82cllDU04wUUF5N3haaWhmbFY5R20xaUlnOFdJ?=
 =?utf-8?B?NDNtRkZEbVh6cE9Od3kvYmtDdDhueEF5T1BPczNZRWRmN3JWL21kMWtCa3ov?=
 =?utf-8?B?WnF6cUgwK1J4bGVtZDV1QVpkSGR2ZHdIZ2l1ZHgrMjdYK0M3SW9KWEdpeklJ?=
 =?utf-8?B?VVl4Misvenl6eGRYYlZCaUpwbXQvV2RQaXYxRjdERS9UbUJUOUp1UGtQYTdI?=
 =?utf-8?B?dm5QaHNqdzVxYUo4YzlJMitXYWtIMmFCNmVObTBZUGFBTzJVbTVQc3lYbEtP?=
 =?utf-8?B?S1BsWm1Sb2ZPTStaK3BjQ2R3QXkwcURzNWlDVnc2RFhTYWZqdHZBNFFLV0VN?=
 =?utf-8?B?NlFBOVg1cWdPNlZiZFZyeWFZeFJqbzVCbXJlMXlQL2k1eGtrRzBJUkNFa2dL?=
 =?utf-8?B?N0VNKzB1ellrNkJ1VUVYcUZSbXQ3WVh6c1pSQ2RkT2VqSGRML0lpVnByNnFP?=
 =?utf-8?B?MUhQU2MvRXBpQjB2eXpyeGM5ZFdjZU55VXRXNDN0bDFvVGxPVElqeEZuOFEz?=
 =?utf-8?B?S0pJdXRvdkV5MUZlRXlYaG5Yb2xwS0F2cWkweTNYV0N5cWpSdWtrNmhRMFEv?=
 =?utf-8?B?SjNSYUQ0eUx6UjIzU094ZUhjU2JiVGN1VkNYeXVDaXpGM2QzcnFIeEhqK01v?=
 =?utf-8?B?cllhbTNxQjc3MWllWWJvK1d0bVE5RGRxTExjU0tBbXNBdU1ReGN4Z09MUG1K?=
 =?utf-8?Q?u2HroA2Paacfo8pyaDMtBwXL5tVqHu5rW/8VTL/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anpjZ1Q0cEkvbUttVTNETWtFQmllSEZwWW5BRnQwRXQ5QkYzbXRtTGw1MkJM?=
 =?utf-8?B?WVZiUDFqc3lUd3JPNjEycmlSbVgwOFlvQ0xPb21keVpyd00wV05QaW5ML0JB?=
 =?utf-8?B?OXBORDlsaHg4QnVad3hjb0djRVFNSzFiZGJnVzQ0ZW4yb1VBWWMxZlhGK3dO?=
 =?utf-8?B?a0phaEtjc1VnT3VoeXAwWWFQS0xuT1Z3dG9ha3pVNUlUSDZZcEVqeHhyeW4y?=
 =?utf-8?B?clVzelRsVCthU2V4TDBxbS96Q3BlM2pqRG44eGZ5OTZiS2lsZ1BTVGFOK1Iv?=
 =?utf-8?B?UW5jWFd0Z2JHcnZ4K3EwRXhMOFVYRm5oaGszZWNJWE01Vk5hRnRQcnlZRXBv?=
 =?utf-8?B?aXBnYmJuS3UvaTNkRFJ1dzNwbXJJaHM5cHpCN3YxYzFNMVl1c3ZYbTNlTGww?=
 =?utf-8?B?eGVOS0wxVGdPYWxLeEx0RWo3eXY4SHRCU29EY1lPcWc4Q25QUlc4bldJQVdZ?=
 =?utf-8?B?MjBMN1lOU3kxYk1GNXdPc1MxdWtqNEVXeEd3QTFLcVZ4Um9aY284NnpsK0VH?=
 =?utf-8?B?UDUwelcyU3hSa0xHQ0FjY0srSFljVlM2NzM2L29RNTZtSTNTZk9wZ2RUZ295?=
 =?utf-8?B?TFRTcjBaUlFzZG1KSlZsamNnTW1xTUU2VlhJc0ZSWXUvQXdoV3UvRDVoOEQ1?=
 =?utf-8?B?eFNsOEU4VmhmbDVKUDlvOUp4OGpDaFdIL2VEYUZ4SDBCenlDOHUzdFYzMFN1?=
 =?utf-8?B?cDJydld2SVdjbWlHemFKYUVyeDU5VitwZlpCK0hYUmhna09MNzYyd0x6YU9M?=
 =?utf-8?B?V0RIaXlzcjhuWEV4T3NEUURXaisxMnNTdnRvWXFjQlh1VVNXRG9CVWVjYU1Y?=
 =?utf-8?B?QnlJOUZJSEZSV2c1akMwR3F5VEFaYzJ3STdjTWJyUExVTjZ3amwxTjZkNWoy?=
 =?utf-8?B?ZVBrR1NmUzdjU3ZwV29DNXJXM3ltYXFCWWdyMFFJM2dSNW1mdk0vRklNNEVU?=
 =?utf-8?B?bVFzcHAwQzJRc1BybjkyT2xWMGpGWUJOUnhmRzB1QUlDTm5HbGpBemV5VXR0?=
 =?utf-8?B?ZjcwcXRjdkhiQncvT1AzbVAwNHl4cy9uZHZIVU9KNEhXNmlMVVpid1AxV2tv?=
 =?utf-8?B?TDRZc2pDazhObWtiSTI2cm9JKzJ4SUwvT2FEQWVGUmpKTHdER3IzQmttaU1x?=
 =?utf-8?B?T1c2OHdPSHBHcXZVbnZ4VUxVcGJHUUlEdmlyWEUxcHFvT2dia3hmTGxWZXEw?=
 =?utf-8?B?K2xibXpOdlR0cTZGOEFxdnZzcHNxVEp0TExsQkhLTTRkWWM0c2owbnZ4V3A0?=
 =?utf-8?B?cFo1WHFmbndEK3dQczVic0FxN2dKeTYvb3RmenNNYVIvWWdSR1hSSUZINldG?=
 =?utf-8?B?dWdzTlRZR201a0dUbHY1SzNkVXhIQnA5UFdDdUVLd2NVUE9JRHVlTmpkWUpH?=
 =?utf-8?B?Rmo1OUpiamxqZnR3eFc3TXBPTXh6SnN0SDVmaFFweDBicjNSSktROXJjRHJN?=
 =?utf-8?B?ZHhIckIwTmdYK1ExWlhaYjhqNVpJMlM3SmtRN0F2ejU3Ri96MGVtVURFVzZl?=
 =?utf-8?B?SUdza0NXSnJybE5qNlFPRENaam0xT2pGMnNWaTNnbURGaWVhd05HNHZtdUtY?=
 =?utf-8?B?S0szeXExeFRWd1QwVXVtSDNKOVJCYlNZek1RRnlsTXNkL2Qra3ZZdWJDN1lD?=
 =?utf-8?B?bmpLbFN1d0Y2Wmk5MWhFK2RZdkdOVVVWaFRtQ0d3bnltQktFTXFRekdUdENW?=
 =?utf-8?B?QnpUYUdJWXEvNlp3N2I1UVQ1cGFoaEpjMFVDUjdWdlpUSVJycUhScjRodWtZ?=
 =?utf-8?B?NHpqR2pCZGVpdmdhWWs2TlBkdnNQYkxRU0gzZ1BMU1RqK0FYS3QwZlIxSElF?=
 =?utf-8?B?ZTFkN2FCd0lpRUhySWR5ZG9ibDN6dFJyaFJYRmRHZ2VTNlNpUnRjOUZINGJt?=
 =?utf-8?B?SU9aTjNNangrdUNKT3E4SzlRRDh5RjVQMm8waU53L25idENvZjN0aTAvTmdr?=
 =?utf-8?B?bEV1ZUtHUG8zSjgwOTRkdDVBeDliWk5OWGFQYko2c3RWbyt2WGdtTHBncC9a?=
 =?utf-8?B?c3ROczJWSGNTY0NOOURCMFhyTU4wM1lVak1YejdLMWR2eWxNSDlGdEliZGNM?=
 =?utf-8?B?RG1uQ3JPUC9LYy95U2h4WnVkc1dWLzJEVG51dTluMkpGQVdWRHBYKzFvNVNB?=
 =?utf-8?B?RFd5R25VSnc5MlZNdTJYdWV6enBHdnZvak5CYUduVnF2dWhZYnQwNG5wanZh?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd8751e-569f-4394-0a99-08dcf504cc2a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 14:53:33.6826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tMFBZs9ULXKP4dgYSJvD2JpKM18OaXn4DJITgBT/wQE7THVQ0AntuJGi5sih6PXfU+cpRLKKSM0hp4EpYq4OyUEQ5lnOywx/HiDsW8miIhs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8723
X-OriginatorOrg: intel.com

From: Inochi Amaoto <inochiama@gmail.com>
Date: Fri, 25 Oct 2024 09:10:00 +0800

> Adds Sophgo dwmac driver support on the Sophgo SG2044 SoC.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 ++
>  drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
>  .../ethernet/stmicro/stmmac/dwmac-sophgo.c    | 109 ++++++++++++++++++
>  3 files changed, 121 insertions(+)
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c

[...]

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
> new file mode 100644
> index 000000000000..8f37bcf86a73
> --- /dev/null
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Sophgo DWMAC platform driver
> + *
> + * Copyright (C) 2024 Inochi Amaoto <inochiama@gmail.com>
> + *

This empty line is redundant I guess?

> + */
> +
> +#include <linux/bits.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/phy.h>
> +#include <linux/regmap.h>

Here should be alphabetical order.

> +
> +#include "stmmac_platform.h"
> +
> +struct sophgo_dwmac {
> +	struct device *dev;
> +	struct clk *clk_tx;
> +};
> +
> +static void sophgo_dwmac_fix_mac_speed(void *priv, unsigned int speed, unsigned int mode)
> +{
> +	struct sophgo_dwmac *dwmac = priv;
> +	long rate;
> +	int ret;
> +
> +	rate = rgmii_clock(speed);
> +	if (ret < 0) {

Did you mean `if (rate < 0)`?

> +		dev_err(dwmac->dev, "invalid speed %u\n", speed);
> +		return;
> +	}
> +
> +	ret = clk_set_rate(dwmac->clk_tx, rate);
> +	if (ret)
> +		dev_err(dwmac->dev, "failed to set tx rate %lu\n", rate);

Don't you want to print the error code here?

		"failed to set tx rate %lu: %pe\n", rate, ERR_PTR(ret));

> +}
> +
> +static int sophgo_sg2044_dwmac_init(struct platform_device *pdev,
> +				    struct plat_stmmacenet_data *plat_dat,
> +				    struct stmmac_resources *stmmac_res)
> +{
> +	struct sophgo_dwmac *dwmac;
> +	int ret;

Unused var.

> +
> +	dwmac = devm_kzalloc(&pdev->dev, sizeof(*dwmac), GFP_KERNEL);
> +	if (!dwmac)
> +		return -ENOMEM;
> +
> +	dwmac->clk_tx = devm_clk_get_enabled(&pdev->dev, "tx");
> +	if (IS_ERR(dwmac->clk_tx))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(dwmac->clk_tx),
> +				     "failed to get tx clock\n");
> +
> +	dwmac->dev = &pdev->dev;
> +	plat_dat->bsp_priv = dwmac;
> +	plat_dat->flags |= STMMAC_FLAG_SPH_DISABLE;
> +	plat_dat->fix_mac_speed = sophgo_dwmac_fix_mac_speed;
> +	plat_dat->multicast_filter_bins = 0;
> +	plat_dat->unicast_filter_entries = 1;
> +
> +	return 0;
> +}

[...]

+ see the build bot report.

Thanks,
Olek

