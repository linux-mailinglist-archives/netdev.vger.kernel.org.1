Return-Path: <netdev+bounces-188449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DA5AACD97
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 20:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7895502B39
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 18:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6CE2868B4;
	Tue,  6 May 2025 18:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jzu5lOt0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC12E2853E5
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 18:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746557872; cv=fail; b=MhyEiXEpyiwmdNuvKyOwYb9yR+m5ntL28VmaOZRaz4TFG87ZS1pgIMW4gg9L0xP4z6TZzaHb0Le/rZQB3P75uQny8sPsneu7miFtFSxyh1R83373U4SJovTi6biSLJ0el9rQZoyFqrRMwGkeaVtYDWyh/+r17SFvOolLfWhMyII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746557872; c=relaxed/simple;
	bh=suZi2qBzMXa/4CRnl2djlY962CJg6LBS9IWcQmCItbk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q4uXJXy84xlAYdaExKUZ15fU8uYfmivwlZu5CNORZiUIbTVkEummFrGSCwtme44k4fdGJ5K0NVWYIoXiR6GpcsQqbN7Zs0pcIXIkhiBHk6jiqGwdv4sMcJOihroYlHlSlDJN+hmvOLQaOifo7LC+W9jhiJwBsqcLCQFw/nAD+i8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jzu5lOt0; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746557871; x=1778093871;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=suZi2qBzMXa/4CRnl2djlY962CJg6LBS9IWcQmCItbk=;
  b=Jzu5lOt094hVU4kY7MIFFRfzn+NX+3Bmx/hVxOj7mhanCZ0LOcAITdnf
   Hq3FAKxnKnHZkssc+2ODzztMFfRB9n4YG9/6yukTnnUZq2F57GKCZqrgW
   xTMA+Luzu6n2WqliH84wlDk3QwI9y0XKRpZZAgm3f/uzCsH1eetow9pAy
   04CbEPMXnUdfdcnfWeByrOv3pcwwIOkpqf5a/6yEYr4fdVE4x1cG6soI4
   toy0/xW8D9YKVU8J0dua7xxGFJLVlQslGtjFGhqUaj6gIc18yu/RySBbf
   Y7A8UmFqawCUioFnptR7SCk045JjjCCQQiQjxCwePXjz96S7suflV6pbF
   w==;
X-CSE-ConnectionGUID: wIQ9ydyDQduFWAtmbWK7Sw==
X-CSE-MsgGUID: bMgWkB3tSM2wf9e7hQLNpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="48332833"
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="48332833"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 11:57:51 -0700
X-CSE-ConnectionGUID: yYTrsz4cRHiaM1Gl1w7J6Q==
X-CSE-MsgGUID: SMYdyYWDQoi4k/wpEMto5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="140668770"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 11:57:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 11:57:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 6 May 2025 11:57:50 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 6 May 2025 11:57:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGr0g9PBcmqKg4LmxJwVuRAqVorsoJsl3aEDbk4APeathP0rQMSjh5Kl+GvzSa2+YGeMATI8GQ4BtBume6WweFxm41FqgUAXJKB6swjqIPb5UqoSFAqijHIyutmJ2c49kVAarsn8ieh1PhRZk5iBeBvfnRjLX/rLpxrsMgp8wx4S7ck6TQapbGX2dnd5XMRh7mFUL7qbPV4dR0wakwnDOLRI5eXnUES8O8w1lG96LDxltHFncMN2/RcuO5zhIRrGmLrkQkGkb507gqVpBlJtwxKb5k85cWrKU7Gyw9s2QeQdSd+Zej4CkuHkdMiLB6h2ZKHK6QaFz0sW6OigdwT2iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKnOIPUjnNxzbjaHPKQ1W06PjLJqQIkBpMZD4F6kznc=;
 b=GwRtY/aDRamPQBPx1aPAeWLi6pMssIRImzKr1esLG7T6dDiC8hr3R4KpTYFniMq08Z026/5lZTx7bqK/IwYoQ3//BpYAupta7oZ9OiYM3Brkj4avQm2X5H7QJZ8SMOxwny3sFsa2hipcadjiLzEAm/ZTp8Mp92gOu/8h2SQbeGEvSozicZVGdu72C6TUS0djIijDVhctCSbd89nLEBlLQu3iq+HdXpBXqoN1akBese/U7vnVpR9i5v0NNDvoKfsa4P6zceUqEG6GK7r/gJg8QfZhJlxiWVCZaSHeE8LI4Tiq9j5zlqvDFploLiqJXGXWy7Y12JFD2Yb3Uu+mlVoF1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM3PPF777B3455C.namprd11.prod.outlook.com (2603:10b6:f:fc00::f2f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Tue, 6 May
 2025 18:57:47 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8699.019; Tue, 6 May 2025
 18:57:47 +0000
