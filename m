Return-Path: <netdev+bounces-189607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67897AB2D05
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 03:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A19E8189CCAB
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 01:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64CF20C494;
	Mon, 12 May 2025 01:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="OShb8UVE";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="VUNnfbyl"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0024c301.pphosted.com (mx0b-0024c301.pphosted.com [148.163.153.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC4620C472;
	Mon, 12 May 2025 01:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.153.153
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747013302; cv=fail; b=cvro2ZJNiW2oMdk+ILSbMxhJtMCDTSQgRd5rTvdd1rtyqjvYOF8fA9e2ra0ZiuFa84JeH0JYWjTBQH2jLyBlxhgAgFGmSIbwtaYQLvxNR30fXE7yIoMyAHy8/fEXntWKN87t4v7+03vb51Qe3Q/Ozk8ZFMsGd0wllrfwxka7+HE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747013302; c=relaxed/simple;
	bh=b8CqXrs6aJVEOej0AuRdPTxYayQQhb2unx9+3Sc1UHo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WtSRRxJXxJsGW6dK5/Xmrg5n4tT01Yje2V+Crt9LpfEom71ffNNRjKkDueVu9j5OCfzektNWkEUCliB/GsAih+KDZtMctFzbmUPizZ0IxY3nxD79VbM4QQjVNtaBB/2bm0pDUi9qs12E0rVC/QFGdZoUAnKuT2D5IzUUyGCbA80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=OShb8UVE; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=VUNnfbyl; arc=fail smtp.client-ip=148.163.153.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101742.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54BNrm02027097;
	Sun, 11 May 2025 20:28:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=iUmW6Z9NJh7Framw2XmyIpfMBUt+ypWSE2hLnuZfHWI=; b=OShb8UVEDAct
	gmJJau718dHhdseZhRG13DstktdWcF/sasOB9buun7oTQHYO8lyyRFrVd+VFLoIR
	baXjQd7LKbzf8u9ZZej2vYi598+Kaf0Tf5qr8ytcKR211fJGuUf4VvKcWT+ozGdV
	jz3BsX/aNeUojQGKvE1ntOcUeMA0D29/qfVdbCDCmFEHG8mk8qYY05eRzjoKsNwn
	E3jZHxf7zouiqCd8tiKW+u7yiaaDughZgArdNIe+oiJoTvxk5etcDbnPeFpeqSd2
	ap0Dqwv2sQsKCiJlM6CBe4cqkc35krm5ua3diEYpv3cAl5FBXtGrPdsacS2gea0N
	d2sHA3+XBw==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 46j0aahxd2-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 May 2025 20:28:03 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JuLIZTdxo7pT7/msFyDj7mG0ARKLkIKW3RkMlodrSw2qFa6NbnmsuOwedl1lapNjHnDld2k5ZB6XfOX/SjVS0knrTAwFHmJcX12GWJU7yMFl6zSJCVzdpDB6mshAqR4vrbjZ+/4i4Rp2NsziFlVwgR5pQaQUzGbQByKkzs1Kvf9nN9zPFfUZvefVvrFfN76kgh/QXtcRBxYBMulMFfNXXmETijy2TvNo/FGDzJHYszezgGGpxqUHQkIoBpTcBGrGmiafB2D4z3I2i69sHGwaLPnsEubo3nNl9ILThLEwMNSwgTnjSMH8DLxb03Uw/zAqBLWnrSy0raN80ezdBUUadA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUmW6Z9NJh7Framw2XmyIpfMBUt+ypWSE2hLnuZfHWI=;
 b=s3hP8LpK9xlrNZVhOjuffKLtEOp9olTXb4WJ7Z4fuI7OcHJtF+X9wmh4lbEgZWu2i91MUBtzt46WXqynVeJHdQofSklo/euRSZnHjlTvka2FxPOghfQq0acaqaWq6QfF/CHPEUDeFDcJAWbUpnqWPq5/OVVxrbBO+JwLfXEQVkOa9wlQiBzcfFQxt8fRvCCZ/7xtO4ujarUawlbK1+eBdX0uxSCT0C8rUiiVDURtpicc3fUUXMyim7y1zbR3MGa5ggbOTTbmLfY7uIoEfw1DwjttauoeCbAEUgt73FYiQ3jRoaXZ3Oq4eIV2kNRS3sSxhO0FLSyrTttoU4PIGIRlfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUmW6Z9NJh7Framw2XmyIpfMBUt+ypWSE2hLnuZfHWI=;
 b=VUNnfbylhGnlM4yDREfc3LG1sHM8pRek/zsVEKju0jkCdb3oECHDXS7MR4RCAPHm7K3ajU54StVFoU1Cm7gx6Yy2ol/s9jztnngcziUYo+DT5nNkrhWcAdRvfRJNDBkyDaF9Ltgysb8C2bVbOgFLAfYETuueYtUDG45/fr0Lzbw=
Received: from DS0PR11MB8205.namprd11.prod.outlook.com (2603:10b6:8:162::17)
 by IA0PR11MB7953.namprd11.prod.outlook.com (2603:10b6:208:40d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 01:28:00 +0000
Received: from DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a]) by DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a%4]) with mapi id 15.20.8699.026; Mon, 12 May 2025
 01:27:59 +0000
