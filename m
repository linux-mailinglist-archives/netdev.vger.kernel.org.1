Return-Path: <netdev+bounces-226150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA78B9D026
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 03:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDBF61BC29AA
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 01:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8D92D8DDA;
	Thu, 25 Sep 2025 01:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="nWZrVpPt"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4AD1F95C;
	Thu, 25 Sep 2025 01:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758763479; cv=fail; b=mws6oyvVkr0zxfPwA7TylnFOtROHwwE4yGuMKhSi91QT5MBP/inyhGDhraZxJgiLagyZWCYqqbtSoE1ucGqSTLl5IV/pjttjsIYnhunVFjQuDNnrwdIbtazfY1M+J65iuustRCmfJByhjrc/oIEROM9vFJmg+Cc/aUjIfh0Yo6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758763479; c=relaxed/simple;
	bh=U3TEKn3WIbP4ft0ml4zda8qdV9yM+GO1ywkQ1cleUE4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PHRWpdtlKUZP9/b32ULwUXvcMdnWaOZaW2vL6UZNWD1BGZU4QXblV2WnuO+IM/2nZW8rv59pv+B55kagA2L05Ht6ut2C9EvdTH0OqMxS4FYy9pSaZK8gNEKoyulj8QKuA3zOcGLhS3A4UvTePovN19nOM6On8TgrgeSJ1yKTC7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=nWZrVpPt; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58P103VX2300111;
	Thu, 25 Sep 2025 01:23:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=WX8YVmK8dl/FtlCt9nuNm3/sA+DiPZZwPjGfLmXoC7s=; b=
	nWZrVpPtE9Vkv9U3NU/S9qyayN9dnOmTf/ZBq+VTFr9rvpI0uxDSk7LSbs4YQDTS
	dK/ESldEo6LylBszfQWcfKKGg/e1xZ7vIeMW/JmWbg0G76z8YCQXwSSXn/yOruR+
	OQFqvN89QQABMih96gLNIXUzk17c0DNXKKMnX3g34rqI1mK09EzPXP6/S17o9OZb
	9lceC0kanM6iXrBgeik/1zLfUILUog8sXRzO1rRM6Bhv+4KB3BZkdX7UJJishach
	OqtBxltb4g9t/aS31ORjGi1XEZF6MIx5XurLXP1f2xJ49/vI/ICz+mlF5rcMgH6o
	BaxvyT0k43qumjN/m/sw1Q==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011002.outbound.protection.outlook.com [52.101.57.2])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 499hg1nrey-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 01:23:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TcfwTNiLb+JAzRId7mjfz/GXGFzZY8ANGMwsxt0UeZtgwIpRVJYAnCQCzItOutRiLPKsWF95G4S8VhD/TS6RwwCMPuSpT5zaQS6M8F29zX8oNyfIOaRJa03DLjvEwMv5XeZ+iilayg3WrbkRWkIh+QF5nw6//GINvcaQutVB0bJivWU43nLx0D2wKFsE9TUjJSUNPhcqUr0SqGHsuv/LR+GJV1p2o+3UsYJEib424PmgNt+YEXQzgtptIU8cv8zCj8cXEgRDI6rNYGLRSt3YxxVomuEXjuggjKy8cQl7fW7URlc4XLaz73i5GC21/+rS6+cxHQALtmTr4+6IDtpVAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WX8YVmK8dl/FtlCt9nuNm3/sA+DiPZZwPjGfLmXoC7s=;
 b=jXp9xg7kQTEINXxh1YLAV7pcbR3HiFc/0mFsFhzcsLF7cbA2gvhTyCZBN9xwKBt/QiYlFbQ3ZXyX/CE8RAn885rEPuvWdw9Sulgna0LdutPq7QSdujyrT26LCaq2Wk8u4qPFPYz6Uwp7bToO1yNrJTARbmT0WUoWeQs8B0bxF0WiYb130zzMjVOjEwCqLbbZUt0XFDsK87Zv4ytWL2i4dlsVwcm7o3uBRsu/k68toDfY8QjxNxzjw3hgJODLYrjKEji1UP4s/5Aj+t3RsQNMSv6KfHxq3EHMg2ZGUiLNIjStjGfHkC2XSMrSa679Cg3GIA3lC3Q0rPmsjsVS9lem7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7736.namprd11.prod.outlook.com (2603:10b6:8:f1::17) by
 CYXPR11MB8662.namprd11.prod.outlook.com (2603:10b6:930:de::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.19; Thu, 25 Sep 2025 01:23:57 +0000
Received: from DS0PR11MB7736.namprd11.prod.outlook.com
 ([fe80::43bf:415d:7d0b:450e]) by DS0PR11MB7736.namprd11.prod.outlook.com
 ([fe80::43bf:415d:7d0b:450e%6]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 01:23:56 +0000
Message-ID: <37c6ac9b-305d-42a1-984d-69f19fc44112@windriver.com>
Date: Thu, 25 Sep 2025 09:23:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: enetc: fix the deadlock of enetc_mdio_lock
To: Wei Fang <wei.fang@nxp.com>
Cc: "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Clark Wang
 <xiaoning.wang@nxp.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com"
 <pabeni@redhat.com>,
        Alexandru Marginean <alexandru.marginean@nxp.com>
References: <20250924054704.2795474-1-jianpeng.chang.cn@windriver.com>
 <PAXPR04MB851022A10BB676DBCEBF66BC881CA@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Language: en-US
From: "Chang, Jianpeng (CN)" <Jianpeng.Chang.CN@windriver.com>
In-Reply-To: <PAXPR04MB851022A10BB676DBCEBF66BC881CA@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0269.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::20) To DS0PR11MB7736.namprd11.prod.outlook.com
 (2603:10b6:8:f1::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7736:EE_|CYXPR11MB8662:EE_
X-MS-Office365-Filtering-Correlation-Id: ba75aabc-beee-4d8c-32db-08ddfbd23277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnhCNnd6TzZ2SHJrR1dITnladWFoa3ByM3U0NlZReTNYclFMOUp6QXk2bGNF?=
 =?utf-8?B?VlhMNVdWUURwY0pTVHdiSGlUTVdHaXJtMEExcTRxMU96cXlyRzB0TEg0R2dL?=
 =?utf-8?B?RnBJTk9EZWJ1ekhzeDVGeVZqei8zV1ByUmovNFVPaFJMaUpDbC9MU0JuNm0y?=
 =?utf-8?B?cUgyc1lXUGU0eGQrZUR0NGZ6MDJhNithbmtkV0xFSktLZVh0c0VUdWxBUmIy?=
 =?utf-8?B?ZDFuSkJQaXJIcnpUdXJMejhvckxQVW1xeGw1TkdsRXIzbllIdmZtZldvTkcx?=
 =?utf-8?B?YjBEbkJybkpBTU9Vb0NQSi9QeTFWTDNhT1FQTUl1ZXpyMThQMFJFWS9aTjdE?=
 =?utf-8?B?QmkzUFlxQXowUEQ1eVczNldNeDRPWDVZVmRsN09kVUl1cnhnMFFnT0I5bm9B?=
 =?utf-8?B?NjIwcDlDWmhERGNrdDFlUHdZczhWcy9UM093cmJGSExYUFJXMmlldGMvaEh3?=
 =?utf-8?B?YlZwcWxlNkZTZ3R0SThuOGhETkk3TVVFQ1JVTGpwdVlGMjArY3UwUHdTTHlz?=
 =?utf-8?B?M2hhUExaWFlXK3hEc21MU1ByUUdrSGJnS3dGUEQwSVQ0RkVDN01sdGdXczVq?=
 =?utf-8?B?VDVBNHFKQjVZNklmcGZ2UEtzQnk4Vm5VNmVsTUNjNWZZU1hLcmZDUy9JTUc4?=
 =?utf-8?B?QW5TTVhkZVJRTGpHVXNndlVDQzEzanZ6SEJMUFloZG5QdW8vR1M2cXVRMnpM?=
 =?utf-8?B?YmwyNVFMcU9obDJML0tad0d2b2tCSm5SRkxZRjBnSzJiT3hQMG1wK05lZ3RJ?=
 =?utf-8?B?aE9aRUFqUkZ2RGw4emJ3MUVZS3FaY214ZG9DL05SNWo1MFExOXZJcElNTE92?=
 =?utf-8?B?N09OQnAvdko2WkpId2ozM1M4MVpTVmNmai9WUHdDVmU0RzVmZHRwYU1FZnh1?=
 =?utf-8?B?KzBiT3R6UjNvK2YwaWFtcDhYRzgvSCtJRmh0UnA4bFJkckJWM0xwdHhjN0NE?=
 =?utf-8?B?RXhVQzgrSytkQUp2OG1QYU9EWGxXSGdxNjJWcVZvV2tmcEpOd2ZSK2t1RnJt?=
 =?utf-8?B?QnpQcTVTOWx6TjJJYngrd1JXZ0Y4S2xkekdnd3JOd0lMM3VrSHlNZjgzTWda?=
 =?utf-8?B?N1JxSjYxT08rMmorTm5zUURLTSt2NEFMV1ZxSXdWY2VvOEx5L3pYUmEyN2lr?=
 =?utf-8?B?OGE3blFIRGlJeUorMmpxUkhFenNFUndFbFJLeEtBcmpBUktVOVFZU3oyK3hN?=
 =?utf-8?B?bDVwMDdBUURhWmsvTXZNT2V0MFl1ZUlpZlh5YXN4bm9RZWRpS1RROFJNbFAv?=
 =?utf-8?B?TWc1SGNacE5FaGdGbUhWMXVYQW9rV2tNd2xWL1hRRlplMW0rM0dzY2FsbVdn?=
 =?utf-8?B?dkZvdHNORlNzUDQ2dGNsU1g1clY3Vkg5UXQ0SE1KWTZ2eVA5cFBkK1MwSWdp?=
 =?utf-8?B?OHUvcUtxUXlLSnF4QUtMRWFHclZWWGpxb2RrSkN2aUtabzRYMnVPNnFSak9Z?=
 =?utf-8?B?eHZLbGNrY0FsdFI1RUJFeHVXL1k0cGJqMXE4d25qSCtaUzZJVnd0QWJwd3Vj?=
 =?utf-8?B?NTlyT2NPTW1uR3ZtdnliYXpQNEcyaUJKckVaTFJNZ09nTGEycUt4ZHZFN0tT?=
 =?utf-8?B?MjFLRXFIMVBBci9KNDIwNDJ4dDlKZk03ZmZCcmZFdWxnMEYrWVYvbk5xU01m?=
 =?utf-8?B?TWdYbnE3N3htYlR0Tlk2NGFHNVFJMU1semRSSWRiMFRhNmswdTBLazNKbGxr?=
 =?utf-8?B?cUFpN0MxN0JFZm83Y3dQMSsrTk01SmxGNFcvSHBhc1Q4ZXl3MnNuRWhON2N1?=
 =?utf-8?B?WTVQRHV1bXpkNFpXU1NqK0RvQnhGVHpxSVlLKzRNYVNjQmMySU0rdG9LOTJp?=
 =?utf-8?B?amtHLzhrL0dKQ00yaTZjbHZ3MHZyR2FDUUpFV2JiaFpWZVJHYjc0OUtNVThs?=
 =?utf-8?B?RTZML0Jxd05sRXIwVkNuQllYT054YUhsOThDQTVDREhYSlJ4bVd6d1VheXlp?=
 =?utf-8?B?TVRoWnU3bHAwQkdwMWpkbERxVlNwNE4yajI4SGcrTzdGYkVPdk1QcmlxMFFh?=
 =?utf-8?B?cjhnV01PeHVIZWlKbjltYWtBZVZLT2k4bmE3aHg1ZGM2YUFjNUpUM3UvUEJX?=
 =?utf-8?Q?EjI7C6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZE10dkVYZTFmRkJlVDN6U1VXNEhVbmNsdTg1QnUydUE0YWcrU3B0VVRaYjMr?=
 =?utf-8?B?clVHeDJvNXo3UERoUHpOUXAvaXJKNGJuN2J4a2FXRHpOWVNNVWc1Z0FKNi85?=
 =?utf-8?B?eTZ6SzBBbUF6M1l6a1lVajRoRElHNUFNVUFRcGFGTWxhSEpsdlp3K1VhSzhQ?=
 =?utf-8?B?UFkydmlQS0c2cmdUWGRTMTIyY1V5djJhcEdrME5oMzh3RWpRRk9PdHZFbWVQ?=
 =?utf-8?B?MVRJQkM1QjNpUTZOZUhUMU0vb2FkdUdlSzllM2hVVHJwV0lSRVZCNkQyZFNq?=
 =?utf-8?B?UnVzaDNHQWJvQmQ0SUVmNVZXUkRhQUJldVN6OHZxdzNXUDYwWjNpdFlzM2FZ?=
 =?utf-8?B?MjBVOTVPY1I1WXh2dE1scVNiS2IxOVNvK0lHV3gzMFBiSUxyUTUxRk9KOXNC?=
 =?utf-8?B?ZUxJOVRRT3JRdDdOODBlcEZRZ1cyMGUyWllYeEx0TFY5TFYyREdyQlBCQUli?=
 =?utf-8?B?bGNPcFp5Y3RkZEVHVGJndXhzZHNLNi9Ed3dodFpXVHlLQXFVM1psalpPWUFX?=
 =?utf-8?B?VTUvUEtjVVBYWmttMVZMbWMrL3M2TmxrdmpBSDkwWldUSVBLeFZwcjVwdGoy?=
 =?utf-8?B?VFFENHRiNE5td09UUlFrdVVrUlBIRnI4b2UxRTJFWHF5TEZEVlZhYnJjSEp2?=
 =?utf-8?B?MFhiSCsvb0haNUIrU2FrUmgvVTZBMmRXMkpvOTNFSUN4ak9YWjVrTldBSkU0?=
 =?utf-8?B?dDdpYnJ1Vm1NRDBFQXpCMFJNbFBqU0hxclJBcFNYbEFKMnZnL3RueDQ0Qk9Q?=
 =?utf-8?B?U2hoRGcraENXQXU4d3BEcnEyZ0RpWi94em0xRkUwTG1GdmVBcmdwOFJZcXZr?=
 =?utf-8?B?Tk5Oa3pYZDl2dlB3Y3JyTVN2TjdUNytsMVdzd2djMDhiWEdudkJXMSsyYThF?=
 =?utf-8?B?RjlUT3YvVHhXL292dCtFdVd1UWVPdnRJVnlJK0x2Vlg0b3I5Yy94TkpSRnNS?=
 =?utf-8?B?eXNKUXRDUlNyT3dJSnYyd0dUUTBwalF1NDNlU2JYR3d0ekVzWTZFWnhqTnN0?=
 =?utf-8?B?OUY3bmk1ajVsZjIvNlp6T09OQStYTG1jTktKZ1ZSSkF4c2pPbjRXd0xPWUJ2?=
 =?utf-8?B?R1hEODFJQnJkSytDc1N3c3IrMFc2Z3l1RXNCRHFhVWUrbjUzc0xtTVFQSnVT?=
 =?utf-8?B?V3RJNzB2QTJ3ZXpqZ1A0KzNpdm55ZFIxZ3RBb0hmN3hjRng2OHpWMmg1Tnc3?=
 =?utf-8?B?UHcrQWRVVVM3RjFIek1jVTVMeVJoejU3MGtJSHdxUDQvejdBRnJjUUU1K3dM?=
 =?utf-8?B?dHlRSlU0eEtYSUVrWGZIM2ZMWXVJa1RuYjRtVHVuU2pqUVJ0WGJPUnVrMUF6?=
 =?utf-8?B?Q0YrT1Y0Vzdzd0ZnZ0ZncDB1KzdrdExqNlI0YlhlRkpxY2pVa3JrbWhOc2Zw?=
 =?utf-8?B?RmxwYkRlK2RwT1liNnZ0QjBmNERSVnFENmdveVhJczlDVlBmNW14enN2UTYw?=
 =?utf-8?B?eGJtbnVNYTFpOG5RZXVqNTNOVC93OEsrN3RTK01zeFRURFRIS01vQTltdk52?=
 =?utf-8?B?Y1pkRmVRb0FrbjVOVzJJK2lyQldzVFZucUVjZGkyVVJxRDNOL2JmR3hIeStm?=
 =?utf-8?B?QVFkN2JiZzFYTTlBN1MvenlJTjR6V0NBZlc0ZnQxV3orUGpJSVRkeENNUTlz?=
 =?utf-8?B?NG1pdW1ZbmlmZDlISUJlUmRqVktlTGhsR291c3JjUTNoZ3NkQjhIUGlDZEhE?=
 =?utf-8?B?a2xCbWs4bm9kYk9pRUt1M0RwQVJsd3A1QkVpSVZiY3JXWC9MOGY1Z0tVNU9t?=
 =?utf-8?B?cG5VbnpEdkc3bDlzVGFhaGFmLzZic3ZBbXgyMTBSdUJ4aWZ0Zk5DSFdlMjdG?=
 =?utf-8?B?L3Y1RGZ6Y2VxdFU1Y2lxNkpiR3dtNnZFUjN4cUs4QWl2VGNYSDdTRHp4clYr?=
 =?utf-8?B?V1RLVkZmb0lPaDZCdVFnYWdxZFc3NnBnblF4dHdpaHlVK0ZPMWk3ZElicE1y?=
 =?utf-8?B?WHZTNjkxM1RHQTFSTWVzZFdEL0hUWmswU1hKYmd5a0tiVnkvcGhlc0ZmaGNj?=
 =?utf-8?B?RnE1UG5kS1liQVhBZHg5bnhSRHhrOGhnTUZ5S296WjVBTXJQSlQzME5lbUEx?=
 =?utf-8?B?MHdjdXp4YVN4cGc5TVJhWFJTV3dvMkZ5SWJOTlJ3YWJ0UEZYM05yYXFWbC8w?=
 =?utf-8?B?S0s1dWFyWkxPdDB3OGZvMmdVKy9qc3NEWGR2YlRaaDNqdmpuYVBmeUVHWWUy?=
 =?utf-8?Q?cSM2tAS+CtJEoLlzRe3I7yU=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba75aabc-beee-4d8c-32db-08ddfbd23277
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 01:23:56.6801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6nLbUJ0yfoUahcQ5bu1JeephpaPWosd1dQF7QQbBUiwgVJeWMsA/E6vsRWTedK8WAFVXnieMyi6Zgg6QFgwnJ3DcE9Bs2BUfOlw5GVUwD3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8662
X-Proofpoint-GUID: JwkO_ivSVzbcqZQeS8c7rTaeJ6a2NB5n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDAxMSBTYWx0ZWRfX9pUjOfmzqqNL
 UWXGuHwCOSHZGsGF52FaNEn6PBmtfMw1n//lkU1eE39c8mInp9xwDH9LTVucZqPV8Lrl39fR1ZK
 7S9AJxTE8YNurS0LJtzBZZr5jhx5y5Ye0XZxfp4ULNViDPwcZNwn4fY0Ps70VX9oxqlfcOk3bN2
 fQ4ZCPsux7dWLbMHhFulQKPD6JklVM7Z2mNbuL65NIAbwQ1jjBiUN5pvhqYgxLy0c0t0H+v1S5z
 F96w3WJiHgX4kKIHjQYPXYHyC5NISq71fSr6g3Dtb7kTyAiv+zxTHFg9hKaz6JkpmXNxTMu/8HL
 I771HDmWy2cK1ehWvvxJF2ehORJ4MteMhaJ47pCrKyCZdOuLodCqH3pR0fT0lw=
X-Authority-Analysis: v=2.4 cv=Yfi95xRf c=1 sm=1 tr=0 ts=68d499af cx=c_pps
 a=OG2go9lluqTXThMTGVaEpw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=t7CeM3EgAAAA:8
 a=QLvDvY4YCQuGIb2W8CAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: JwkO_ivSVzbcqZQeS8c7rTaeJ6a2NB5n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun


On 9/24/2025 4:39 PM, Wei Fang wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> Hi Jianpeng,
>
> This patch should target to net tree, please add the target tree to the
> subject, for example, "[PATCH net]".
>
>> After applying the workaround for err050089, the LS1028A platform
>> experiences RCU stalls on RT kernel. This issue is caused by the
>> recursive acquisition of the read lock enetc_mdio_lock. Here list some
>> of the call stacks identified under the enetc_poll path that may lead to
>> a deadlock:
>>
>> enetc_poll
>>    -> enetc_lock_mdio
>>    -> enetc_clean_rx_ring OR napi_complete_done
>>       -> napi_gro_receive
>>          -> enetc_start_xmit
>>             -> enetc_lock_mdio
>>             -> enetc_map_tx_buffs
>>             -> enetc_unlock_mdio
>>    -> enetc_unlock_mdio
>>
>> After enetc_poll acquires the read lock, a higher-priority writer attempts
>> to acquire the lock, causing preemption. The writer detects that a
>> read lock is already held and is scheduled out. However, readers under
>> enetc_poll cannot acquire the read lock again because a writer is already
>> waiting, leading to a thread hang.
>>
>> Currently, the deadlock is avoided by adjusting enetc_lock_mdio to prevent
>> recursive lock acquisition.
>>
>> Fixes: fd5736bf9f23 ("enetc: Workaround for MDIO register access issue")
> Thanks for catching this issue, we also found the similar issue on i.MX95, but
> i.MX95 does not have the hardware issue, so we removed the lock for i.MX95,
> see 86831a3f4cd4 ("net: enetc: remove ERR050089 workaround for i.MX95").
> We also supposed that the LS1028A should have the same issue, but we did
> not reproduce it on LS1028A and did not debug the issue further.
>
> Claudiu previously suspected that this issue was introduced by 6d36ecdbc441
> ("net: enetc: take the MDIO lock only once per NAPI poll cycle"). Your patch
> is basically the same as the one after reverting it. Therefore, the blamed
> commit may be the commit 6d36ecdbc441 not the commit fd5736bf9f23,
> please help check it.

Thank you for your response. I reproduced this issue while running an 
iperf test on an LS1028A.

You are correct. The commit fd5736bf9f23 did not introduce the issue 
directly. After 6d36ecdbc441

I find it somewhat puzzling that subsequent commits along the current 
call path have also introduced

problematic changes. So I write fd5736bf9f23 here.


I will address the issue with the fix line and incorporate all the other 
changes you pointed out in the v2 patch.

Thanks,

Jianpeng

>
>> Signed-off-by: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
>> ---
>>   drivers/net/ethernet/freescale/enetc/enetc.c | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
>> b/drivers/net/ethernet/freescale/enetc/enetc.c
>> index e4287725832e..164d2e9ec68c 100644
>> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
>> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
>> @@ -1558,6 +1558,8 @@ static int enetc_clean_rx_ring(struct enetc_bdr
>> *rx_ring,
>>          /* next descriptor to process */
>>          i = rx_ring->next_to_clean;
>>
>> +       enetc_lock_mdio();
>> +
>>          while (likely(rx_frm_cnt < work_limit)) {
>>                  union enetc_rx_bd *rxbd;
>>                  struct sk_buff *skb;
>> @@ -1593,7 +1595,9 @@ static int enetc_clean_rx_ring(struct enetc_bdr
>> *rx_ring,
>>                  rx_byte_cnt += skb->len + ETH_HLEN;
>>                  rx_frm_cnt++;
>>
>> +               enetc_unlock_mdio();
>>                  napi_gro_receive(napi, skb);
>> +               enetc_lock_mdio();
>>          }
>>
>>          rx_ring->next_to_clean = i;
>> @@ -1601,6 +1605,7 @@ static int enetc_clean_rx_ring(struct enetc_bdr
>> *rx_ring,
>>          rx_ring->stats.packets += rx_frm_cnt;
>>          rx_ring->stats.bytes += rx_byte_cnt;
>>
>> +       enetc_unlock_mdio();
> Nit: please add a blank line before "return".
>
>>          return rx_frm_cnt;
>>   }
>>
>> @@ -1910,6 +1915,8 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr
>> *rx_ring,
>>          /* next descriptor to process */
>>          i = rx_ring->next_to_clean;
>>
>> +       enetc_lock_mdio();
>> +
>>          while (likely(rx_frm_cnt < work_limit)) {
>>                  union enetc_rx_bd *rxbd, *orig_rxbd;
>>                  struct xdp_buff xdp_buff;
>> @@ -1973,7 +1980,9 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr
>> *rx_ring,
>>                           */
>>                          enetc_bulk_flip_buff(rx_ring, orig_i, i);
>>
>> +                       enetc_unlock_mdio();
>>                          napi_gro_receive(napi, skb);
>> +                       enetc_lock_mdio();
>>                          break;
>>                  case XDP_TX:
>>                          tx_ring = priv->xdp_tx_ring[rx_ring->index];
>> @@ -2038,6 +2047,7 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr
>> *rx_ring,
>>                  enetc_refill_rx_ring(rx_ring, enetc_bd_unused(rx_ring) -
>>                                       rx_ring->xdp.xdp_tx_in_flight);
>>
>> +       enetc_unlock_mdio();
> Nit: same as above.
>
>>          return rx_frm_cnt;
>>   }
>

