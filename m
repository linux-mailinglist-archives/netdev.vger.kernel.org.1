Return-Path: <netdev+bounces-254257-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIC9DYsNemmS2AEAu9opvQ
	(envelope-from <netdev+bounces-254257-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:22:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFABA20ED
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A4BE300DDCE
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 13:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7462352C3A;
	Wed, 28 Jan 2026 13:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="tLOCbCEp"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5161F22541C;
	Wed, 28 Jan 2026 13:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=44.246.77.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769606497; cv=fail; b=cQH1DioU1gnQn9xzEWmPXkz5ZuxtXmYjDUO3d8WP2cw/WWXRIx3BSgaXgh2OjbsC0TRXzsY9WZyxwxnyBtLCjjZlJ1idsCIxuPsd41bpqKsWhrZi1sqHjObicH9vMRiY+PgxL/zq1ZxuqVR0ggeld40gNgzPud+aLUF8rx2uC1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769606497; c=relaxed/simple;
	bh=szt89T2m8NbpmgOFaJW5Ve4d7CRAtjXXPvvGo+VUJWA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iQr1+fYOV0GnBMZyTsvBN1OHbxpxMpmfowY/VqRihcMziDk5nEJNYJX9qFn/Gr6PsL5+Xfo4euExUJRZitpvUBnU3+EupMOOrafoTnDTy7GHfRJLk3/LeinsmPJRFne6MK7A+RP61HQWAPdWSeelDw9w8vil9mayxURI9UvERGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=tLOCbCEp; arc=fail smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1769606496; x=1801142496;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=szt89T2m8NbpmgOFaJW5Ve4d7CRAtjXXPvvGo+VUJWA=;
  b=tLOCbCEpZqLg+FnrXIaCo5Hm8Xdy1dpDy3ccqO5uME4vSdcFBF7XtvmJ
   mC1txjpGvMhJUpTPwYt5sLql0agWEs1WiG09BtPv2i9zpXR8fgICyZ6wp
   iKTZmx029ogeDL4rJjAkTOck5hKajyJNRMaDditDz+AoOKdo0tC1UjtVw
   2TRZ1NYY44ehszpLkKGwcRc7g4ywVHhF2lPhKIrzMWoTHgCNAubTcyQiJ
   qPU6etMiPzr9245CPs9tM0sus+iHhqu0VIC8O0bM1E6/xLEVvfQ/tHIhn
   e+YxmGbJHdTkd1ZCPOyzwR6suImgCuBbzcwEGEzwJAQVigTJt5fhojsLH
   w==;
X-CSE-ConnectionGUID: Vp3bwJdGRYS0Yr8c8a9oHw==
X-CSE-MsgGUID: Z/9N5jwMRkKWIwP95eSJ9g==
X-IronPort-AV: E=Sophos;i="6.21,258,1763424000"; 
   d="scan'208";a="11752605"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 13:21:33 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:3054]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.40:2525] with esmtp (Farcaster)
 id 31fb914c-1c37-4541-9807-eff701564eed; Wed, 28 Jan 2026 13:21:33 +0000 (UTC)