From: =?UTF-8?q?Damien=20Ri=C3=A9gel?= <damien.riegel@silabs.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Silicon Labs Kernel Team <linux-devel@silabs.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC net-next 03/15] net: cpc: introduce CPC driver and bus
Date: Sun, 11 May 2025 21:27:36 -0400
Message-ID: <20250512012748.79749-4-damien.riegel@silabs.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512012748.79749-1-damien.riegel@silabs.com>
References: <20250512012748.79749-1-damien.riegel@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0451.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::17) To DS0PR11MB8205.namprd11.prod.outlook.com
 (2603:10b6:8:162::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8205:EE_|IA0PR11MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: 6601b3e7-2ca7-4cd6-385b-08dd90f43b4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjcyY0dNWUg3Q3M5eW5KYjVKZVpLRW1mMElkOGM5MjNPOFc2UWxkVGY5WWVY?=
 =?utf-8?B?SzhJSlN2MEc3U1BTNXhiblpLRHFCNTcrZjJOOEhXa0thODgvQit4UnJhRnlG?=
 =?utf-8?B?ek5EQnA0Z0ZTUkxkcUo5a3oyUDZOajNGSXRRVS9sU09aMC8vMnMzYVU3ZFVs?=
 =?utf-8?B?c2N6QzVjcW9sWmR2RVlmQjJlMURmNnZRTVZGRDRTenJJK3VXcGxRMVJEUTB3?=
 =?utf-8?B?bXU5dzdFMEJVOS8zaFh2SE5nNkdjZzNlcDk2bkZBRDNwaWFNVnhtR285bHBY?=
 =?utf-8?B?bm1QRVRBS1lBTWRPbFFpSmdiM0M4S1hLcXVhTTVqMkxNeWlnN0VaRCttMXd1?=
 =?utf-8?B?UzhpMHpNekloTjVZckpVd0RDVjc3M25lNHVZQnp2ZzNzN2xWR0NnRkcwc1lk?=
 =?utf-8?B?OWtDcDVNR2hXUXRZeitlVUhCOTRYdzc5V0V2dHF3NFBPa2JGdlRBb0J6QlJX?=
 =?utf-8?B?YzJZOUlBTmRIV015VXduc2RHRitwYlNvTDdmRWFLMFhtOHRyZUY1a2FLUzVD?=
 =?utf-8?B?dFozVkU2dGU4Q3NacXNtbnpUNkdodXpHWW9KZ2dUbVNjWVVOeHh0TGRtcDNX?=
 =?utf-8?B?RlVZV2c0cmpxbm9kTjV4UUdTTW9iVEZPRS9tbGxtZ2JCN0RrcWFEZ3duNEVY?=
 =?utf-8?B?VGZVZXJaZWJYTHJtcFN0MHd0NW1tRUt3MFZFaGdDQWUrQlBsVU9YOEZCUHJW?=
 =?utf-8?B?MXB4SStaUkpoVHFzVjNFOFVqdHp0NXNyTXlnWHRRM21zZGowUmsvR3JPTzRE?=
 =?utf-8?B?ZnAyd2dXNENUcHZISEQrcjVyYnRlSlBjci9mRjZIUFhWeWRoamhobGQxMUMr?=
 =?utf-8?B?SHQ1UEwyR0laY0d3cVUyMWRLSmhNRFdTM3hwWk5XbHNrc3pwRC9XTW9Cdlls?=
 =?utf-8?B?MTFzOG84blJDbklHNTE4UmFNaGdaWXlTY0pFMU9lYmNXbWQyV1JjUm1hWGRv?=
 =?utf-8?B?bkNpU2RGb3ZRSEFGZmhMNUphSVNnektqdWk3SVZwS3FNY2JXSWliV1dFZ2NU?=
 =?utf-8?B?aS8vbnA2RkxxMjhXK1cwNnE4cWtHenRKWW9NTmxUaEREbGcvd0RYV01MUko3?=
 =?utf-8?B?bk9vNFBPTk5EcFJyRnByUXdRMW5acS9nVkFreS96OTVnUE9pM1ZSVGFnMlFz?=
 =?utf-8?B?WnZpNEhTUFcxSVk2REdBUlpkc2o3UmZzVUhZRHp4WXlGQ2RkSWVaOXprSjVY?=
 =?utf-8?B?TURqVUVrUHI5MnRPeTA4T25MWHU5UFhJMCswUHNURDdMNTcyYVNBUmViODRk?=
 =?utf-8?B?aGdRYkxyQTM1bzhXaG1ON29WYU15NFA4VmltbjAvOG41QUFnbUhUNEJqbFVK?=
 =?utf-8?B?QzhXZ1M2RC9hQTgrQVlxekxKQ2Ftc1RBMjNGTFM5R3d0NVQwWWwxUDNyd1A3?=
 =?utf-8?B?dXN5c3c1a1hZVUQyZWIrR1dzK0duSDYydTRkZ2NERGlMQ05LMEFzQk5aUkJP?=
 =?utf-8?B?QStHWHlpNWpTUjdIVTVKSy9JM0pxUUcwMDJvbU10MjZ3dFAzOFlsUS9lS3BM?=
 =?utf-8?B?SWRmblhYRXVUZzJzRmR2MjF5d2t6NHJsV0xDNXNuVzkxZ0Q2bjk0cjREdVFv?=
 =?utf-8?B?S0p4alJvYTRqQlMwcmRPWURBQSt3Ymt0ZmRtby9mNVpBU1ZFZzNja0FiL043?=
 =?utf-8?B?Y2gxTDg0TWVJQUhsMGMwZys4VDh4NG95WkNXUm1vODB2RjlZUUllNjhhUFkx?=
 =?utf-8?B?bmNSOStaVWJkNkwxc1RtY055OFV3UitxSTlEbDZaUnBQc09hdTl2aysxeno3?=
 =?utf-8?B?bWVhUFpjbkRpbWFxN3VObzA3NmdHZ3NwSzRDd0ttbnRVUEN2T2drbk5hRytt?=
 =?utf-8?B?YXdUUTRhVmtBSEtnNDhaOFlIdUMzK3BzUHlBNmpOMktwOE9zRFFBU2tNMTFz?=
 =?utf-8?B?bVF6bjF6dnNRTFVPVHVCLzNYaE1rWG9oUC92WWUwL3I2cVk3TERyYlg4L1ho?=
 =?utf-8?B?cHdnSm5MdjVqeTB5ZGtnckk1alZ3UzdZR1BHZ2xsME5QeHJ3MEdhR2JSQjZY?=
 =?utf-8?Q?eEkQNVEOJZXCFHg4mhuUVBYTz06tJU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8205.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OW1QWVk3Vy82Z1JtQXVpL2JBZTBTUm44c0N4d3BYVzlJSGtFNXZEa1RUTFZt?=
 =?utf-8?B?K3JxQlFQbUFVRG1LWDNoMWV1aDJwZG5qSUpLOU9BK0dSd2tMUEllczBFQUJ1?=
 =?utf-8?B?UnNDczlSWGFIRFo4dS9ud0ZlcXVsZGRIbW5NQlQxRXhaMWxvSW9EZVVwcHh5?=
 =?utf-8?B?d2xFSDUrWVgwQmlKSWsrbFE4eXFsNU1IZkJCd1pvWktEUXVjTmNROU1sRUpE?=
 =?utf-8?B?VHFKNXJvRkxIR2lUdzFINklDUkszcmlFbjcyUEtvbEtIT2tiNEFVTlBaSHdO?=
 =?utf-8?B?L1JtWWhDYlZVT2Rla2VicUFlblJQVlZLUmhhSkVtR3g5NVZRMG14QUN3bUpK?=
 =?utf-8?B?dUI1S21vb1RuRWgrUG5XV0FrWjFVUFlDMkYwU3F3ZmFuVVZnVkhjeE8rQlFZ?=
 =?utf-8?B?eHk3dUdGMjA3VXNYSnprS0VYMDVIRW5pYTZZSjNwTlVoVlA3Q3NrckVETEpQ?=
 =?utf-8?B?bExScWxxaVIrRHE5c1poemc1NkNTZ1hHOCtpdG1SdEhTY01HVm8rdm12R251?=
 =?utf-8?B?a1FEbHYzVG9RK2RpUVp0cHZGc1ByZG9vbmFiYnZFaWtqL1RMSXMvNEdmanhV?=
 =?utf-8?B?ZEZ2eDVHbS9OWFpFTEhraW1OSS9xeGJ4YW9KeVFseTRRWDhkZWZ0cEs1UTNU?=
 =?utf-8?B?TEtFTHdEQTlTa056ZU9KajR4NTVOR2hDVEY1VHI0QmxWTzlBYUtGYWZ0OCtV?=
 =?utf-8?B?YnY5SmhkYkpUNXZ6VlhHcy9RcXMyQm9LQlBvUkh0ZWk0MnJJaW9TNU93cDRL?=
 =?utf-8?B?YW9sS2h1QlpVaWFoVW5vdTQ1OW04TDhNVEhYUWpUTUZwSjRPdG9vYjFBQy9P?=
 =?utf-8?B?L3R4TWJFS0Q0bm9UTmZnSDMvMU5Fc3VxdkRaK0NpYkp1OUZGMStYcFZRUDdG?=
 =?utf-8?B?MDdDQ1p5ZlFTTFVER0JNOFBGcDZxOGw1aGN3anVPTzZ0UWNvZ3lvWmRrdXg1?=
 =?utf-8?B?V1d0Yzk3ZU45TGxDR3F0cnNpOGR6SC9ZQkQwV2dQc1BTdUZ5WFJaUHErRE9B?=
 =?utf-8?B?KytoTHlGUktoT2xXbGZrY3g0TytiNTFwN2JEM2k5WUpNUTVIWEtYMFJvck9M?=
 =?utf-8?B?OUViYzUzSlplYjh4L1JFTmlpQW9MSnpuTC9qV3pIRFBQSFU3YW1LUDZCQW1q?=
 =?utf-8?B?TW1qZ0xCUHQzZGVEWVpWbG14N0tIeisxY0l1c0F6ZXNtQU82UmZoRXgwSFRK?=
 =?utf-8?B?b1R1YUYzeXg0RkY4VHoyams1ZmJseHJoTDIzdnR4MEpFUGthNWs0cmlZRnpH?=
 =?utf-8?B?dlArR01NdXFYalcwMnhPRm0yWUgrRGE1UnQxTUNQaWtEbzd2aXgyem1uOE45?=
 =?utf-8?B?OU5RZ2k3NGJ5TkNwWVBaVWppTm16M09HSWNCR2tqZElEQTcvR25xdFFlQzBE?=
 =?utf-8?B?c0pMd0hWdjRpdC9DdnVLQ2RCL1hQZmRuNHZZVE1iSHpzZGdCcDBzeXhWQmRX?=
 =?utf-8?B?UFFLeTVIRUhaZzNnNExCSnI2RW5EQ3FaOXBVSjF1VnpLMklpSnUyeWZPN0xE?=
 =?utf-8?B?SWZ6eWxhV0VzWEY2dUVoZm1saXpMcTdBUnE1bkhOeTJYZXlVV2lmNXk2MXYz?=
 =?utf-8?B?MTBTc1pTYU5Zc01FQ3lGOUlmaGlRMFVNeDlCbzZJQW9Wb2I1UEhTcDlQVG1z?=
 =?utf-8?B?TFJGQ3dTUGdjRmtwUTluKzR2MVhYSmNGY1MvZUo1UkhnenduY3lxdExOQS9E?=
 =?utf-8?B?bWc3M2IyN0NoRXZ6aytXQ29nR1BZMGhCUEZXanJsSmdXeHFZSjQxOThiREM3?=
 =?utf-8?B?Tk9SV1NEcktka0FSZXlWQndJVno2a05qNGcrcmNXS3NLNUU0dENrQmdia0U2?=
 =?utf-8?B?am1WK2R6QUkzZFA1a0puQzlJTHVTeHlSQmxiMUF4VndiTUtHcFYxOEFGNzRv?=
 =?utf-8?B?U1ZjbFBGWUVxbEJJWW5QdElpaHBxVWphOTlnbllkbDEzNHhRZmVJYmJoV3N4?=
 =?utf-8?B?MTR4RkdpZ0p2MnhlL1l2cVViY1VGZDU0TGlybHZ1dnpiSmN2czI4NC9DYXhs?=
 =?utf-8?B?bUhKeDBicEpaU2l3MllSQlhDakhmVnhMTVd6dmFnRWlnM1EzWW9TQVB0ekNH?=
 =?utf-8?B?cU92dlpRQW9EN1ppeCt2aUt0RHNJd0wwQ2JVdHVWc1JCNDRaLzNJRVphWGcw?=
 =?utf-8?Q?XGweXOyAsWwPf98Z7xzDncbcm?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6601b3e7-2ca7-4cd6-385b-08dd90f43b4c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8205.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 01:27:59.9013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GCanxWBuBgrxMD1ku3e/gr3njaWBT6EhOkxKaqfX7mNtHpx1dr3Nude1vyi+LKJ2lZDwrME3rhyJoFxAZ3zsFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7953
X-Proofpoint-GUID: LfvRHbvAFiDY8c0CLt3UixMGe2FuU66u
X-Authority-Analysis: v=2.4 cv=TMNFS0la c=1 sm=1 tr=0 ts=68214ea3 cx=c_pps a=gIIqiywzzXYl0XjYY6oQCA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=M51BFTxLslgA:10 a=i1IsUcr2s-wA:10 a=2AEO0YjSAAAA:8 a=yfPTFhKnZHbw51aZTvwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: LfvRHbvAFiDY8c0CLt3UixMGe2FuU66u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDAxMyBTYWx0ZWRfX0QEACopkYO0I mbh8wwK+oEOLzPWW3GD+osLPThhu6jaiXCjQPURSEYl1KW+N/zCivrnxs9+LvxNbV7LI59vCPk/ /JjVn1k9iipWd3A4RhKw96+lIpY47koWYzddTSnMZ7iPTaTO6OsqQ849Q9jDICZ9pDprJ5jDX2G
 AU05GudL3J3Gz4/IS1wRL+etc7fxh0HC7JxHr8SDRnAZsI2T0vLgySqFpPKuPyHS193km4nQwRT OweRYIeWhzYlpI/RWHDymo4a00I7kefHrTSyQVJa+iFX1MlrWlDHNIKKohqJLhbjdL1NZ8NRqj7 K+PKdfjG02qOIw1FbbTK/9UGkrHsSYDhNCcYGxqbmqtJNtY3FTgFH1C9zCZbCEKPqG8KJf0llCc
 kQ88hNDyiJfR6rnLyAzPZ3sfpJBPaV/PbKiZ6Ra58nPkcRGzcp4bIkKzBmonq0T/5GaYv3RS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-11_10,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505120013

Endpoints by itself are useless if there are no drivers to use them.
This commit adds the final bit of infrastructure for CPC module: a new
bus type and its associated driver.

As a very basic matching mechanism, the bus will match an endpoint with
its driver if driver's name (driver.name attribute) matches endpoint's
name.

Signed-off-by: Damien Riégel <damien.riegel@silabs.com>
---
 drivers/net/cpc/cpc.h      | 39 +++++++++++++++++++++++
 drivers/net/cpc/endpoint.c |  1 +
 drivers/net/cpc/main.c     | 65 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 104 insertions(+), 1 deletion(-)

diff --git a/drivers/net/cpc/cpc.h b/drivers/net/cpc/cpc.h
index 529319f4339..cbd1b3d6a03 100644
--- a/drivers/net/cpc/cpc.h
+++ b/drivers/net/cpc/cpc.h
@@ -15,6 +15,8 @@ struct cpc_driver;
 struct cpc_interface;
 struct cpc_endpoint;
 
+extern const struct bus_type cpc_bus;
+
 /**
  * struct cpc_endpoint - Representation of CPC endpointl
  * @dev: Driver model representation of the device.
@@ -98,4 +100,41 @@ static inline void cpc_endpoint_set_drvdata(struct cpc_endpoint *ep, void *data)
 	dev_set_drvdata(&ep->dev, data);
 }
 
+/*---------------------------------------------------------------------------*/
+
+/**
+ * struct cpc_driver - CPC endpoint driver.
+ * @driver: Internal driver for the device driver model.
+ * @probe: Binds this driver to the endpoint.
+ * @remove: Unbinds this driver from the endpoint.
+ *
+ * This represents a device driver that uses an endpoint to communicate with a remote application at
+ * the other side of the CPC interface. The way to communicate with the remote is abstracted by the
+ * interface, and drivers don't have to care if other endpoints are present or not.
+ */
+struct cpc_driver {
+	struct device_driver driver;
+
+	int (*probe)(struct cpc_endpoint *ep);
+	void (*remove)(struct cpc_endpoint *ep);
+};
+
+int __cpc_driver_register(struct cpc_driver *cpc_drv, struct module *owner);
+void cpc_driver_unregister(struct cpc_driver *cpc_drv);
+
+/* Convenience macro with THIS_MODULE */
+#define cpc_driver_register(driver) \
+	__cpc_driver_register(driver, THIS_MODULE)
+
+/**
+ * cpc_driver_from_drv - Upcast from a device driver.
+ * @drv: Reference to a device driver.
+ *
+ * @return: Reference to the cpc driver.
+ */
+static inline struct cpc_driver *cpc_driver_from_drv(const struct device_driver *drv)
+{
+	return container_of(drv, struct cpc_driver, driver);
+}
+
 #endif
diff --git a/drivers/net/cpc/endpoint.c b/drivers/net/cpc/endpoint.c
index 5aef8d7e43c..98e49614320 100644
--- a/drivers/net/cpc/endpoint.c
+++ b/drivers/net/cpc/endpoint.c
@@ -48,6 +48,7 @@ struct cpc_endpoint *cpc_endpoint_alloc(struct cpc_interface *intf, u8 id)
 	ep->id = id;
 
 	ep->dev.parent = &intf->dev;
+	ep->dev.bus = &cpc_bus;
 	ep->dev.release = cpc_ep_release;
 
 	device_initialize(&ep->dev);
diff --git a/drivers/net/cpc/main.c b/drivers/net/cpc/main.c
index ba9ab1ccf63..dcbe6dcb651 100644
--- a/drivers/net/cpc/main.c
+++ b/drivers/net/cpc/main.c
@@ -3,16 +3,79 @@
  * Copyright (c) 2025, Silicon Laboratories, Inc.
  */
 
+#include <linux/device/driver.h>
 #include <linux/module.h>
 
+#include "cpc.h"
+
+static int cpc_bus_match(struct device *dev, const struct device_driver *driver)
+{
+	struct cpc_driver *cpc_drv = cpc_driver_from_drv(driver);
+	struct cpc_endpoint *cpc_ep = cpc_endpoint_from_dev(dev);
+
+	return strcmp(cpc_drv->driver.name, cpc_ep->name) == 0;
+}
+
+static int cpc_bus_probe(struct device *dev)
+{
+	struct cpc_driver *cpc_drv = cpc_driver_from_drv(dev->driver);
+	struct cpc_endpoint *ep = cpc_endpoint_from_dev(dev);
+
+	return cpc_drv->probe(ep);
+}
+
+static void cpc_bus_remove(struct device *dev)
+{
+	struct cpc_driver *cpc_drv = cpc_driver_from_drv(dev->driver);
+	struct cpc_endpoint *ep = cpc_endpoint_from_dev(dev);
+
+	cpc_drv->remove(ep);
+}
+
+const struct bus_type cpc_bus = {
+	.name = KBUILD_MODNAME,
+	.match = cpc_bus_match,
+	.probe = cpc_bus_probe,
+	.remove = cpc_bus_remove,
+};
+
+/**
+ * __cpc_driver_register() - Register driver to the cpc bus.
+ * @cpc_drv: Reference to the cpc driver.
+ * @owner: Reference to this module's owner.
+ *
+ * @return: 0 on success, otherwise a negative error code.
+ */
+int __cpc_driver_register(struct cpc_driver *cpc_drv, struct module *owner)
+{
+	cpc_drv->driver.bus = &cpc_bus;
+	cpc_drv->driver.owner = owner;
+
+	return driver_register(&cpc_drv->driver);
+}
+
+/**
+ * cpc_driver_unregister() - Unregister driver from the cpc bus.
+ * @cpc_drv: Reference to the cpc driver.
+ */
+void cpc_driver_unregister(struct cpc_driver *cpc_drv)
+{
+	driver_unregister(&cpc_drv->driver);
+}
+
 static int __init cpc_init(void)
 {
-	return 0;
+	int err;
+
+	err = bus_register(&cpc_bus);
+
+	return err;
 }
 module_init(cpc_init);
 
 static void __exit cpc_exit(void)
 {
+	bus_unregister(&cpc_bus);
 }
 module_exit(cpc_exit);
 
-- 
2.49.0