Message-ID: <41334bc0-4ea5-4bf6-a5c3-9726fccfd5f8@intel.com>
Date: Tue, 6 May 2025 11:57:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH v2 8/8] fbnic: Do not allow mailbox to toggle to ready
 outside fbnic_mbx_poll_tx_ready
To: Alexander Duyck <alexander.duyck@gmail.com>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>
References: <174654659243.499179.11194817277075480209.stgit@ahduyck-xeon-server.home.arpa>
 <174654722518.499179.11612865740376848478.stgit@ahduyck-xeon-server.home.arpa>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <174654722518.499179.11612865740376848478.stgit@ahduyck-xeon-server.home.arpa>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::24) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM3PPF777B3455C:EE_
X-MS-Office365-Filtering-Correlation-Id: e50270f9-c501-4ee1-b090-08dd8ccfe40c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MXY0WGJQSUZ3aldER0lyY2h4YnR3RzNGV3p2Ujk4QThwVUF2b1VMRTdWNlQ5?=
 =?utf-8?B?N21HQ0o1dmd1ajJhYVBqbVJ3U0xCVmNuUFRITkxxNDVRNDNyRXh5NGVxNkty?=
 =?utf-8?B?bU1QcmNnR3h3OVFUQXBHVytxM2hZcFg5TVpRb0MyWHhUa3lDbk1tZm04N3pF?=
 =?utf-8?B?ZlZFaHFrdnJ5aUUydGl4UXRwY3Vvejc1VWVhU0o4aE5yOHFNUVBiT1VQK1VD?=
 =?utf-8?B?ZWpwUy9uOURESitPSko4Rm9TVVNxZlpsWmRDUm1vNm9jWERkb0kySVVBU25s?=
 =?utf-8?B?anNJcFJKSjhMNVJma3o1Q05hZ3U5VEhXWk1Qamd5c0N0dC9JeUVwRlZFN3N4?=
 =?utf-8?B?bll1bFprQmZDTmZLQW1LNEpFMkVyZU1ZWHN4aVZsazhpZmVMTER1dVIzWUVV?=
 =?utf-8?B?ZDZ2eVptZzdlTmV2K0c4QUFSbmxGQ296OEQvalQxb2hjU3k3Z2RrcEIzRFhB?=
 =?utf-8?B?VXpwaTc5TUYyK1B1bFFLNWFlQ25UUVpoOGwrMGhkalYxMFptblpzM2p0WjBa?=
 =?utf-8?B?WFViRm40Ty84djFESkVqbXR0THl2dGI5U0ljcnc4Vno4dHZRYyt1N253Mi9m?=
 =?utf-8?B?SEdQV01Pbm8zM2pueXFma1NpQzQ0L1pUTS85YW1JU29meFN6MkdyOWwxaHdP?=
 =?utf-8?B?cnFJendSYVlObUFkTTNEMlEwQVVqZzYvVXdvUHNweTlYUlQ5VTZEdmkyZU9O?=
 =?utf-8?B?YlltbWgxK0JKRmVaMEVVVlBmRWxGRlRRM3RvNjB2L044Sy9YdkFoVmFiZmpN?=
 =?utf-8?B?eDNYOXdRUjJDYVUyVUpjSEN6RU15em0wQzJud3BGem42cjBQZFl3WnB2ZFZn?=
 =?utf-8?B?a0txQUgrclV3QnVZWG9oV0tveWU2KzBFdXd0aWErb3pLVlhiU3ZPeE1ZOFR3?=
 =?utf-8?B?QjBXdUVwR080UU9DcWNqNVI4alJVSEJRem1nMFJLSHFFdTMyN2RITmh6MzFy?=
 =?utf-8?B?dForS2lTc0l6OW9mSi95TGdNU1JzVEJRZ0l5eDlhSEFSUVM5TENhTTlVaVVF?=
 =?utf-8?B?RGk0disydngyd09BVE1Kajk2Tnp4aGFNUjZrcVBOaExLWkI0QlRNNm5hSEpj?=
 =?utf-8?B?YWxlWmNRSGZ3V2JvVHRlTjhoMWdLRFZqZFFiTzNJRjdTRUdGbFU0ZmJ5NUxx?=
 =?utf-8?B?ejNBNnRnUDA1ekVFZUcvek96N0U0aHFUNU5rNS9PVkZTa0lKcGk2NWVYK3RL?=
 =?utf-8?B?akxBVjQzMzM5OWtlZ0lFZ2ZxcmJsNEZsZ3ZhR3pGbzR2OUoya0pQRlBhVkVq?=
 =?utf-8?B?M0NNSVplQ203R3RCNUdUMnJNdWgrWUg4aTN5RTNrc1dnck1XMmVRSlBKcENv?=
 =?utf-8?B?ZEVmSTk5dVlZcjVKTjZDbURBTC9EV1VMR1lDc0xDT1ZwdDZaM3JIOWROMWI2?=
 =?utf-8?B?UlB6RXFmRXBibUtjeVZ6MGsybXEydURqMlMzeUlVR3BWTzFDMzNoOWI2a2Jy?=
 =?utf-8?B?YlR3R1YwSnRDSWNIZnpWZjZxMXpqcWNWTjZWc3FqR0wwR1dneEhEaEtQcHli?=
 =?utf-8?B?Wm9pOVA5Y0JLS0V4VFozQmMreGNLSXdTZDhHcXRaM1BIMmNIcW9IUXFQMzlz?=
 =?utf-8?B?anBoK2FXdnhDUXRDd2g5TlRPejhuQVRtVmxybFQ1TWpnMEtQWU9LdUQ0UTlZ?=
 =?utf-8?B?QUVIckt6UkRZZzdXSXQyUi9WM3k3cFhxYXMzbXptWkFJWURzMDhPd04zTFVi?=
 =?utf-8?B?SEp4Z3Q3WG9CaDZzUUZrMlVyR001V1N5aFk4bEJNemtod0tNdWpOSFQrbTRj?=
 =?utf-8?B?eXV1UzJ4TzRqNUxSaHZWK0NCRUdBUzZhbTJMMEQxTWQ3QTBkc1BxOVczL0Rv?=
 =?utf-8?B?NFoyYXY1N3NLOTFRTkhUNXc5RVNPdG91bDlpUkgyMS8vNDdIeEt6N0poU1Er?=
 =?utf-8?B?TUVmUDAwbUR0dGc3MUZSVnZscmc2ZS9EaVFQRWZrdUdHN2VuNGNBNU1LTEh0?=
 =?utf-8?Q?B1kND8CgD6I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUJkRjNUcUYvMDVxT3dpWXI5WlYwaFZLRWVEdHhqS1BLSGl2amtnNzN0YUdz?=
 =?utf-8?B?UUdSNFN2ZXM2cmVtb1VGT3BXV2xSZHdISjhRa2xMNUpOZmw1S3JJMG5wbUFW?=
 =?utf-8?B?WlJjTDlwcEQ1RVNIUnQ1MGltaDhkK3AwODQxT1grV3VaMFFteDZnNkRSYWVT?=
 =?utf-8?B?eGFHZ3ZyVDBzbTVSZEJiUlZKZzM0TEFiV1VPQkMyWHVacXhJUkl6VHF0dnFt?=
 =?utf-8?B?SlhJRGsvOU5uUnQ5K0RSdjl4MThlWWRpbkEwS3k4dVY4ZVVYWS9wQlNrekRR?=
 =?utf-8?B?Z3BBMWduUEJXK2VsVktOS1ZVM0Y2bmFHYlFjUlNmN1FVZXhTb3hRMEhYY2tZ?=
 =?utf-8?B?Rm1tdlVLb3N4NCtxNnlHNWlZeXdYQktIVWxBS2ZHVFF4czE0anhDc3FJNTdz?=
 =?utf-8?B?Q2phcEtlZXBxTG8vV3VaalIzc3ZHaWNoR00rbHh0emU4NUlJQTFOU3gxMlN0?=
 =?utf-8?B?ZlJianRqLzhuZGNSSVpjRjVjYTlrNmFhdlJwUWE4Nk51QzRpTHVYV3BHUUhW?=
 =?utf-8?B?Zk9OZWtzK0cyT2JjMGt0elJWVmF2bFExcEJLQWY2cG5NbzlNaFZFczJqbUdK?=
 =?utf-8?B?QWROZUxTLzY4VGN3SWxkQWE3WVJHcC9zNkxsd0M4ZGRWYkM5TS9LaE93ak5P?=
 =?utf-8?B?QVk4VllFcjh4WUdDWU12WXBYSkhvUVZKaWoxWXZZNGVIYWVESkdEREVEaGJB?=
 =?utf-8?B?Y0Y3eE5FUmFCakNMZXlLSnlYV2ptNFdrY2tqallTYnJaeWpYOFZVZmJ5eFB2?=
 =?utf-8?B?SnAvckhYbFVXaHdXMUdPV0hOclBIblVxdmpma2tJSUZmZ01qMlEyTVhmeW1R?=
 =?utf-8?B?MnNZNGhTYjlxYW15U0lJU1BCeWRUMDlySVJYc1pMdmczMWtXZjk5VmtlOHU4?=
 =?utf-8?B?cTFpUWw1cnpMQktTMHhmbmlRQXhiOHBZTjFzK2Y0L00wUndtLzhtVkRFdDZJ?=
 =?utf-8?B?NXRBTFdwM1RyOEVDK2dVWXFrUGE2YlBucFlZL2Y2REx2bnFTeitnaUgvN3hC?=
 =?utf-8?B?eGlkRmdRVStnTWpSWldIcnJEaTZKbWYrbTZRczdkOWJYbW1QWUxJV1I1K1Qr?=
 =?utf-8?B?aVF2cXpGN3lPb09QV2JScW83Ym91aVBQWitvYXg4YVEvaGdzb3k3RFNNNklr?=
 =?utf-8?B?YXdObFAzcndvM0FPQVZpQkw4d3JiV1ZLemJZS2poOHlnREM2eEhDM1U3RHk4?=
 =?utf-8?B?TlorTy9wLzg2cGprNmY3YUk1K1dNSDA0K3B5SktYY0ZHYXNsZ2JaM3dkN3Vt?=
 =?utf-8?B?S3ZQUFcvckE0NHltWExFaHJOSzhwS1E0azc5aEFJTENDTlFKMGpQN2gwMkFI?=
 =?utf-8?B?aDZCc0dKd2ZsSFZHT0NuZkpSalorRnN0K3d2NzFhTjNRTlZhQ09CMUozUENx?=
 =?utf-8?B?NzlteE5qTERVbmR1bnYxeXhRejVsOWIwUW9ZQVZjV0RmR0FKTE1lTTR2Y2dT?=
 =?utf-8?B?T2djR1IvS04zZE5rZGhvcWNtcEFrY3RrUThOOGt2cFh0WXBZMVdTUm5WMDNZ?=
 =?utf-8?B?M1BKVnpFellIZldHeG1ZK280VHNUbmlKUE5SZzBhTUlmSVhMUGxOWDZ4MXVk?=
 =?utf-8?B?SE1WYnZaTzBuUVI5V1hIenJHSGJSQTNVbVNWMW1jR0xlZ0pTNks2TnR2SlE5?=
 =?utf-8?B?TVJaU0hkY05QWjliaEJua1k2bEhiWlBMdldTTGRmZVhSbEt6OW1pU2wzRm5w?=
 =?utf-8?B?Qlp3M0s4S2FyN1NJMHlFTjJZZ2FJNng4ZTV1NUtlSjZKeXR4YnNPQVZOai9s?=
 =?utf-8?B?WXFJOEs0Q094WTJDM3lFM01tU0xNWGlzMDBqZHo1WEpkQW1JNXFMSkdNbjFJ?=
 =?utf-8?B?SzNVaXdreDZqNFR6Um9CZ1Vzb213bWhnRDc0Z3VnSnRyUk5GemZpWFJWSnYx?=
 =?utf-8?B?R2J4YTVIT2hiOTlDOEx4K3VsK203Q0Q3TUNEUHM2alQ0bjBFMGxGZWRXOGgz?=
 =?utf-8?B?RXlHUDNtTTlXc0F5RS8xVk8vQVZTbjNzTzEzTmFWVXlKdmRFd1B5K3hSSm8z?=
 =?utf-8?B?ZFRZTVIrbHhqM0dYYUgyb3o4NGczUGVHWmdaSkc0bWVCSVZaSHFhNFdVaFFi?=
 =?utf-8?B?bTNQaU95VDI5UUkrZDNvME5WYnllQWNTUjZITWN3TXErNm9xRHVFMFhESSt0?=
 =?utf-8?B?Tzk1ZmNnN09zd25iNll2R1VjVFAxdE9qYXAxWXJaNko0RStpc0JGVnd4Ukk0?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e50270f9-c501-4ee1-b090-08dd8ccfe40c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 18:57:47.0022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgJ83btZne71yBO2+do5uehWAdH5BWsHDTR+ZgrmkHyH4ryMMu6tu5XPu085+uXaMOPKqav2jTs0RicRfPJVxzxWpSPCi0yDuFUEbLUXZV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF777B3455C
X-OriginatorOrg: intel.com



On 5/6/2025 9:00 AM, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> We had originally thought to have the mailbox go to ready in the background
> while we were doing other things. One issue with this though is that we
> can't disable it by clearing the ready state without also blocking
> interrupts or calls to mbx_poll as it will just pop back to life during an
> interrupt.
> 
> In order to prevent that from happening we can pull the code for toggling
> to ready out of the interrupt path and instead place it in the
> fbnic_mbx_poll_tx_ready path so that it becomes the only spot where the
> Rx/Tx can toggle to the ready state. By doing this we can prevent races
> where we disable the DMA and/or free buffers only to have an interrupt fire
> and undo what we have done.
> 
> Fixes: da3cde08209e ("eth: fbnic: Add FW communication mechanism")
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