X-Farcaster-Flow-ID: 31fb914c-1c37-4541-9807-eff701564eed
Received: from EX19EXOUWA001.ant.amazon.com (10.250.64.209) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 28 Jan 2026 13:21:33 +0000
Received: from CO1PR07CU001.outbound.protection.outlook.com (10.250.64.206) by
 EX19EXOUWA001.ant.amazon.com (10.250.64.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35
 via Frontend Transport; Wed, 28 Jan 2026 13:21:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NnEZZdhVxBEmS/wPYZyloBqmYNH781fS4PkHwf9l51ssCBpWlm01eiXrD14NEltQ7e0dpLVZ4rjfq3RNmbrHwsnG1vBe8wHPPUe93UxZnE35d3JgZeZqqze53GJUSOcx+Zv7Mno6+MJ5D+AHjyZlLtCsC0A8ckBdTqVeOVO+UWP2c7Lo806XxFJg3pOfSOATjz0D5sueNd+48n/YsVTlaJY9dbD3cd5xBytdLq5sTZt6rG8q2tKS+Fh2jctVLPO72sdVCnhIO/+M7zya3fKMQt3flWcS8IMlR7m+GVPevx0OHgk1G6wm91yKx0YmCNBfJGFqrPHbn7U8ktkBnyccFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szt89T2m8NbpmgOFaJW5Ve4d7CRAtjXXPvvGo+VUJWA=;
 b=EEEDoHVpdl7rcWLWHJDxI+0Hqp23z7TYZZKvJsNzorGexWEguxekxfa0JkqMUMIc6CiRcsPmsoh3tEf3GVl6/9Vekkgh1NkhZUllggO06ACfd++VwGY0okKmgOqmmJ/3HazNT8PJSU/CnEJdso+/GZvQyOJwTuD0d6tYY8VSUwwv2kSK7SjJ7bG30KjhJrDjSK/jesCm8oRGbeQIpFsIju3EIBuHmT/mzgLiKpz+KpxcrNkIHHrs6sozPuPG5zl3HH3MonGdkG2BavSHMue+BCgyPktO7nSjrrv4VCTK0Z9zDmBHYVIf8lw1AnZdOMhnEuq1k8jZ5BpZioiFjbgx6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from MN2PR18MB3685.namprd18.prod.outlook.com (2603:10b6:208:26b::7)
 by PH0PR18MB4476.namprd18.prod.outlook.com (2603:10b6:510:e7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 13:21:28 +0000
Received: from MN2PR18MB3685.namprd18.prod.outlook.com
 ([fe80::b80a:2a8b:75a9:7e85]) by MN2PR18MB3685.namprd18.prod.outlook.com
 ([fe80::b80a:2a8b:75a9:7e85%6]) with mapi id 15.20.9564.007; Wed, 28 Jan 2026
 13:21:27 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: "mmyangfl@gmail.com" <mmyangfl@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "mmyangfl@gmail.com" <mmyangfl@gmail.com>, "Allen, Neil"
	<shayagr@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>, "Bshara,
 Saeed" <saeedb@amazon.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "hawk@kernel.org"
	<hawk@kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>, "Bernstein, Amit" <amitbern@amazon.com>,
	"horms@kernel.org" <horms@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "leitao@debian.org" <leitao@debian.org>, "Enju, Kohei"
	<enjuk@amazon.co.jp>, "ahmed.zaki@intel.com" <ahmed.zaki@intel.com>,
	"mingo@kernel.org" <mingo@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [RFC net-next] net: ena: Use u64_stats_t with u64_stats_sync
 properly
Thread-Topic: [RFC net-next] net: ena: Use u64_stats_t with u64_stats_sync
 properly
Thread-Index: AQHcj1fWH27CYFZt50m4r6LqZqeegLVntNqA
Date: Wed, 28 Jan 2026 13:21:27 +0000
Message-ID: <76564BD3-B685-45EC-B53F-06534512EBC7@amazon.com>
References: <FFDD6CD9-5100-49E6-B3B8-F38099043E87@amazon.com>
In-Reply-To: <FFDD6CD9-5100-49E6-B3B8-F38099043E87@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels: MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SetDate=2026-01-27T06:33:58Z;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ContentBits=0;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Tag=50,
 3, 0,
 1;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Name=Confidential;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ActionId=1a5dec78-16bc-4394-9635-0d984b828aff;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SiteId=5280104a-472d-4538-9ccf-1e1d0efe8b1b;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR18MB3685:EE_|PH0PR18MB4476:EE_
x-ms-office365-filtering-correlation-id: ab904f3e-63f6-4c6f-65cc-08de5e7024b8
x-ld-processed: 5280104a-472d-4538-9ccf-1e1d0efe8b1b,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?OVppdDIrQVpMaVY3eHI0WFpaZVk0RVFWbGZFaFVRRUVnQUZNNnJmSEZRS2dD?=
 =?utf-8?B?VjRTaVJjUkVqZmwyOW5WaTM3Ym1kM1pERktXWVBuTjdhQVEybFNKUVh3N0dr?=
 =?utf-8?B?amcwWk1HSitOYW9KQ0pqbHhITk1RQXpLekNYYzFOOUlVU0d3LzIycUp3VEh0?=
 =?utf-8?B?RGVJQ1VHVU1YLzFzTmdHRG1ib3Q1N1dXWTZhVXNBSkdDVExXNE1RSThITkNk?=
 =?utf-8?B?LytNb1VKaUppUjQrbjhKNFBvWGVCbFR0bExmeENFRFRmbUdMemhGcHZhdTF1?=
 =?utf-8?B?c25jbjN6bGF1eFY5U1V6Tm5vaGtVMGlCRFlGT2ExTFk5c0N0bE1nUmJFMXZQ?=
 =?utf-8?B?R3A3ak9CUkszaC84ZW5qVThteXhrYVlwUm0rbmc1SUkrdEV0V0hsTjRtaFMw?=
 =?utf-8?B?OTdESmVqdkdxWk90ZnA4RkIza2t4SU9UOGtEOHBGcmpZNVRmeW1JQ2Y2R1g1?=
 =?utf-8?B?QWZjaHFwNEkyRWF4MmZsay9ZTjAzN1lyTS9IWFVKTW9nZ2V1aitZb3RvWFVU?=
 =?utf-8?B?cEFWUWcyK1Fxb0RZU05mZWNJc2hTdnlEd20yT2FnZ093SzREVFIvK05Pazgw?=
 =?utf-8?B?Mi90QUM4bGdlelZMS05jR1ZpcHlUa1ZuejMvRGxhWk1hL0twWnRWT1h5QlZH?=
 =?utf-8?B?bEtYWm9JdStBYW5zdm9yY3AzWXRreXNobkFtKzRRZDZOWUl0M0o4cFNsZGw3?=
 =?utf-8?B?K0xyNEZ0c0F5NmVvZHFjWWhzRXhQNXRxZFVwcWNRVW1jaTVnU01XRkMxMTlE?=
 =?utf-8?B?dHZmL3BTOU1KVUJCODR1NTE3Tk9DZ25mclY2UGV1K1ZUK0lGWXJYMnRoMGc5?=
 =?utf-8?B?dzBPekF1cUY3KzVWOVhsd2hJdGVUOSs1N0VkeE5sdVY2YmJ5NllzblExRHVo?=
 =?utf-8?B?VWNsUjN6aTkxNHdwY3dkeXkxMjI2QUFneFlCR2lmRUtUVjFid1RNMnIxM1Bp?=
 =?utf-8?B?NFBoaTByMXQ4UEN6VEpXV0xZY2dZbG9QOXViVytDUVA2OHNCUVVGTWVMbmJF?=
 =?utf-8?B?T0pqYnNJWU5oY3QrQmZyTmhpQjA1QzV6ZmRUcmVMWVpSb2IybUR3bXVWSGRZ?=
 =?utf-8?B?V1RCWkd1NkNpYUpIT05OcDJLUzV3RlltUkh4SGpsNmttL0RtZTRUeUc3bHhI?=
 =?utf-8?B?Q1RuWU1RVU1WNjNpVkFPaWVPZ1dycEdubTNjUjhhYWRWTUJIUlhVbllPRlMr?=
 =?utf-8?B?eW84d0t5ajNzdGNQZVhMSTdubnBJblN6Z3ZkNzY5TThFOWZ2VGsxaDdFY3dI?=
 =?utf-8?B?cHhoVGVjRlpXWVJaRnl5b2JWZnN4N1Bybk50THVpVW52Z1pwR0ZRNlZpQWhM?=
 =?utf-8?B?THJiS2cxZWpKRW5hK3R3OFZINDZBbzVpdXlUWDFjbE9TL0xHN1oycStIRytZ?=
 =?utf-8?B?TCt4M25zeVhCenl0V0Vxa3RRQkc0aUU0dFlRVVFvTTg4a0pOUmRpWWFpZ3RH?=
 =?utf-8?B?amZUTWRReEQzdkJCcGFhU3FhZ3Q4UFVVeUhiRjdKbEhYV3dHNlhnS05KaDZ4?=
 =?utf-8?B?Y2RZMU44emx4WlNDMTRVNFlwckZienYzOCtSbDIweGN6M1NvcHVwZlk0c3hY?=
 =?utf-8?B?M0RvVjI2VWtJVTAvVnh6T2tZaW5JOE93bTR5OUplZVJESWJvdDF4M3lVM0Zr?=
 =?utf-8?B?ZVdFeXkzZ3hFM0taT1FIRkNkMWVNMFZjYzVjRVlXcXg4OGMzbTRIK0RpaHpR?=
 =?utf-8?B?MUdQRDUwSjh4Mk9lL3RPRVVKaGx3TUhlVStMUE9mUDFmRUxycHZzeGFld3Ry?=
 =?utf-8?B?SUh6dzZ6dUt5elRDb2o0NlFGRUl0S1piTktCK2xma0t1MUFSdlNuZC9Yblhl?=
 =?utf-8?B?ZVFvUFIvbi9yZWxkY1BVQU1SSkV3MWFNVjNRNGZsMzVUanlCZWtRejZSQTJa?=
 =?utf-8?B?d1BMNEFVQ1dEU3M0WW5XR0NhOVBpblluN1pFdFJpck9WSEkwZHJLTElHZTA5?=
 =?utf-8?B?VE5hRGRKTGZTakpDQWhWZGRKTE5NeTdUcHAyL1g5SURSQ2xnV2d4ektnekt5?=
 =?utf-8?B?SVA2bk5qRGlSK3l6WTVjSk1KT0dSMFdZWmZtQjJ5YitKcVdEVGk0a0tGY0R4?=
 =?utf-8?B?cDNBMEl0ZFlJb1J1VkdFNVo5YXpNWFBodGxsV0J2VitVeU96WFJpMk9pVVMz?=
 =?utf-8?B?VVlodVBKV1U2TVJudXVnYUF1RUVFUnNsL2w3Wjl3eDY3VnZtZ3E3K1Y4WUJz?=
 =?utf-8?Q?8MTAelRSs7GHCdkWzKRNsuk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR18MB3685.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QndXaGR1eGJYaUNaaDlpbUlDMVJBNER5TVVmU212aDY4d09XeU14Wm1BdzNL?=
 =?utf-8?B?SHRkSnhweENWeEtwN2ZIRWk2aGZUTlQ3ZGdWOXVHU2JiL25lZzUwOTI4R0RP?=
 =?utf-8?B?QmJzM1NsazdBZnlIYTRoSzdQTklyenpRK3JmYUZyMlIrUi9TVlpiYS9Wc1Ra?=
 =?utf-8?B?ZCtUa0o2blR4MUNOcVNWMXFPemQwcVRIM0dHUWhqSmpsTkJyMFlLb2xGTzc1?=
 =?utf-8?B?eTFMamoreWdnWGZTK0N0U0FSTExnQVNpVDYxbGdoUUllNk4zMTIybm1CYXRK?=
 =?utf-8?B?L3BSR3o5L0FDcmdieUdjMDRtWnNwd3lvMkVidndPVnR6YXBaU011bFoyVHdm?=
 =?utf-8?B?YXFRZlo3VkhsQnd2RDBnaTVPV2lYZ3BiNUdqRDZVbGNKc3ZWTkl0S2FQUElB?=
 =?utf-8?B?Ynk1THZ0STMyMlArOC9rODJscjVpSTIrQU9QN1RjQXVPRHdvbW4xamJMc3Uy?=
 =?utf-8?B?MjF2UE92ZUt0Tlp0MmdYbUxPV2tvVWhPcjZ0VTY1MDJobDF1WEN6aTFkVlpo?=
 =?utf-8?B?TkQvSmFHRGxmSU14Nk9YTmR6MUEreDBhL2hiQ3c4dElCZlJWZUlFcW9KcVVD?=
 =?utf-8?B?ZWZVOGtwZWxxMUhab0c2QjhZRG9DalFkSWlncXJRcDcrREZaRDAzZmlCSUwv?=
 =?utf-8?B?ZUc2VzVjbVVuRnhmRnU2bzZ0RWdXQ21tRjVZOFltbUNCN3EyNXhSUVcwT2N4?=
 =?utf-8?B?L0VTRWVYK3BtZTJ2Snl0OFN5cERxcUhQWUs2R0oyYkJsTG9kVHp4S3ZBRFJX?=
 =?utf-8?B?V0ZUN01OckJMNHJZMllXbzNha3UyaXBHNVFhbHROQ2FvTkM1R3JsamlTOXV1?=
 =?utf-8?B?ZHJRc3JmeFQwRHQvUWI3cVVYQmd3dEUrWVEzSTl6R0x6L1FtSnBjU0F5ZmI5?=
 =?utf-8?B?eXM5UFJmNlRaQVp0OVdDUGNmZW1sbGRRS2k4K3J1S2xMMWh6RzBqODA5MUxo?=
 =?utf-8?B?VTdmaVV6M0VVemZXbFR4UWtzT0ZQSUtaTkU5NURLQmtvbGprZ3BwN294ajNV?=
 =?utf-8?B?bUFySXJKcWY5MGtuSytPWHZjU1BBbHg4T3Z5T0MzTlYwUlh6akFXelVtY3VZ?=
 =?utf-8?B?ZnRCNlFBNytlbnp1WDgrSUxsMVFaVi9uTXZOaHNGMWxwalB5azJzV2VvcTdE?=
 =?utf-8?B?L2VIdzUrWXdiQU5pdVdFWFAvNEpXcU1MdVZqNVlwRTBFMXJ2TDJ0dVhmS0tx?=
 =?utf-8?B?cGkwbGtZeGU3dFE3cFRiYzFmUXBEYnp5aDhOZ1BvUjJhdVZOazFyTStsckVu?=
 =?utf-8?B?ZWxHTGJ4eG93QllEVjgyNkIzS1dzbzRMajVmeXFhS05xd05JMThVMXNSZEJs?=
 =?utf-8?B?bFc3ZW5hOG5nTTdBck9wQ3djbjNZYnEwYS9xRklwS0RKcGdGRXBYSHBPZVp2?=
 =?utf-8?B?ZDlZcnIxYXJadERnYmhBaThCdmcxeURBUFRDeXgrRCtSV055MldTTjMvcC9K?=
 =?utf-8?B?Nm0rM0twa3JOQjVoUVc4Y0UyRlFFMzBwYXo2dmh2OFFKMU8rc3VZaEc3QkU5?=
 =?utf-8?B?aWloc2FDWDZIUVJiSzh2cTM4U24raE9Ldzh5UXlVcGhsdVZoSXJtSWRUSUkv?=
 =?utf-8?B?VkdUTU9IQXozaFljN2ozd2ladFJ6M1hTRk5TcE56NmNuNmZFanpSVHFkOG1K?=
 =?utf-8?B?VEw5K2VIZmdGMUg3WThlVXBwODhLVjVqU2dPcmpvTVhpZTJ5Z01iazYxVFRR?=
 =?utf-8?B?Z3JCVmxMWE51R00vS2FRcmNETms2NVRtc2JBbEl1YThSajVuWjZhcTdHaUp0?=
 =?utf-8?B?eHVWUm9sMmNCbmE1YnhxaUV3YnUra0RvRkVNRk1Kb2l6QlI0cnBtU3VHemJL?=
 =?utf-8?B?cUQwVktnS1o2ZDZ6NFVET3FCZzlRSFMvSkZjV0JaQ2ROSXFBNE1KQ01icC9R?=
 =?utf-8?B?NU5MOGJGcXhvbGQwWXNMZjd0T0xJV2o0TXRQb2RqaVpNTVN2SjlEeTdmNUQ1?=
 =?utf-8?B?V3lYMlZKYVo4V3FQNTYxOUUwMjUvNmtBQTYwdEZWaFJJU2VhbmZtMzRwc2xP?=
 =?utf-8?B?a1ljL25CYldFblQ5bDlBMkxYSi90TjVNSUM3NnQ1dTJraDlaRmY4MlM2TlFU?=
 =?utf-8?B?RVlFT0hvTHR3M25JcHY1YVVqVGpZZ0tJcjBPb2ZYUHBLRVRwL1BtOWhMSnRR?=
 =?utf-8?B?OWdnU0xXK002QklwcjJ6REVreTlya0UzQXRSK1RXa21yMm82OFpYYUxxWEtY?=
 =?utf-8?B?SmpPT21Rb2xFQ0Q1a1YrMEp6aml1YjUwNEl6WkhQcE9zbDh1K3VkVThLYWxD?=
 =?utf-8?B?NlVPV0dnV3BnZ0VrdEx3ckwwTEFTMXFldE9zSkw4dEMxdlpKYlRwWXZSU0Fa?=
 =?utf-8?B?R0s3d244QzBUVE5SNVpFZ1hrZTJsWlFTMko2Q1ZJVjhqcE5XT2UyUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72BACFB127AA51498B64849A4D115424@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR18MB3685.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab904f3e-63f6-4c6f-65cc-08de5e7024b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 13:21:27.8483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jvAlex3L5PQWY35hXRhSxZfowTDOI2glPH9PWIC/4/Sq1OZWT49UquNBWGGQQ7PMrhVGvrFF+O2r15LeqCaXgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4476
X-OriginatorOrg: amazon.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.56 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254257-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[amazon.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[darinzon@amazon.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,amazon.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,fomichev.me,debian.org,amazon.co.jp,intel.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 8CFABA20ED
X-Rspamd-Action: no action

PiBIaSBEYXZpZCwNCj4gDQo+IA0KPiBUaGFuayB5b3UgZm9yIHN1Ym1pdHRpbmcgdGhlIHBhdGNo
Lg0KPiANCj4gDQo+ID4gT24gNjRiaXQgYXJjaGVzLCBzdHJ1Y3QgdTY0X3N0YXRzX3N5bmMgaXMg
ZW1wdHkgYW5kIHByb3ZpZGVzIG5vIGhlbHANCj4gPiBhZ2FpbnN0IGxvYWQvc3RvcmUgdGVhcmlu
Zy4gQ29udmVydCB0byB1NjRfc3RhdHNfdCB0byBlbnN1cmUgYXRvbWljDQo+ID4gb3BlcmF0aW9u
cy4NCj4gPiANCj4gDQo+IA0KPiBXZSB3b3VsZCBsaWtlIHRvIHJ1biBzb21lIHF1aWNrIHBlcmZv
cm1hbmNlIHRlc3RzIGludGVybmFsbHkgYmVmb3JlIHNpZ25pbmcgb2ZmLg0KPiANCg0KV2UgaGF2
ZSBjb25kdWN0ZWQgaW5pdGlhbCBpbnRlcm5hbCBwZXJmb3JtYW5jZSB0ZXN0aW5nIGFuZCBvYnNl
cnZlZCBubyBtZWFzdXJhYmxlIGltcGFjdCBmcm9tDQp0aGUgcHJvcG9zZWQgY2hhbmdlcyB0byB0
aGUgZHJpdmVyIHN0YXRpc3RpY3MuDQoNCj4gPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBZYW5nIDxt
bXlhbmdmbEBnbWFpbC5jb20gPG1haWx0bzptbXlhbmdmbEBnbWFpbC5jb20+Pg0KPiA+IC0tLQ0K
PiA+IFJGQyBDb21tZW50Og0KPiA+IA0KPiA+IFRoZSB3cml0ZSBzaWRlIG9mIHU2NF9zdGF0cyBz
aG91bGQgZW5zdXJlIG11dHVhbCBleGNsdXNpb24sIGhvd2V2ZXIgSSBjb3VsZG4ndA0KPiA+IGZp
bmQgdGhlIHN5bmNocm9uaXphdGlvbiBtZWNoYW5pc20gaW4gdXNlIChmb3IgZXhhbXBsZSwgZW5h
X3VwIC8gZW5hX2lvX3BvbGwgLw0KPiA+IGVuYV9zdGFydF94bWl0KS4gU2hvdWxkIHRoaXMgYmUg
Y29uc2lkZXJlZCBhbiBpc3N1ZT8NCj4gDQo+IA0KPiBXZSByZXZpZXdlZCBvdGhlciBkcml2ZXJz
IGFuZCBpdCBsb29rcyBsaWtlIG5vbmUgYWRkIGV4dHJhIHN5bmNocm9uaXphdGlvbiBvbiB0aGUg
d3JpdGUgc2lkZS4NCj4gQWRkaW5nIGV4dHJhIHN5bmNocm9uaXphdGlvbiB3b3VsZCBkZWdyYWRl
IGRhdGFwYXRoIHBlcmZvcm1hbmNlIHRvIGZpeCBleHRyZW1lbHkgcmFyZSBtaXNzZWQgY291bnRz
Lg0KPiANCj4gDQo+IFlvdSd2ZSBzdWJtaXR0ZWQgc2ltaWxhciBwYXRjaGVzIGZvciBvdGhlciBk
cml2ZXJzIGJ1dCBvbmx5IGNvbW1lbnRlZCBvbiB3cml0ZS1zaWRlDQo+IHN5bmNocm9uaXphdGlv
biBmb3IgRU5BLiBJcyB0aGVyZSBzb21ldGhpbmcgc3BlY2lmaWMgdG8gRU5BIHRoYXQgZGlmZmVy
cyBmcm9tIG90aGVyIGRyaXZlcnM/DQoNCldlJ3JlIHN0aWxsIHdhaXRpbmcgZm9yIHlvdXIgcmVz
cG9uc2UgdG8gb3VyIHByZXZpb3VzIHF1ZXN0aW9uOiBZb3UndmUgc3VibWl0dGVkIHNpbWlsYXIg
cGF0Y2hlcw0KZm9yIG90aGVyIGRyaXZlcnMgYnV0IG9ubHkgY29tbWVudGVkIG9uIHdyaXRlLXNp
ZGUgc3luY2hyb25pemF0aW9uIGZvciBFTkEuDQpJcyB0aGVyZSBzb21ldGhpbmcgc3BlY2lmaWMg
dG8gRU5BIHRoYXQgZGlmZmVycyBmcm9tIG90aGVyIGRyaXZlcnM/DQoNCj4gPiBAQCAtNDQwLDQy
ICs0NDAsNDIgQEAgc3RydWN0IGVuYV9hZG1pbl9lbmlfc3RhdHMgew0KPiA+ICAJLyogVGhlIG51
bWJlciBvZiBwYWNrZXRzIHNoYXBlZCBkdWUgdG8gaW5ib3VuZCBhZ2dyZWdhdGUgQlcNCj4gPiAg
CSAqIGFsbG93YW5jZSBiZWluZyBleGNlZWRlZA0KPiA+ICAJICovDQo+ID4gLQl1NjQgYndfaW5f
YWxsb3dhbmNlX2V4Y2VlZGVkOw0KPiA+ICsJdTY0X3N0YXRzX3QgYndfaW5fYWxsb3dhbmNlX2V4
Y2VlZGVkOw0KPiA+ICANCj4gPiAgCS8qIFRoZSBudW1iZXIgb2YgcGFja2V0cyBzaGFwZWQgZHVl
IHRvIG91dGJvdW5kIGFnZ3JlZ2F0ZSBCVw0KPiA+ICAJICogYWxsb3dhbmNlIGJlaW5nIGV4Y2Vl
ZGVkDQo+ID4gIAkgKi8NCj4gPiAtCXU2NCBid19vdXRfYWxsb3dhbmNlX2V4Y2VlZGVkOw0KPiA+
ICsJdTY0X3N0YXRzX3QgYndfb3V0X2FsbG93YW5jZV9leGNlZWRlZDsNCj4gPiAgDQo+ID4gIAkv
KiBUaGUgbnVtYmVyIG9mIHBhY2tldHMgc2hhcGVkIGR1ZSB0byBQUFMgYWxsb3dhbmNlIGJlaW5n
IGV4Y2VlZGVkICovDQo+ID4gLQl1NjQgcHBzX2FsbG93YW5jZV9leGNlZWRlZDsNCj4gPiArCXU2
NF9zdGF0c190IHBwc19hbGxvd2FuY2VfZXhjZWVkZWQ7DQo+ID4gIA0KPiA+ICAJLyogVGhlIG51
bWJlciBvZiBwYWNrZXRzIHNoYXBlZCBkdWUgdG8gY29ubmVjdGlvbiB0cmFja2luZw0KPiA+ICAJ
ICogYWxsb3dhbmNlIGJlaW5nIGV4Y2VlZGVkIGFuZCBsZWFkaW5nIHRvIGZhaWx1cmUgaW4gZXN0
YWJsaXNobWVudA0KPiA+ICAJICogb2YgbmV3IGNvbm5lY3Rpb25zDQo+ID4gIAkgKi8NCj4gPiAt
CXU2NCBjb25udHJhY2tfYWxsb3dhbmNlX2V4Y2VlZGVkOw0KPiA+ICsJdTY0X3N0YXRzX3QgY29u
bnRyYWNrX2FsbG93YW5jZV9leGNlZWRlZDsNCj4gPiAgDQo+ID4gIAkvKiBUaGUgbnVtYmVyIG9m
IHBhY2tldHMgc2hhcGVkIGR1ZSB0byBsaW5rbG9jYWwgcGFja2V0IHJhdGUNCj4gPiAgCSAqIGFs
bG93YW5jZSBiZWluZyBleGNlZWRlZA0KPiA+ICAJICovDQo+ID4gLQl1NjQgbGlua2xvY2FsX2Fs
bG93YW5jZV9leGNlZWRlZDsNCj4gPiArCXU2NF9zdGF0c190IGxpbmtsb2NhbF9hbGxvd2FuY2Vf
ZXhjZWVkZWQ7DQo+ID4gIH07DQoNClJlZ2FyZGluZyB0aGUgbW9kaWZpY2F0aW9ucyB0byBlbmFf
YWRtaW5fZGVmcy5oOiB0aGVzZSBzdHJ1Y3R1cmVzIGRlZmluZSB0aGUgaGFyZHdhcmUtc29mdHdh
cmUNCmludGVyZmFjZSBiZXR3ZWVuIHRoZSBob3N0IGRyaXZlciBhbmQgdGhlIEVOQSBkZXZpY2Uu
DQpUaGUgZmllbGRzIGFyZSBzcGVjaWZpZWQgYXMgbmF0aXZlIHU2NCB0eXBlcyB0byBlbnN1cmUg
Y29uc2lzdGVudCBpbnRlcnByZXRhdGlvbiBiZXR3ZWVuIHRoZSBkcml2ZXINCmFuZCBkZXZpY2Ug
YWNyb3NzIGRpZmZlcmVudCBhcmNoaXRlY3R1cmVzLg0KV2UncmUgY29uY2VybmVkIHRoYXQgY29u
dmVydGluZyB0aGVzZSBpbnRlcmZhY2UgZGVmaW5pdGlvbnMgdG8gdTY0X3N0YXRzX3QgY291bGQg
cG90ZW50aWFsbHkNCmFmZmVjdCB0aGUgc3RydWN0dXJlIGxheW91dCBvciBpbnRyb2R1Y2Ugc3Vi
dGxlIGNvbXBhdGliaWxpdHkgaXNzdWVzIHdpdGggdGhlIGRldmljZS4NClNpbmNlIHRoZXNlIGRl
ZmluaXRpb25zIHJlcHJlc2VudCBhIGNvbnRyYWN0IHdpdGggdGhlIGhhcmR3YXJlLCB3ZSdkIHBy
ZWZlciB0byBrZWVwIHRoZW0NCnVuY2hhbmdlZCB3aGlsZSBhY2NlcHRpbmcgdGhlIGRyaXZlci1p
bnRlcm5hbCBzdGF0aXN0aWNzIGNoYW5nZXMuDQoNCldvdWxkIHlvdSBiZSB3aWxsaW5nIHRvIHNw
bGl0IHRoZSBwYXRjaCB0byBleGNsdWRlIHRoZSBlbmFfYWRtaW5fZGVmcy5oIGNoYW5nZXMgYW5k
IGFueQ0KY29kZSB0aGF0IHRvdWNoZXMgdGhlc2UgaGFyZHdhcmUgaW50ZXJmYWNlIGZpZWxkcz8N
Cg0K

