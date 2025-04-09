Return-Path: <netdev+bounces-180961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08513A83483
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 01:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E613D1B66149
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 23:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592F121CA12;
	Wed,  9 Apr 2025 23:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jS/J6hTj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC3F215783;
	Wed,  9 Apr 2025 23:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744241320; cv=fail; b=lAKkuTgovzlXKWOINGVrnYl2bt3+Utdwn5JwJRl3h/nMhZfeRuct9sOL/3QFqa3a7/L4fEneBbnLQgrVSkx3x5GgIkdLJFwE4+95y+RuVRBAIxrKoV+ueVUKcnDmko3BS7RAQpTQ0k6+ibJIJHA/IMfrs7eKhEeLuc+G8Uw/kUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744241320; c=relaxed/simple;
	bh=KVKLixp/CfWlI6C9QkLLrf/+4rI1XIB2CQNJz7VVkHQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VXabbb75P9eXjZsX/nZjr0pRQ4R65p6Xzy8RqIcpP4I3eSjHTdm0brF1TgzoObxRbKjL1qPo1XiJ07VAlTrMRO45vet6fyJYAQUkwKwrkCgxklG2QewZHTs5Bp6f6LsYT38gVgHoatgbLXmeClXL6CkizuXXAhWh1mUPKez/nFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jS/J6hTj; arc=fail smtp.client-ip=40.107.236.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l5AKN/PJeRU73W9BoTDqeFLKoVM4Q2Q641+CMgPlrbIgc+N9ohKLWP8/IWFoqXdaG08iFvKl3fMEUYb4VnzCPTM7EYRhfjoaqKV9hnm6//VqHJov5yLgHYMC4OoCSi12FEzwGuKuP9c500iaAotq69r+UJHMN+qvTdyoKK4PhHi8r2e7+A0O7Drhiy5NdCSpeGGlJQbhDeg20QklZDSjR/+55O//VwgGgJyZgE2hF5m/rig0k3L8k8ZmPVtpg1BhiisU7kXmkVmIiGENU7BceXzWBcwkFWN8Rw3LUtvFku9jXSlyLqWUpgpv77iXl7Wm5AjrdE2x2WdpgrzaC2LzsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gq4swzAd85eaNiVc/BguOsaKqnKo6JbC7kfPY0Tqw4=;
 b=bZr74IqkfJkZOiEk/IhNGz/t5l4tvGobrmKHijBYZ0vLBRotO3iUYS4iJVtQTZL/dmryNJxr5n0QbRA8GWfai/e043Cl2KMFsCW72Gg4sUs++uD32xSd/Muaowq2vRptSeQbTsF2yGzTLzy+h4U9Cb1ZgNFPem3LZyX0BRD5X43jFbs1jp7R6y3tDWR8ER/VtBXA2Cg5jM8NPTzBPUpnibYHJmYeuS2jc1jaoK6alryk2+DicuClv1uUtd12m0FBiYrsY5CW32irHHnql9Vxy7Xax2F1+DhXraC+LEtA928j5OJ1F79uUuCrQ9We2DB8nmN5JiuhcUTDhp1Zh5rpeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gq4swzAd85eaNiVc/BguOsaKqnKo6JbC7kfPY0Tqw4=;
 b=jS/J6hTj8hzggQUMhN82PaSOohNFbJ/cdffttkCTEcltHHj98hNPBGHgqawTaMGrKQSMjE88R2hpJ/QWhVgjPt+Y44Xm1+EYinxbvcy9liFHihlgRSjr9bjn/uWjA2PBJ+oKtnb0UyJpMouzxa+XzpEm/PLaRcr7P0vB0KNbSTE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 IA1PR12MB6436.namprd12.prod.outlook.com (2603:10b6:208:3ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 23:28:35 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8606.029; Wed, 9 Apr 2025
 23:28:34 +0000
Message-ID: <5feab52d-1ef4-410d-bedc-eb112b318ea6@amd.com>
Date: Wed, 9 Apr 2025 16:28:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 5/6] pds_core: smaller adminq poll starting interval
To: Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, brett.creeley@amd.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 michal.swiatkowski@linux.intel.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250407225113.51850-1-shannon.nelson@amd.com>
 <20250407225113.51850-6-shannon.nelson@amd.com>
 <20250409165044.GM395307@horms.kernel.org>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20250409165044.GM395307@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::20) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|IA1PR12MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: 08d9b06d-1137-403a-e950-08dd77be3f3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjBDdnRLeUkrTWRPTit0THpTMSs1K3dSSG9hRU9ZNVRNc0NnanZxY3RYdDhm?=
 =?utf-8?B?ZElxUHNmRWxkaXVhSEdjb1NhV21ycElYSjhMV2VvOTdwTVNIWHlhSXNxQVpz?=
 =?utf-8?B?YWtGQnlUMUVub0xrY0lyRy9leHFDRmsxSGFzdjhBTFJydFFyN1hrMkhXTHV2?=
 =?utf-8?B?TmRtdXVnSWFad0xtSno4ZlBwKzlxUlpCVmJqUkVCc1laQ0Rta1U2dkJnbWh1?=
 =?utf-8?B?UWJLVEZ6NkJzLzNLK1VnWGlOTkJ5MitETGdLQlpsWXBWR015Qm5XTHlSUXRm?=
 =?utf-8?B?SW94ZXFUWWtyR2JjMTlvcWFKR0dSdXlvaSs4ZUNTbERVUTRWbVpJbTdhU0Vs?=
 =?utf-8?B?T1Fqb1h2MjBOclU3Q1A0TVBYelBLd2xWdDdBSjdWa0Rlb0liNHJXU2NMamtE?=
 =?utf-8?B?S0pMKzl0bmgvU0o3Y29CM0thNFlBaGNkRS9YS2hmYTFiMnZhVE9kUkhKOGJH?=
 =?utf-8?B?MVpaeWNscUpTSGYvc3VSbElpNFAyVDZSNExMbC92Tm5kck8vZGtIOUtCalA2?=
 =?utf-8?B?dHIzWVlQS3hpMXcvY29NWUUyeGNCMTExMlVWa1BkM0RjcUdWc0kzdENTcjhn?=
 =?utf-8?B?RGV5b29OWHlWNjVpQlZSek9vU1JZRHlTUGlzcENUVG5OcVJha2NlNWh6c2Ni?=
 =?utf-8?B?b0s3eU9ZSEVWbHBPRDJjZ1Zlc2hyK1BwTmFja2RSclZ6eGtCZGVLd1laOVQ4?=
 =?utf-8?B?VjRMbDZxNld6N2haOGFvRkJTQVBGa2JyczJEVFhlRjlaa0EvdXJGb0QxZkty?=
 =?utf-8?B?cVZrNE9nRjdkQTVKT0Y0Q285K1BSSjRHZzlBcU5MMnptV3ljWGo5Z3FZNEpw?=
 =?utf-8?B?YVZpUzdQenR1cUNob2FsdHYyMFhwRFpSa0gzMmdneEN4cHdCUHlpMk13T2Ew?=
 =?utf-8?B?R3lpNGZmaW0xMk1veXBwVytubXFBRS9GVGs5WTUvV21CL25lTzFxUEdpNm9F?=
 =?utf-8?B?YkRycm1ZMTRiR1VMTU5GTjk1YTJIaVRvWUxDbnkyWDViVUVxVjVCS2VZNUtW?=
 =?utf-8?B?SE8rTytSSXRyTVEvaG1raWNaaDczSmZrclU0K3pXQk5kUlhDQ1JWaC9QUXND?=
 =?utf-8?B?SFVicEM4Ylk4K1pFZ0l1WGw2K0VDdFZUWGpuQU1OMkt6aTYxaTZSYTRBOVFJ?=
 =?utf-8?B?T0dpemVmVnM0Zk1KMmpaMUZKUWVsNGhZOFlwcmVST0JCQk90ZUJkUk5IUjg3?=
 =?utf-8?B?M0lnNDlFNmVLM3NHWmpkNkJRbWRBTUFBU1Q4WEtIbk55cVZzRUFxcEdEdkpN?=
 =?utf-8?B?Z1FmbE5qeHRSTmdHSFlyVkQrNEE0NVJNZlF2clEydHloRmY1ZnN1Y0lncTMv?=
 =?utf-8?B?WWEvNjJBZXZzR254THZ1THhTdHpHVFFNMkxJRFV5QWlielMzV2ZvZE5EZHBO?=
 =?utf-8?B?bU01ZGJPWDJpc3hrRy95dytKOWNoMWxCQno5ZFhTdVRQUXZLSDFpcW02blc3?=
 =?utf-8?B?c0FVNm1CenlidEczOTltOTU2ckJsbjdZMGpYOUplMmJGdVI2UVRKL3NYMTRo?=
 =?utf-8?B?TXRSUzVVSXlOV1pnSkZYa09qYVlXbWZkKzJPNmhUN2RkQzQwUEx0VUdqa2Nm?=
 =?utf-8?B?WDlFbXNYTWVIdERRUFZ1OTRDdm9jVUEvZkQ3Y3B1Qk1McFBZMGRNaHRPMHBj?=
 =?utf-8?B?Z0t5Vm5CaDZMSUxKZ25IcDlkN0NYeFZyUW85QnpZaU9lNWJ4S2M2ejZKT0Fw?=
 =?utf-8?B?eDdoRFZBQlozMDhhYis2RUxmUGtDTFZTZ3N1M0pBSWR3ejA4NWFNUVRpZHlp?=
 =?utf-8?B?dTQrY24reTY2cnJwQmx3ZXhUWWdNOFpBV3hxYzN3dmFyTGtWYlZ4eGk2bEJJ?=
 =?utf-8?B?N0hqNUZ2clpnWGN5aGVQQVhTejlvUDZXbUgxakh6OEk3anZWbTBpNUlOaUZC?=
 =?utf-8?B?M0pxcndobU4xVjEvVXVzM0xjN1RMNmxBcitENGNoRU9UQ0VSUXF6YjFFaklS?=
 =?utf-8?Q?86NyJ0zAF/Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzhtSzlWNFlCQXBXWkRodndMSkNERFJadlZ5aVRmRDVzVER5NitqQmNpYitQ?=
 =?utf-8?B?Q0dEV1NxeWJ5M1pWS1A5V3NCTTNRajZUbEZsWm1wSHd6ak5mOGdIem1IbkJU?=
 =?utf-8?B?T0UzYXQ3b2xvSDBkM3BlczFjT1lIM2hPbUNlMkVrc2pocDFCU3RsMmFVNFVy?=
 =?utf-8?B?a3kxcXZhblJ2RUZjQkpqdDg0eFpEWUNkOEt2TCttZjduQTFZUWdVVTVqVjNN?=
 =?utf-8?B?WjRvK0EyK1IxOGdVejE2RlY2UTY0TSs4OXo1Zk5aZWdTLy93SUFQV2YyK2V6?=
 =?utf-8?B?cmpkL2orenVHT0RxYWRtODI3K1EyMSs4N2tPR3hCaVYrSjRxV2VxTmMyTXRr?=
 =?utf-8?B?RUUrYUl4MHc0MjNoS2JrbXo3Z1M0ZUthM1pqSzYvQi9FOTN2WTZkakxPTXdp?=
 =?utf-8?B?RC96WWxGTlZjZERsRTVKSCt6d2RLMVZPVmpTNDRnTHJpbTJUU2lPUHI4MEpV?=
 =?utf-8?B?ZkI4Vm0yYVZkRmNNbVVmdXVPN1UyQ0tMaVlvNkJ5a0t4OHNQbHNpd1hzN20y?=
 =?utf-8?B?U2cyU3kxQnZ0WFlvR0ZubEx4YWl0SEdXcmR3eDlJNnFYQTZBUGFrcURvZGZu?=
 =?utf-8?B?b3cwQi9mMEdPUFI5M2hxeWVPbHUxaVhVOU1uQU1wNEVsY0tYdmc5Q21wb2d4?=
 =?utf-8?B?SGQwbVZ6b1pCZkpxWEgrUThxZEJsMVVvZk1YOVpCekVFdGJOSWd2UmgzUi9T?=
 =?utf-8?B?Q1pQYk14STliWkJMVDVxN0Nrc2l6eDR4d1ZJSHVUeHh2cFdNVzhlck41eFl6?=
 =?utf-8?B?eXFwRlEvYytVeW12Q1VFeXNhaGdCQStXdU4wQ1I4VDNldUtrWDRpM2ZqZVFK?=
 =?utf-8?B?L0I4QlI2VVhZVmtLL1B2UFlJVktmN0xoekJ0Z3ZhcGNPbUtQUjd3RUZ2UnNQ?=
 =?utf-8?B?WUlCSWp3QUM5ZWdSLzJnTEtsUHpRM3liOVNpT0NIZEQvS3Q0Y2NacmtyNTZi?=
 =?utf-8?B?QjQyeXNvMUpJRm1KMVc0MkNmbUFJQmswTDBmZG8yTEFhMlQwVXV2TVFHd1Yy?=
 =?utf-8?B?OWpjUk9PTmtHKzlZYVA5VHIraEpPYit4eXNSZXB2Y0dSaUNZM1JtUnlWMFZ5?=
 =?utf-8?B?MmZMWSszSzkwamd5eGNvL09GVVhyaWZLZ1V4R1hmdEo5S0cyeVByYnpBNnlu?=
 =?utf-8?B?L1YvQWkvMHlJTHBKejBndmVDRmd6NGphWUdvdmNkZ0lGQXJpMWFITVRUMnNF?=
 =?utf-8?B?MlhSdVM4eDlNVVMvcVRCcmxwV3M5ZVBXMmN1ZHZVTXRIZWdGRW9RSnNHcTNk?=
 =?utf-8?B?VVJlRlFWeUVnSzJUS2t1S0I1eE4ra0l2ek4waGM5K29zcHRpazEwTUxoTWQ4?=
 =?utf-8?B?cmgzZHIzNyt2cmF2MkN3NHpMWTJwRlY4VndkQU05NTE4NEJLQlE3eWZ6dm0x?=
 =?utf-8?B?S01CampoYUhFZkJVTDFqUS9mRTRQOXp0L0RVd21NeGZIS2M3blZuWXpjZGFm?=
 =?utf-8?B?bm91Z0p4bTdUSVFqcXdsYmI3d2pQR2Qvc2U0MzQxMlF6eUJqanNra3FUYkQ3?=
 =?utf-8?B?UEt6MzlvQ3d6VGJTVlp0MGt2cFd4aTNOZEtUbWZ5b3dZSSthcWVpYkhxTXBi?=
 =?utf-8?B?ZUN6dHdKWkp2K1JBMzlGUkxXM0EwUGx5d3FrWXF0anVhTkdXQ1VEYmV5NlBD?=
 =?utf-8?B?R001Qzc4Ymw3QldtTHUvb0ZXTmthd0F0VDhlL3Vic2k1RVZtcGI3RkZTWU1w?=
 =?utf-8?B?UHlyOG1rQS84WUplUEViSU5sRnhHSFhnSm5wdlBlYlVhRkUyc3dGdXBENm1a?=
 =?utf-8?B?NFNCNEYxcXlJRGJmTVA5cFdIUVZ3WTZsOTJPRjBaYTRQa0thWXRFY2FaWWJs?=
 =?utf-8?B?TzhEcUkyWWdiNmFHRi9wazJKQkNqbVp6TFluYkZVUUp4eHJRdWVuNEdpUnJX?=
 =?utf-8?B?RGdYS0hUNUhvWWpyQ1ZBZE1hSXlEV3FEaXdwTDdydU9vREVadmZWYzZrUTli?=
 =?utf-8?B?Wjh4aXpxNjcvYTNXWk9OUlJteUpyZ2o1WEx6MEZ1RDRubWJHeXlGNWxtSnVl?=
 =?utf-8?B?ZDNWY05zbFZ2ZnF2TTlwSlhqbU56UitZa1hRejRBajlTZmFSdU1BNzQzLzZ3?=
 =?utf-8?B?SXgreS80MktLa3dyaTgrbTlMVmV5Y053UjZDUjZwWGk4WElHeUhhTHkrNW5E?=
 =?utf-8?Q?/WkY541wsnuoznt0xkd3DWt6A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d9b06d-1137-403a-e950-08dd77be3f3c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 23:28:34.6681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DcShyd6FlgMepRPq0tSqeRXYuFngaJ9rJCax8I95atSXXn80J96UKB7JPaMsFXAzY+9dVW3VNAxN5TrWApAe8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6436

On 4/9/2025 9:50 AM, Simon Horman wrote:
> 
> On Mon, Apr 07, 2025 at 03:51:12PM -0700, Shannon Nelson wrote:
>> Shorten the adminq poll starting interval in order to speed
>> up the transaction response time.
> 
> Hi Shannon,
> 
> I think this warrants some further explanation as to why this is a bug fix.

I suppose this does look more like an error handling performance 
enhancement rather than a bug fix.  I can pull this out and re-submit 
for net-next.

Thanks,
sln

> 
>>
>> Fixes: 01ba61b55b20 ("pds_core: Add adminq processing and commands")
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> 
> ...


