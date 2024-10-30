Return-Path: <netdev+bounces-140308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76589B5E32
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 09:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA0221C21016
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 08:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FC11E1051;
	Wed, 30 Oct 2024 08:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F5RcYSQC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645691CCEC2;
	Wed, 30 Oct 2024 08:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730278084; cv=fail; b=byNAa1UsJVUpwOibvJHR3IZhvaaVKplYowG85HYPQqjAKhjSUNs2hFe9MQF62mDusPqibu4RtxyR0k+LPly2DX3id0Yn2sDihBp7MtmfI9HhahjLUXtQPYTUE6eq3kHxqP2Qg7fwBkNCxumLLqYPVBrexu3wdvxT3Pp9IpJ6xow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730278084; c=relaxed/simple;
	bh=61p1tVbtINQPBUiEfef9zh+EVvLlbqENCMJoL7GGpc0=;
	h=Subject:To:CC:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=GuvRPPk650ZtiywAQ7YwUE4dETB/e155FEkSlm2RG0+sSP90Sec30ZmxJEVvA3AoV2WFY936aPSMTgDqwGI3o1jYYNmOavgo7gx0sizKjTFjZ/ksro62Wn3XUVNcD0HKthdo7PmqPLWvfVzH7Zwz0QBDA8r5aakcqggW/N95evs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F5RcYSQC; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730278082; x=1761814082;
  h=subject:to:cc:references:from:message-id:date:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=61p1tVbtINQPBUiEfef9zh+EVvLlbqENCMJoL7GGpc0=;
  b=F5RcYSQCXK94G1KbVain4DsGwyrbDt9chQVbtOSfOkBKbkCItw0Y91sB
   HPmJIUKpRtKjnTmsBPBQ6DoY9Z5DR+PCpifpi8ko2xVT369RJVdWYmcN5
   Dw+V3IZ3S5Lia+WxflCpr9Lma0ZNYeUx8vL7P28V4h2b88nla7NjiVzIv
   D6L+v5jtus/NiSqtNNDnlCBEDUK6UyxK6iC79UxWfL4+SLwpOU4ZSGxIW
   lIOKebKwAWvqRQO+VulUmPSPfnQgZDITJbpaTlvQ8pDOL2OZBx59dRb1c
   +e6ujuqNIdLhhnGgHu2H916Ge3czh/i8T4CE984sWipGC/dHA/nMyt7QI
   Q==;
X-CSE-ConnectionGUID: /TTkq2QsQMuUvtKKTS5JKQ==
X-CSE-MsgGUID: k3iN5UKLSDWnXZjS2KIn/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="41367886"
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="41367886"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 01:48:01 -0700
X-CSE-ConnectionGUID: iaMaUnnsSL+CPSTH9Rp0GQ==
X-CSE-MsgGUID: ZAZROS/DQMugOsiYpOxbng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="105556178"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2024 01:48:01 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 30 Oct 2024 01:48:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 30 Oct 2024 01:48:00 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 01:48:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CclO1V9P2f+FfeAh/2DUdCHe4RkGjBoEpqJLBidjXDj6hCrJoCOUf4PHyX6kK5MQUcNI/NfRReB39bRXSPco8ruq0w/2hbd1BVxh2fr5gfHusByCai38YkTHpTJSsloNGOg8HEQLaobryA1Mj53v961SUGxd+ofyjj/yE4GHSl2929RkcjTBhPkJnbGlWtjcnr02pG3pUB55hmKtK2gSamWfgyJy4yKFR1eF84vcPwZZ29XWMYl599kHol3pPJTi00SFErE61iqFb3keRLbc0qU7YpQASi1wo12T2yemQQPCHixBs3CSocyGPUvdBnbZiQrLdo/ezaty3FumStJVJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sX4VmLxVQi4YI4HuqDmn1NlqXl08grTr1uWHzWeRb2A=;
 b=YtTCRhO2tekcBw3MNrVz+zmpGrO41GO6c3fXFyWj8RDoHnvSM2utNPameiFQGAEsdAwjM4BDukk2C/mKMAC+je2LjdPPPj2C54NFIiGpu27qoDzivVyEdB+7kLGMrqlCNF6nrPvUnso886cZnCSWG51Zw7OowaTkygKstkwNkT7p+PH8cMrPj4IA2h/kuhGjeKS+Xl+0YlBzRVIIpLmgCi1xSGmjNYvZsXnnH1N2QSHyCkrE+5YWWWHcHkGTbLmnNwdrm6mbqq8D+Mp7J21zzROrjL1Nsk4CW94+PdnkRzfJgQWFiYz5MXpZyz7IYv0OQbQkiJG/LUAfk+3Mh4ZhTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5949.namprd11.prod.outlook.com (2603:10b6:510:144::6)
 by IA1PR11MB6291.namprd11.prod.outlook.com (2603:10b6:208:3e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Wed, 30 Oct
 2024 08:47:53 +0000
Received: from PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861]) by PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861%5]) with mapi id 15.20.8093.025; Wed, 30 Oct 2024
 08:47:53 +0000
