Return-Path: <netdev+bounces-186333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73752A9E722
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 06:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68EF5175F54
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 04:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF17189B9D;
	Mon, 28 Apr 2025 04:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PA9WTP2h"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2040.outbound.protection.outlook.com [40.107.212.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3476BFBF6;
	Mon, 28 Apr 2025 04:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745815044; cv=fail; b=QnmZefz+bRDuFNmRUdy60V1CBN3zeRcrzoi8sjqaxI81eEhc1pmfbpClt3YHGwSlSgYCoMXOCCUyW2Tk+sSU7hVcZ9kXMuHSMwFJF0Pw4h4TzGPYF+Dgst0MCn/0X3EwABOXvggGxfY/uuuioXgYF+re5jdju3exfir3S0Q7URc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745815044; c=relaxed/simple;
	bh=ATCDnyNjGp9wuaa3YJnytApiTHDg3Um2KGVDHHJVQEY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ONAZ+2SkRG/BrR9s8tC9PprKW+T2JN18KYWp3RNRzmW1YAYnpbQHCV3u/LHKCT3UbksuM8xGvEl013hnhINChEiSyz8lJ7FThXnQuRXYQXPVqeKR7ZLVnjaUQB2yh/jbGSe8ZNxg/C/Gp7AdxldTNL11GrJJop1hOqymskR1ZFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PA9WTP2h; arc=fail smtp.client-ip=40.107.212.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gUCqBuAOVgsiEytnCmQMYBorYUeTBIy7v5z7aMALawPTgmQZDYYBWCuN54MXxTUrIeDREudqJs/1VZZcjHarX2Qs0QguO+pQIQ4CnmAKvfyFnCofCT39wJ7b1X8SPWY26t9CcRVFbXYW/hp4NRWD3fBGujAkM8+wV33PBWEf82ggeq5AKJnPpZKGHH30eQoN4tyRNCS6d8urZ9j7jT4o1Vthttm/h4lXQESLapfb7Nn0DlFCoZaDRHSq0gfEG9ZaZ9ZEGPJforXdRUpn2fPe4dN38VUcOXorUkskzUr+5lLVxiQip/uNeRiFxaZzNw465eKb1g1bh6hWuB3d7RqY6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATCDnyNjGp9wuaa3YJnytApiTHDg3Um2KGVDHHJVQEY=;
 b=lXnd4xtcF+R+vNC2ESc+Qm2VcHGggkteKY7jKHvwLEPe0FyF/w7X+wyshn9438V20fOtcpMF6nSEjLJXIoUBXVn/ZdDMYq4TqfBMixvmjl4vfky86RkHU6NbPkGz3xFm9u3t5pwyVTEiIOU1WsrbkJSyXq/AZRngkmnpmPFGmZ4vpl6n53uFpl6ATTqOXsJ6H8eZKQER8t9FCf6sdlrEv7Xmk53JIms8ziDW03zEGImqbbBwnKYAtWL9ILJMLYVrmKojnHsR6OGtRH6/+1m0lgnLN08Hydxm2ARlYM6Rs9MZMpMQcAnkfO4p/elkKRl5mE7qfgxjVrUbkc0l9/Yj0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATCDnyNjGp9wuaa3YJnytApiTHDg3Um2KGVDHHJVQEY=;
 b=PA9WTP2hOunMemf1G5C+xcWzbgSUazCyjMC/TvxsbqGoP5uy9tShaD9x/in36t9vThuRZpsZk5XHRPKqPOr+OVlvO1ZyQd/KtAh4+q5c/ipoeyUr0wQNT+a7any2kOM8a0fjOhC4XTx1WwZEg1NxOQ1K7PKxfth9CYR/q04x8I2EXRXCxng3xzK3OnLp2GxCpcVblCEigq7D8CJzlIutiQkS+hpIwJvhP81MzYidyzlC7zJnbykf099dsVRpA21OtZtx+1EWf03rd2jm2jHQ1e8q4wGd/fDUrTZHSHjg1O6/AwgGEP7F50ehfVzAhd+eYMM5JesopUiukh7zwCqpuQ==
Received: from DM6PR11MB3209.namprd11.prod.outlook.com (2603:10b6:5:55::29) by
 DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.31; Mon, 28 Apr 2025 04:37:20 +0000
Received: from DM6PR11MB3209.namprd11.prod.outlook.com
 ([fe80::18d6:e93a:24e4:7924]) by DM6PR11MB3209.namprd11.prod.outlook.com
 ([fe80::18d6:e93a:24e4:7924%3]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 04:37:20 +0000
From: <Thangaraj.S@microchip.com>
To: <Markus.Elfring@web.de>, <netdev@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<linux-kernel@vger.kernel.org>, <andrew+netdev@lunn.ch>,
	<Bryan.Whitehead@microchip.com>, <davem@davemloft.net>
Subject: Re: [PATCH net] net: lan743x: Fix memory leak when GSO enabled
Thread-Topic: [PATCH net] net: lan743x: Fix memory leak when GSO enabled
Thread-Index: AQHbtcXWBfVldSR9lUevtJyQlN+H5rO4gd0A
Date: Mon, 28 Apr 2025 04:37:20 +0000
Message-ID: <ab5da6456cc9e995ace79991b2407a5183847517.camel@microchip.com>
References: <20250425042853.21653-1-thangaraj.s@microchip.com>
	 <2fa8f9f9-c0ab-4f18-89c3-a5d48dd4e54f@web.de>
In-Reply-To: <2fa8f9f9-c0ab-4f18-89c3-a5d48dd4e54f@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3209:EE_|DM4PR11MB5262:EE_
x-ms-office365-filtering-correlation-id: e2683f10-3230-449b-73d5-08dd860e5cdc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a3daaDlOZDlVcUE5MTE0OFdQdUZ5bG5WcWt1M3krWHJWaGJMK0RaY1ZWSDNo?=
 =?utf-8?B?RzhKOVN2K3EyNi81ZTR5MWtSZ3B5KzlzdTRyeE1BVUJta1Q4cXhKVCtsdmZH?=
 =?utf-8?B?SW1NQ2k4OWFkVjh1L04rWVZ3ZjNPMUxxbEtlTUhhMzFnYWlyUzZNWEgvdnRK?=
 =?utf-8?B?R2lodGRvb21MblBHTStuU0g5S0x1MGZubCsydWYwelBGQXlnSDJQNy9NS2pa?=
 =?utf-8?B?VnVHTUxucTAwTThrNjVNNkNJd0c5eDBjd09WTWx1Kzg1QUtwbFkyZUYzaWtB?=
 =?utf-8?B?cFo4VlcyUVFKVjNSMEkvMjBEQk1FcGpyWlE3dmhkV2xzRllYUGxKaHlicmdj?=
 =?utf-8?B?ZXR4MmJZZTJXYnkwNjhtNHZIWXNGZ3FueC9yY0p4UGNBYWowRm1Jc2RzNFlq?=
 =?utf-8?B?Vmtqb0JPak5rSXdVa3c4WDM5dFRXcjNnYkdWTWplM25BS3ZOaGJzdS9kdEor?=
 =?utf-8?B?eHg4eWlkdFByVkJoNWhLc3J5bnRrSnNBTjUvTXU2bUdWaENxNG4vM3p3QklZ?=
 =?utf-8?B?UzBwMCsyVDlGS0hLZFVkaWdmKzdsc0ZUbXBRaVpYeFpKZnFYN2JrTDZueXlh?=
 =?utf-8?B?ck82N3F3ZndneXZjS1Z3OTlhWHVJeDJMT0YvT1ZYdFNFcUZzeUFsOFdneFlI?=
 =?utf-8?B?UjhaaHNzVzRQMHRGdmpxdWRtRmduQ0kzdlQ4NlhvUUFOV1Ntbi9TWDdwVjFy?=
 =?utf-8?B?dHZYcXdra21qQmFBenpMMDI2bXlyNDlVak84aWNBdEdEVFd2bkEvcU83MjQr?=
 =?utf-8?B?NitkRVFOSE8xR053ZmordndiUjd5WjVnNnE1RHNlemhyVUhEdFFEVC9hQkYz?=
 =?utf-8?B?NXVNUFNxaFhhMmdXNHRNWnhVdi9icGl1VkpqcmR4YmxpYk14YUxvaFFhbmtz?=
 =?utf-8?B?M21OYTF1REVvSStvc0VVSUJWZFNnK0VOTGJXWnRGa1d6M05oRDlwZW5VTVQx?=
 =?utf-8?B?VHFCUy9pSkl0eExxakEyM2NqT20yR2Q2eW80OHIxVUN1QWNyWTJ0T3NIK0Vp?=
 =?utf-8?B?dGVqWCt1SkJrS0wzUHVVQXhnNUVKV3dIKzcxbWpQZFJDM1J1dlV4VzlaR09X?=
 =?utf-8?B?b0Y0TklXaDJUOE0xWTVxb1E4U29CcUx0Q3I5d1Q5VWViYnNrNHprVHNwWEEy?=
 =?utf-8?B?Q2x2ZXZnZVNBQ1ZjYUFkemE2ZzlXS0thcktuWXJzWS9WbDJOSkNsZlU5aVNn?=
 =?utf-8?B?b09tNTBaU3l3UzJlYzdlOTRXdTFDQVRLMjFVR2xUL3dJZEpOeCthRW0zU0o4?=
 =?utf-8?B?MHhyc3Y3VkRabWovRXRvRG1wd3IxaHNrYmxmd1hoeFI5U1ZNZHBZL2VRL2lM?=
 =?utf-8?B?SDJBQ0N0YTdaeVlLdzRKelV5dFhVSnFTUlhHd1NlNEovL0ttZmhsbG1USTcw?=
 =?utf-8?B?RnBOOXVDKzZGWU92Y1JWMkFjRlNiUGhBeHkycVJRdmFsMWJzWWF1OWdyQUlV?=
 =?utf-8?B?V3lWSklKWFJ5V3E1M05EQ2Y1anVJcG1RclJGWG9tbCtMZUVUdW9FUTc2VTZj?=
 =?utf-8?B?YlMrV01NNW9XT1I1OHV6TVZkU3k0ckRVT1hNUkI3V2Q3ejZUbWpBLzA5VFVM?=
 =?utf-8?B?MkhFVWpLMlZoR1RJblZ4VmZINVRuWUhhUVZya21FdGZsNjkvYlcyTGg5MVlF?=
 =?utf-8?B?YkRsNVdBMEFyTDJ6UjlqKzB4TC9sb0d1U1Z5Q1oxUVFwSFF4b2hTbnN2TFlG?=
 =?utf-8?B?QTlyMURMYVhhV1lKREYvWnBLUHYxVmxzQ1VJOUREekR5N1ljQlU5M3VCRlZI?=
 =?utf-8?B?MWtFdTVQZXNVcm1nbm15eVNQUm91VGFwZ2dhUkltbHp6MjJOTXBBQ3dBWjBW?=
 =?utf-8?B?d3o3UWR1ZmlyZkxFRlM0a0ZyRGlYSm16WjlhRWZncFI0YldLN09McmxVOW1T?=
 =?utf-8?B?UXA3cGk4U0JVOXNPUWthUVpxZGNJdi9TS0I4RTFyYnlXTzFkbEtZek5CeWtT?=
 =?utf-8?B?RFFCYkh1RjBGTTJjOHk1UXIrK3F0S3hheVJZRjJjY3EybjhCMElZMk9ZSStk?=
 =?utf-8?Q?ZP2MUHn+yv7+u4fAgbKzlOHt2vmXp4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3209.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VkxMbGg3RGdSK25RbXpNaFpKQmVrN2pQM0M1UkpKNTRLWlhTSEE2OE9HM0FM?=
 =?utf-8?B?WmtLd2FTQ0pEV2xOQWViejBDa0JVT3JkMkJqd0ZpVXpEbDNHaWJ3TW5rNTJl?=
 =?utf-8?B?Y0lDTGZtanVFblU1ZmVTOFFWdGZ0T1JacSs4MGdtZ1I3QVJGdFBBamVhK1VJ?=
 =?utf-8?B?TFpWZkMzY0ZlNmVRWGdFbWwzQlM4b0hJcW5kRXZTVEErQmJLL2NLbXFHTUlw?=
 =?utf-8?B?b3VsK1RYVkJXaGFITVBxM3IxQ2c4TDVHOWNMU2lNU0tWUHB1NFhqck1aSWpN?=
 =?utf-8?B?KzNkR3NnZmc3YXFQaXhVYzdGcW11ZUpLQnUwUlVBM09JMS9MMVBpNE5ySnRW?=
 =?utf-8?B?TVk4b1ZET0Z4Z0NhU3pDMElIY0RXb0tDUmhyZ05aTGI0QjduZnl0SEZJMlhC?=
 =?utf-8?B?N2FTN2ZEcVE1YnVPZVVGTmIrR3BQTXJYOU1ZMGdkQTVWRGJqS2FrdkZPSjRU?=
 =?utf-8?B?VXJqZnNWcHdvcEF4STdQenZ6R3NkYnQ2QXZveklETzQrak1XTGozWDQ0Z01Y?=
 =?utf-8?B?dHlVUlZxMzVHS1ZXV0FaTFhYN04yUVBZb0pERlEvaEYrVUsvUXF4cGs2RXhh?=
 =?utf-8?B?MFMxSG94WnVXbm1nMXdheEJWRGpuL0tiQnZkallhRmJlVFJoWC9reWJCQ2U0?=
 =?utf-8?B?VmNaYWRicjdxcUJjNHVjMTU0SWh4YW0vQ1RySy9sK1pGcTN1S3lpZUNocHlC?=
 =?utf-8?B?N0JWYlMxVXVrSkY3TWY2VWx1UkE2QTRTbGpUNHp0a2dMeTNEUjd4cWlLOUx6?=
 =?utf-8?B?V0xUV1FOdGEvaFFFL2tCd1NCNHdjVXZhVDdOeXhIdzRTdlR2UFQrbmtJbjl4?=
 =?utf-8?B?dlBCNXVpeVFFT1c2dEVxZzJaUlFVSjJhSnNvdldlbnd6eGQzVjNndU93YzFV?=
 =?utf-8?B?ZlVaUS9Rd09qS2wyUkdWQmlCTGU5VXJpdG5jN2VyeWFubWJaSkk4V2lMNDJU?=
 =?utf-8?B?TFN2U1lhNUEyQlJvdXlpOXF3eXV2Rnh0YzBWMzhHNkVPbis0RjhTRlF5ZTFM?=
 =?utf-8?B?bU8xd0ptcGRMWGxkUUgzWURiVzQyRVlhQ1c4bUlJcVU5UkNjeUhrbHJCaUhY?=
 =?utf-8?B?UXhzdXhIQkY1dURsWnkzUkszbVhiWUp5VUpaL244QlU2OVV3bjBPTGE0ekJu?=
 =?utf-8?B?bXAzelFBUnFiUGtldWhrVUhzUGk1ODl1RU1oTEx2eG94MUhFeGJOdEt1SllT?=
 =?utf-8?B?SUN5aUFmWXpPT0JQcERHMUtVbWhodmhhTkNlSFVZSEFraUdSWkFjUGxiQlNo?=
 =?utf-8?B?SU5yTTZ4dW1FbzN5aENtdmtKZDlWTm8wRDV5RVZmYWdZdExLK3hoc0dEOGZV?=
 =?utf-8?B?cWZxQlVkTmd4dkVqSC8xc3ZMT2krWG1tUEtEekQyZnI4RG5NWmxUcVRISXUx?=
 =?utf-8?B?ZTZrZXJPRTdjRWsvODNIT2s2TTBNTEtic3dZOXZRSE5sdkhxY0dnVldQRWc0?=
 =?utf-8?B?aEdoVTNuVWl0bnVmNmtkV3FBK25Jemg2U2ZGZlVPdVRoWnBQUmRqc0ZVTWw5?=
 =?utf-8?B?clREbWZmanA4NVJCZW5vanB1NjNFZHJHbTdGYXpHN2lvaUJrUElzZDU5S1Vo?=
 =?utf-8?B?c0VvT09icW9GMVljSG96TmRza1NnQWpWZDVPZndiaDEzQ1phSnBzMzZOS1Nn?=
 =?utf-8?B?Vi9uMjBsaFNGbUJ0Y2ZZYldnaUtRV2loYXlINmE3YWFvb2lja25oOTJ1SzB6?=
 =?utf-8?B?bm01QUFGWnhmNmtIU3ZXc2ZlbW1tcTJqdmVNVkNMU0cvSzFsVGJNc05mNEdP?=
 =?utf-8?B?d2dzbWxjdmhmaFVtVEVHNFNlUzhwYndNM2lBYWpPQ1NrSEZOaGcrR2pmeWdQ?=
 =?utf-8?B?WFJzeUJCUlUzUDJFalBmTythMDNGeld0M05vdzkxWk93M0ROd0M5SHJRZXp1?=
 =?utf-8?B?L2QvVzdadWV0QzZmbWpGczV5YVduMkVEUnNHcm1oaVZQVjVlM1h5b0VhaW1S?=
 =?utf-8?B?NmFsU2lGNVNTMFl1TUVGYzA4Tm5HZUhNWTlWL2VTbjl6cXFxb1dYdEhzc0lt?=
 =?utf-8?B?WTlGWWVBZXM3UDFDeWxlYmtHdkV0dWtiRmdtRTdjekQxSGFVZUtLTXF3dUtM?=
 =?utf-8?B?eXR3c2ZzZkVZUG9lQS83S3JkV1VsZUpXQXFaTGYyV3FSOWZ2Z0d5citRL2Yy?=
 =?utf-8?B?NjVocU1HZTR6MnpmTlB3cVpMa1BjaFlGU3BnT2p0czZ1Ym9aT2lnVW9OYzh5?=
 =?utf-8?B?RVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D725B2092B33EE4B8641B56628E44124@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3209.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2683f10-3230-449b-73d5-08dd860e5cdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 04:37:20.1804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8FSNeJVjv+7x/MsQoxJXCOE8WPPFUeoWkWMJ33rxzbjNQHaDONimFiweChuN08ThpsWEr53qUcoMipBBPsNVYLbGLmC4f9y99nysbjebRJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5262

SGkgTWFya3VzLA0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KV2lsbCB1cGRhdGUgdGhlIGRl
c2NyaXB0aW9uIGFuZCBzZW5kIHRoZSBwYXRjaCBhZ2FpbiBmb3IgcmV2aWV3Lg0KDQpUaGFua3Ms
DQpUaGFuZ2FyYWogU2FteW5hdGhhbg0KT24gRnJpLCAyMDI1LTA0LTI1IGF0IDExOjM4ICswMjAw
LCBNYXJrdXMgRWxmcmluZyB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBs
aW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBp
cyBzYWZlDQo+IA0KPiDigKYNCj4gPiBpbXBsZW1lbnRhdGlvbiBoYXMgYmVlbiBtb2RpZmllZCB0
byBhbHdheXMgbWFwIHRoZSBgc2tiYCB0byB0aGUNCj4gPiBsYXN0IGRlc2NyaXB0b3IgYW5kIGFs
d2F5cyBiZSBwcm9wZXJseSBmcmVlZC4NCj4gDQo+IFNlZSBhbHNvOg0KPiBodHRwczovL3dlYi5n
aXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0
L3RyZWUvRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5yc3Q/aD12Ni4x
NS1yYzMjbjk0DQo+IA0KPiBSZWdhcmRzLA0KPiBNYXJrdXMNCg==