Subject: Re: [PATCH iwl-next v6 1/2] igc: Link IRQs to NAPI instances
To: Joe Damato <jdamato@fastly.com>, <netdev@vger.kernel.org>
CC: <jacob.e.keller@intel.com>, <kurt@linutronix.de>,
	<vinicius.gomes@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	"Przemek Kitszel" <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "moderated list:INTEL ETHERNET DRIVERS"
	<intel-wired-lan@lists.osuosl.org>, open list <linux-kernel@vger.kernel.org>
References: <20241029201218.355714-1-jdamato@fastly.com>
 <20241029201218.355714-2-jdamato@fastly.com>
From: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
Message-ID: <be60aa0f-2659-d32b-646a-ce696db4c064@intel.com>
Date: Wed, 30 Oct 2024 10:47:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20241029201218.355714-2-jdamato@fastly.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::6)
 To PH0PR11MB5949.namprd11.prod.outlook.com (2603:10b6:510:144::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5949:EE_|IA1PR11MB6291:EE_
X-MS-Office365-Filtering-Correlation-Id: 75087fd9-27c4-4134-0c14-08dcf8bf8ac9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tzh2WkZkbU1YcnNyTUNmQTZqMS9FS0VXSmdSNEdENG05dXBHUWNJM0RiV3JF?=
 =?utf-8?B?REtnRitCOWkySy95TnUxTTFUS3drblE1cU5nenBkdTJ2ZlFBTENKNkZ4N2oy?=
 =?utf-8?B?bndySkI5S1d5Und4Y0VwdkZQQWFjT2pMQTBacENDM1VmVTRRblBUSmkzMld3?=
 =?utf-8?B?ZDRUY3EzS2N5QUpGNGhYQ1pIcFdmZHpkclV1ZWZuRjNtM25oL09BampnSVJ6?=
 =?utf-8?B?OEp1NmMrM0hHK2JGa004dU5KaER1YjVrK0FlU1pyb1FNNkVPRXhPM1QrWk85?=
 =?utf-8?B?UW91bndkNFE0V21EL011QitVZktia1B2UHl1S2FUU2dIZ2dnQ3RaVUlXNCto?=
 =?utf-8?B?RzBqYWR5aVloZU1ZRnFTVkFYQ2prT0QyaGF0TDVXT2QyaHR5ZkpYWmp5NkFw?=
 =?utf-8?B?ZFpSWXdzM1JxVzNCcHI2QzlZUVhHdFozaG41aGtULzh1SC9JQ2l0bVMvYUJD?=
 =?utf-8?B?TWN0c2ZhN0hoQUo4clY5Q1gzL0lmb1BJY3FtSzR4blJlanluMjU2ZnJ3Y2ov?=
 =?utf-8?B?Nmp3blcxYmwxYnlXV3FYSnRZdFovWWZIMVlBdHRpSXM5ZWxwcUpseGVvekk5?=
 =?utf-8?B?UU96OGtWSDZkT2ZjdTJVTUJVb0hKZVFXTENRQzQ3ZW5KN3RtcGRkWjFDQ0pa?=
 =?utf-8?B?SjlUYjR3L1pxcnV0Wi91eUozcjZuWmlaOTBQUW1rR0JNUU94K3VpS09BSm1z?=
 =?utf-8?B?RUF6R1NsUlAwa21oWHJMWWhPeEROeUdLM0RqOWZtcUhyblkrYjk2WGJFcStm?=
 =?utf-8?B?QUZRakhyNGhxZjZVM2tsVEtOQ3NMOWNmZHY3V3RnMU5QUEVGOFpBUk95RWg0?=
 =?utf-8?B?Z0xneVQ5d1VIZVgrWjhUSzVTZzZPOW1CTkRMb054VlJ0ZmFCOXZSWG9hNk1H?=
 =?utf-8?B?Wk9IS3ZiTVFxa1NKeGlRUk1MVk9nMEZsVm9McTFLck95ZUFYRXN6cUNUMUts?=
 =?utf-8?B?VjVkeTRkMVV1WDRHWTEzc2lDbWo3ajVNU3V4c1IvWm53dURRSXBDVFEzUVkr?=
 =?utf-8?B?UWcreWdNTUptZEg1Wk9EQzN1UkhIWGU3RFFLSkd4VHlyaVB4TUt2bVFIMnBx?=
 =?utf-8?B?SE1EVTVOSER3dmtTOHI2NFJqZ1orNzBRZmM1cWRDMzBsWFlHbHphSGNiSG96?=
 =?utf-8?B?Z25kWEdJc0ppWTZDMk1tdDJiUG16SzYrcFBhb3ZOMEFpOGdsbjU2N2plRzVR?=
 =?utf-8?B?UXVBbWJHblErbFRUZUFSM2NDMFdCWkszcTR3dVBzM3F2MGN3ZnJRZ1ozcTJ5?=
 =?utf-8?B?eWMxcGRGOWhpQjA0cjU1UWVsMlRIRWhrSlc0STVrQU9YOUVWd0YzMExhYmtC?=
 =?utf-8?B?TVV4cG1rWmM5dWlTZDVkQVUxeU9xVzJ5eC8vV1VTaDhpUDdFaHBCUDk4b1FJ?=
 =?utf-8?B?WHRGUWJMbVVyYURpVVJ2dUZUOGhVYnBtbzhyUC9Xd1NKa0E2dDZhNTJYdHlm?=
 =?utf-8?B?UU95TnF5VlpCTjBOVWRhQmExTFplODZMdVozVkhGcXgvM3lSUThOYjg2MFow?=
 =?utf-8?B?NHVDZVNYenBQNG95NFNhU3BRQ0xwL2UxVFhlYTdSOEMyZGd4Q1llNTh2MUNt?=
 =?utf-8?B?VFpxTEJBWXpuOEFsTXBzTDl6MWJZRHNyM0Mzc3ZmN0Z1bUFJc2g5dWZScW9s?=
 =?utf-8?B?VlpuejkzcWZ3WlUxWWRmbTJuRXowcUVPQnRPTUZ0OXJoVWovY0h2VnhYR1Q3?=
 =?utf-8?B?RmxRRVVzNnRsMVNVWHNNVFFmTEFtK2g0dkVPUFRTRlRNQVcrQUF0b0RMQnoy?=
 =?utf-8?Q?Y+J6FEzENn3t9fL6f6ckCUN1jIWaCZaJ8TeyUtJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qm5iR1VrNnc3UmFkOEF3Mm1ZdkQzQkgrNjhFTzRzaTJCNU9kK3R0NExOb0E3?=
 =?utf-8?B?YmorZ2lBZTNtc3NFVTllRnpmMVFXbm80QzVJeUU5QUU3ZDd0KzhXRDQ3b25q?=
 =?utf-8?B?M2NKek50bzlQcld5ajROOVFEcGo2U3pvR0t6UHhUckV5Z2NFME9QK25sY1Nl?=
 =?utf-8?B?aUM4Qm94VDk3a1RBajNabjZ1b05lK05sazVRNVVIZTZmUW9XWEo2WG1WbWlF?=
 =?utf-8?B?OExSOVdtZkQ2bmNQVFJEYzJVdHc4T3BUL1RyVkZaYXkzK0NNU2FhelluTjZ2?=
 =?utf-8?B?VEJoZVN3VHpMaFFQUG5rd0R6U2R5amNNWDZFTnM3dy95aW1ZZTdNaTVwMUFS?=
 =?utf-8?B?QkltZmZOVnVLMnJrcTZGbUR5cHM4YjZNTTViN2EramI5QkJOa0RjUnF6czYy?=
 =?utf-8?B?aTRaeEVhbXFUQnhhQTRBTHFYOGlGMkcrMW9wbXVuSHFQN24zYVVGellscTZZ?=
 =?utf-8?B?TGdrY3BraEV2NzdGNzUvcXpmYXVTY08zd0Y5bDFnc3BtZzVmdFpCM2dFUlFQ?=
 =?utf-8?B?YkV0bWlNTjlyL2duQVhXcDJxd3RDL254RDN5TkpPdXd5M2VXSlFSR1krL3My?=
 =?utf-8?B?Tm9rQ3JUK0tpeGgvdi9hb2dRUENHWG1CY1N5Mm1oM3ppbUtXZWZoU3pwY3dG?=
 =?utf-8?B?VWd2RGFoVTM0OWpMWEl4QzRiY3M5dWdwV1BIM2t5VGdrY0Q5Y21Fdm41Qi9P?=
 =?utf-8?B?eTBVWmh6ZFRBTXRQNHRxaUpWdXlySmkxK2lvQkRxazRHcVd3K3RDeXVGS0Y4?=
 =?utf-8?B?VHZkNmQzaXpxTHplS0Y5RXZuL2sza2VhSU9mNDJOc3dsU3libVBvQ0VzTkNZ?=
 =?utf-8?B?NlRpSzVVWTQwalhTdHIvYm9FbElGUU1BeHBDU2kyRVBpSnR2QjRZS2FkVG5h?=
 =?utf-8?B?ZFhxUEpYaWVuWXRKRDFtdTAxQk9sWndPWDYwNmRza1JxbFNZQlhmVzRLYkY0?=
 =?utf-8?B?OGtUb3JLaFRJS3BSYmFVYUJiL0N4UjE3V0NuZUZmMTVYQ1BNZThvdC9CTHpF?=
 =?utf-8?B?T3lDSm1JY2VPUUpxVnczY29hUkZ3dkllYmxmQXhMN1h5T1BQT0lFbHJndnZB?=
 =?utf-8?B?WmIzS09IU0pxdDk2Ym52SFhNaTdCNmRtZFVJTmJzZmtFaldaeVNwZ2pKcHN4?=
 =?utf-8?B?bk11aU1TR3oxNWh0SlJxR1ZuMVFvaE5pOXhQUkQyK0tBQm9yeW1Pa01ybW1D?=
 =?utf-8?B?Y3BrTEtlWnMwT1huZ3BNYVMzdmJWZUl0akdtYlVkVklsZVZWRzZnMXM0WG50?=
 =?utf-8?B?bHpEMENTNExrUm5sSHFrU2VBVnFZZThycDROcUpVUW5RT3VvcDF0MHpnY0hH?=
 =?utf-8?B?Tk5Tc01xeDUvc1dnZUdhcjBLeHNMOTM3Z2lKeVZBSXhXb0U2akVmdG15WXpG?=
 =?utf-8?B?UlpjR1FvYnc0YWNONXAxUTd0RC9LRnpsVVF6MCtCclE3SDFpTy9DWmd6eEZG?=
 =?utf-8?B?a2lha3FjNU5ibEg2aldZTlpxSUhOdVBnZjg0ZzFpYjhmVGZnUndNTG9jbjhu?=
 =?utf-8?B?TWdyTHgzSlU2ZXk2UjUrbFB6bkZieUthM3JmRDRldklwS0ExUzc0U0JXWElM?=
 =?utf-8?B?d24xMDl5b282YUEwYmIyNkcxaitrcE9OVURvWlU5eEpsM1VCTWlwNGtrbm5Z?=
 =?utf-8?B?b3R2eXdrZHVqZHBucmdMOWsxZ1JaL2oybHNoQXJkQWlTWXJLS0paRm5aeWxr?=
 =?utf-8?B?bkhhZnZtVnU3czZ3TnhQWkt0T1ZSTXJGcWRYUm8zckZ1QkxHYmZkbWRwazl4?=
 =?utf-8?B?R0J1ekJEbnc3UWJvUEcyN200T3JGSGR5azlmV21JK3FQT0I0NHA0UWNzbWxR?=
 =?utf-8?B?OTJuaHRNUG81Y2Juc1ZDbkFGeEhzSVJub2pHLzBSQXJuOUFiTjZSaU4zUWNU?=
 =?utf-8?B?U0hjenpNZ1ErVzZ3UWtMQ2R3Z20xSXF3ellremxhSzJEbVhzVXNSejdTdFgz?=
 =?utf-8?B?ZlFKYnBtaGozSEhtR0lvTWM3a0pVNUlIWHZUZTZOUUtPL2hFaGNxTHByWW1w?=
 =?utf-8?B?QmxXY3ZEYWpVL2MzNzVna2FwTnZLYzlKam5pL2ZhRmozazRrRHJyV3ZUajM2?=
 =?utf-8?B?b1A1YmNuUGhMVVAxTWl3bzZDbVp3T0NNdEJHSHJUeHdYU0ZZQWJxWjZ4YVpw?=
 =?utf-8?B?OVJ4d2FFdmVYNW5RZEFES0VJU0NwUjhFNFJTRTJFbXdUVTh1YmZvYUNqR1d6?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75087fd9-27c4-4134-0c14-08dcf8bf8ac9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5949.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 08:47:53.3446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ehd+gyx3UOHy7Yo5dC9Is2h3QWdRF/AzadTQJitOwPDVbAgiUckI6bcdgwXyX7kpFxEfBDt6IRdC5xxVepghxaK483JEXNlBDH5qyHSLoq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6291
X-OriginatorOrg: intel.com



On 10/29/2024 10:12 PM, Joe Damato wrote:
> Link IRQs to NAPI instances via netdev-genl API so that users can query
> this information with netlink.
> 
> Compare the output of /proc/interrupts (noting that IRQ 128 is the
> "other" IRQ which does not appear to have a NAPI instance):
> 
> $ cat /proc/interrupts | grep enp86s0 | cut --delimiter=":" -f1
>   128
>   129
>   130
>   131
>   132
> 
> The output from netlink shows the mapping of NAPI IDs to IRQs (again
> noting that 128 is absent as it is the "other" IRQ):
> 
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                           --dump napi-get --json='{"ifindex": 2}'
> 
> [{'defer-hard-irqs': 0,
>    'gro-flush-timeout': 0,
>    'id': 8196,
>    'ifindex': 2,
>    'irq': 132},
>   {'defer-hard-irqs': 0,
>    'gro-flush-timeout': 0,
>    'id': 8195,
>    'ifindex': 2,
>    'irq': 131},
>   {'defer-hard-irqs': 0,
>    'gro-flush-timeout': 0,
>    'id': 8194,
>    'ifindex': 2,
>    'irq': 130},
>   {'defer-hard-irqs': 0,
>    'gro-flush-timeout': 0,
>    'id': 8193,
>    'ifindex': 2,
>    'irq': 129}]
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>

Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>

> ---
>   v4:
>     - Fix typo in commit message (replacing 144 with 128)
> 
>   v2:
>     - Line wrap at 80 characters
> 
>   drivers/net/ethernet/intel/igc/igc_main.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 6e70bca15db1..7964bbedb16c 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -5576,6 +5576,9 @@ static int igc_request_msix(struct igc_adapter *adapter)
>   				  q_vector);
>   		if (err)
>   			goto err_free;
> +
> +		netif_napi_set_irq(&q_vector->napi,
> +				   adapter->msix_entries[vector].vector);
>   	}
>   
>   	igc_configure_msix(adapter);
> 

