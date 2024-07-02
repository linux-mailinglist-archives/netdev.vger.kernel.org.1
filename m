Return-Path: <netdev+bounces-108519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8477B92414E
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 16:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41D942888B4
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 14:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FB81BA094;
	Tue,  2 Jul 2024 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="1Yzrl+9K";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seco.com header.i=@seco.com header.b="cKQuo2R9"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2135.outbound.protection.outlook.com [40.107.22.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F13B15B547;
	Tue,  2 Jul 2024 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.135
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719931860; cv=fail; b=I7o4W3a3rTon2SqvfZ/Co05N4jy4TGaK5C7VtUIMMbOs1Hr7NnZZZmcf5rAGfbXWEPu8vJBUrZoN2WGEHXS6vrC3c2DuYxpmlLuqcaTqeRHMG1wuRAODtRS4pi22qdBa2m6dOMlO1EyWQ50kOrlQSgUPdymw64m75yg7uBI9LGw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719931860; c=relaxed/simple;
	bh=X6cY5GRsMBfl2IgNWu/3mhQ6QyXEtkeXJHWzn4tgBTU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rq1h38Vrn8VCoAKjvzffoIhXU+Pg7jnsLfYbUcCEhBa5uUNWhopOkVj3ypyfQFbN2W+gz42ugE8XsfHptOXNBlxe2nHhkcufBvqvUzndUQCiFjvGgZrAb2jui1MbNigSm28IZZYoPQR6K0vZQi/YR/MXy8cx5ESunbuP6MpTdzY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com; spf=pass smtp.mailfrom=seco.com; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=1Yzrl+9K; dkim=fail (2048-bit key) header.d=seco.com header.i=@seco.com header.b=cKQuo2R9 reason="signature verification failed"; arc=fail smtp.client-ip=40.107.22.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=mKeljySmFoFqx8C12WDOx1NAciDjnrko4Q2hxg/Ws2B8wcoAHlK75j392HJsIBK2IHX47eTfvVUFHfEqae+xYVUMlStFJqfcAO8empDx62CJ3vQUZjMSslurbOMWgYAuMmFoKlpadtP/2a/I5LHbjocR4w6fhYc71qmEuZhR7OsBrW24P69JmmSPctL0PCYM5wxfPVvQ0IhNtax+2hq/oKK8eq8Z+CpSovhVRjm++GGBUXVxq4O9JpqFtaoogFW4ebDMozaeQSJB3SuEPEdPXmvXbjkZfXePAr/fLSn9mevvVv7dy4XP/FymJcGLU8nhKGRryKABt8n86fjTC8fYfw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JV1KRNEt2/QLfc7g3ZKCKpZA2acCPY6JyuZkOe6/Q9s=;
 b=epvZgn/t8js5GGn5ADt7eDQ7Apj4/ZS/HzTF4vmtGCHixgLwHJD8TUmU3ix2/eLx0Nl4M3bPzuVaRv0mHOQV+aGwxgqq/YPiEpE58F8DzrIoV2ufcRhnj7xu8IgUgZz6CgtY/u8W8pv+pWQbbuo7LjSoR+emIUtYEOuco4eCTZG+57FwtV5ing+G6yud5/QbECFoJVGSQjOmpxnEVJwNhFVk4mf0ggRy82CFPtWQ5n1Fveq+zQfN80k7BcacKuABKVi8/YhaF2J7x3Cstyvts0YDAdbNywtmRiyw3bkx1evalD7LLqZGzslXgImEDiRtrKylvrAd9GgKKlqSTItG4w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.87) smtp.rcpttodomain=davemloft.net smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JV1KRNEt2/QLfc7g3ZKCKpZA2acCPY6JyuZkOe6/Q9s=;
 b=1Yzrl+9KO1kcJgsDQeuA0mdWz4FuNd1IqmOKPCx/Z1dnTDA2+aO/CJjvc7Q7g2tuiAewUJ7JcbF8FwAuMmGVlD2Hahop9/IL9fRCMO73UtKYFAUy/ry6m1AWhUGhbwWchGC5Wsrt+jWTTI7FMNMGsbG1bFGmjscCznjTuC7OQyvYp3YK/haXWcnN5LKAi1vBz4eeR5v5FIOblbE2cd1x1U12mulyxFayg4S/8L0HaQTrX55V4zukWPDpKpmYVrW32Syf+DgClyaJ5kXMWT2V73jpQUiV6YAS810S1YCsuejsMVeH1Xc55R9bCfttGXrp+rYHmjbN9NOie4c+BfW8BA==
Received: from DU7P195CA0027.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::20)
 by PAVPR03MB10142.eurprd03.prod.outlook.com (2603:10a6:102:32a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 14:50:52 +0000
Received: from DB1PEPF000509E5.eurprd03.prod.outlook.com
 (2603:10a6:10:54d:cafe::d2) by DU7P195CA0027.outlook.office365.com
 (2603:10a6:10:54d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23 via Frontend
 Transport; Tue, 2 Jul 2024 14:50:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.87)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.87 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.87; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.87) by
 DB1PEPF000509E5.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7677.15
 via Frontend Transport; Tue, 2 Jul 2024 14:50:50 +0000
Received: from outmta (unknown [192.168.82.133])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id A508920083981;
	Tue,  2 Jul 2024 14:50:50 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (unknown [104.47.17.105])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 088A72008006F;
	Tue,  2 Jul 2024 14:50:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVY0tAzexMK0DtWt0QdV9i4X6nYvtOBryYZIAiaH3GYq/nradZS1CBFbsDPrXUiFq8CpzS74AQ5Ga3lcBi6gswyO76nFa5rm/kIwR2UbzZSClYGJ4JDXUySdQ8BemHwGJGiA7uuWXmMipRzbrw/xAXSsZn7xfBphu0GmtKfULdTInK9WkqYFiUjnfg4lyejgoHIKKJHZRNIlmrjGnYDW1Q9NIlvFNS3nSRdJXC/igNThxNKJbWQ7v+5RtTZX5XjQJTNe6aSFGtl7iY5s7pmI8WuxtrWjDVhZWxMPzBByFeT2JH+FhGWbY4yrjF6lHDeIOq2F07vkHP7D0Qkpr7ivoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfRPQVlcia5ID3jhuy0iDb21d14sLMolRIJmJ9W8wjQ=;
 b=U9z2FhdjE0Y8ZAKMBpLDdIEPbK2lOXjZ4yS06TLqFv56jGIKbnbLssPYiRAtIMBAZztx98yhkYRZI+v+R/GpkUyIuAPXwex8eCTgGYXrJ3MZBblGoorwCEhOkGltAJ4tegAimdogA8vdI185d1POUXd2+9FO3evLpaE34uEyPFqFaL5pow4LgyBugioApZiWxsmPvrEuZQIm18i6od31Il4+ZdFi00Y2aFPQcVSLCVsOsiP5cZMWKyMnibw7gMWpt63pCa37GTL6jUB9qWs+RuJQCN3Blf451wmDCYYPeTtKHfQvRZAkvjooWvmO/yg4UIN49N6zAoeCdlTNOtrVSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfRPQVlcia5ID3jhuy0iDb21d14sLMolRIJmJ9W8wjQ=;
 b=cKQuo2R9CorajKGG5trD/Ai+BerIOlkiO4bMiOdDWcwdDusWRHGA4fgNFo4aJJId1Rko8ndNvTCkSfYMRIiTIWd3HtBUqjAwEaKgt8uPTilsbIwlEBMnj4eFV8cqbEUB/GK6lr0qhQ/FK5U7T2f87EShPd4iIX/JOpjjcoPkzQzbS2Fpnmkk+S/RU6ZGp6gQwk9W0QcDbqjOCz+j+xY4JC/ouio8FrjBhsFKIOqUzFwwcVxRAnSg9BrRHJky4jwwEvg9xohfiQaoSM7yS1SjGd+FhpBoL1RmlVcm1d2uB6I8JsoglgvG8yTcUlNAPWzhKbf/ayjsbzXiNpdE1IGX3A==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by DBBPR03MB7081.eurprd03.prod.outlook.com (2603:10a6:10:206::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 14:50:47 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%7]) with mapi id 15.20.7719.028; Tue, 2 Jul 2024
 14:50:47 +0000
Message-ID: <e0b8c69a-3cc0-4034-b3f7-d8bdcc480c4d@seco.com>
Date: Tue, 2 Jul 2024 10:50:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fsl/fman: Validate cell-index value obtained from
 Device Tree
To: Aleksandr Mishin <amishin@t-argos.ru>,
 Igal Liberman <igal.liberman@freescale.com>
Cc: Madalin Bucur <madalin.bucur@nxp.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240702140124.19096-1-amishin@t-argos.ru>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20240702140124.19096-1-amishin@t-argos.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR19CA0026.namprd19.prod.outlook.com
 (2603:10b6:208:178::39) To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAVPR03MB9020:EE_|DBBPR03MB7081:EE_|DB1PEPF000509E5:EE_|PAVPR03MB10142:EE_
X-MS-Office365-Filtering-Correlation-Id: 82660a93-6e23-41c2-419f-08dc9aa65dee
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?ODJvYllWNVExZHZZN1pJU29NMG9INjAzSGhGSTJqaGorZFN4V1U0aFJpOEV3?=
 =?utf-8?B?ZlZUdzhTdTVxait4TytqemdUVEZjWEloeVZMd2ZFV2tWdjdmRTZycUdveEpq?=
 =?utf-8?B?enJTU2ttOW52U3RiOU4ydkpvWkxzZ3RCeHFST0t1V3d0Z0ZkT1o2T3hKQ0JZ?=
 =?utf-8?B?MkdxSEM3MjVkbytKYzVQQUNLQkhWMnJuZTlNaWRzYXRTYi9lRVRSbTlubTAz?=
 =?utf-8?B?bk1JcW5jQ2Y2YlhiSm1CZktTdmY2VVVNZjlNZ3Y4alVUOXA0VndNYkZrWW1O?=
 =?utf-8?B?R2dDYi9OK1QyWWRBUVFyNU1SekIyRjlOc3ZaaEd5MFM5TXd4MFE1ZHRiTzF4?=
 =?utf-8?B?SXdjUWpabEZTUkZTYlJ1MVZPQjJ6NnE2TXMyM1JZVFczQkpSUnVxMittcFha?=
 =?utf-8?B?enNiNlM2cFYybWZ5RW8wS00xWE9rNGFmOUJsMGt6bGpUZndPdTBIbk9xOVhJ?=
 =?utf-8?B?cG52c3FkTjl4ekh5VkVuVldmYml2SmlFeGd0aXJIOWdRelhKbEJjU0NnbkYx?=
 =?utf-8?B?TU9vRE0ybm1ldmRrTjVCU3V6UFBPRXJuZ2pQSFZpenFqMWUrNVJTVFdSRVR4?=
 =?utf-8?B?MXovS0lTSXlXM0poOVpTa1ROZTU5bmE1aC92cjJwZ0FFbnN5cElUem1MRXJU?=
 =?utf-8?B?V0JIUit1WGhadE5TM0Fad1FjQ1FEV3VKYjJpa0ZCWVB2dU1JbWNVbDFKSyto?=
 =?utf-8?B?cWNxTW5CZGRNd0RhbmgvZDdKczRkc0E5QTROZk5Ud3BpTHZpZGhVVmtWTlBR?=
 =?utf-8?B?ZUFLM2VKUEVNcDJ3OSsrcGkwVFRVQWVEUHdveTQzcW95TGVOaWQ0ZWg3bTll?=
 =?utf-8?B?V0QyUzZqVEdtaXFnQjlPeGd6a0tFTHRkay9pUkRUQ0ZyMFY3WFROdlU5WVNQ?=
 =?utf-8?B?ZnRtNlFSOFY4QWFEY2o0MkNYb003THB0cWgvMkNrUEZDdkhWSUM0aEQvTkpt?=
 =?utf-8?B?TnFZeWQrQk5qS2l2eHMxanJYeXV0V213ejRJMkhGY1RCbVJad0ZCNHdnMEVX?=
 =?utf-8?B?ZWI5bStDWlZ4OTZScFdDY2tZWkdCMUpqU20wL2VPdUJMbFVKYm5Vb0F4alJB?=
 =?utf-8?B?MktWclpSSE1FYkFjQVQzTGdSWGRXMWVpd0VZUEhxMFdyOE8wNXVhUWZIaGJQ?=
 =?utf-8?B?MTJDbUZFOUNHSGZBdmwwZnlKSUM2L0MxaWZ0S2xXbitxS0c5OGovK05vMEtY?=
 =?utf-8?B?Nys3bVlBNDlseEJLdFNsR21sbHVKdGxseHNZam5PbEVSTzRYNkN4UTgzVWU3?=
 =?utf-8?B?VmxHSlEvQXZNcCt2VWVPOHlUbGg1NHRRd0x6UG1rTk5YQU5RNVBRaG5TdTRh?=
 =?utf-8?B?OEdFSy9JQVVFWWs5MVZtSkpVVEVZMHl5U2cxQytyVXF3UmpPQ081OUU5Wngr?=
 =?utf-8?B?S3NLckZ3TGg1cThrcG5aazNrQmV4aTIxeTYrbVljOFdWUGhaOGlrWnRNbXRU?=
 =?utf-8?B?Ym9VZVdYU3BNaDhRNjVPZkFXRXhpWHQxYmFveHlOOG1DeHhkbGF1aVRZdmhl?=
 =?utf-8?B?amYwcGhrQUFXQU11WjQ5cUtVK3JacWsrYXFiUy9VSkNYT0ZUYWhDakt2UDhM?=
 =?utf-8?B?YTBnNHR3YlVmN1lhYWhvVjB6cUdCdWlTT09scWVtdzNURFM1ZEZaUGtLR1M0?=
 =?utf-8?B?aXFsNWh1QSszQ1pzTUEwK1Q2RE9lTkFCMmppcVlwYzdCZDA1RThTS0tUZFk4?=
 =?utf-8?B?UzR2WGx3QWd2c1R0WVgvR0kyNTI0dXpCMk15SVJpNSt4MUdvTU04SHJtRnNH?=
 =?utf-8?B?Zk4zNCtiUms5TTFYVkpLdmF2THR4UFVqQ25MR3B2ekxGQzkvKzAybVpyY0lo?=
 =?utf-8?B?VWhrd1dlRUJWRGRmMGRzaG9LNkRvNm05UC8yNnlwbktkU3BnVUx4Z3gzNno2?=
 =?utf-8?B?T2Q2dmh3aVFyQjA1VCt2MlBScFRlbk9oNGl5Wjh2SkJvNnc9PQ==?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR03MB9020.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB7081
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509E5.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0a69391e-24cf-456b-e932-08dc9aa65b6d
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1ozY2g2RjE2dlY1ekkrYU5WRzRnYUVjQldnUDBEeXUyT3FxOEIvcGdTeDFa?=
 =?utf-8?B?U214bVl5bGJXWVlsZ21aUHNKVU80QVJUWWk3d3hrN1NBbzlTWHd3OU90Slpi?=
 =?utf-8?B?T2Z0SWkvcGQ1QVRpUWR2aXRVczFnYWNHOUNlVEJpdFI3NjArSXFtWitIUm55?=
 =?utf-8?B?WlVGVmxMYWFOOTlyZVlkV2hIclkvcDZtNTQ1WCt3Q3lQQnZtS0w3YUtBY1dB?=
 =?utf-8?B?QzExMGlNT1RrSGlGN01vUzZ3WGdpTFpZUUExWHdVSFV3UmlvYWs4VHNzYVpE?=
 =?utf-8?B?bjlIOGNjR2dGbXFLd3NLanBkcml2M2dlamxHVEo3S0JLVFFYdi9vUythRSti?=
 =?utf-8?B?ZTREQk9zZHpDd0tDd1B3S1BtSThwTkpuTDJqMU00cm1yNFpZSENkamNrL1Nh?=
 =?utf-8?B?ck83ZklWeFZDeUNsbmJjOG0vRjFhRUMrK21jNld0M1ZCRDZueCs2NjJpZlFZ?=
 =?utf-8?B?ZWl2UTJrNUIwZ21jQmNjamJRWG1vKzZKaDNZcmRUd2dDOFM0ZE9BUHBYTlQw?=
 =?utf-8?B?QWRIRnU5bWthOEdQQkF4bmgzb1FJcGI2bXk4Yno0LzdWeFQ0QnIzYTBtNVp5?=
 =?utf-8?B?YjQ2dzdlWU00ZEJTUU9udDJhNkNaTU1tdmF0VUpyalpMcVB3Y2ZLaWttRFFz?=
 =?utf-8?B?dGkyb2tIRGZZM21yNi80S1ZHbEFXalRVcVNNNHNBRytWckd6dENPMWJJblcv?=
 =?utf-8?B?ellqWVphc09NeWg3dUVCQllWWnQ0c1lXaFVwZWlOb0xmbXM5K3RmK3BBVmdV?=
 =?utf-8?B?bWY4T2J4eGpScWhsWUZFd3k0U0cxUGEydVJpY284ZWQxc3FqT3BFQ3BPaEtE?=
 =?utf-8?B?MzZFMWIvRDFSYWJHbHZGdHZFL01IdGd3blhNQThLckxMSGgybWNBSy94MXpV?=
 =?utf-8?B?SFJLaGo2WHBraDFOc2lhRFpRMlR6NzFCK0pmRTRWSGI0aXN5eHc2RzY0dUZO?=
 =?utf-8?B?VzdFMFNhTWtVcXljZExiNWtDRUlZR0ZxVDFNbjV2MVNJeHFZd1dERmtlUzFx?=
 =?utf-8?B?MXpVZXQ3bGpmR3pUblZpQnBac2RQZnFSY3B1cWxlZDBBRER0TGVkSkc2Zlds?=
 =?utf-8?B?bE5kdWtWUHFBQVIrYXhzaStEaWVJWmNsS0lGcFdZVWs2SldtZDYxUVdFdkNH?=
 =?utf-8?B?VFJCOXVQcy83TUJUK0VZNkNlTkFuQWtQK3RXYTRFeCs0a0ovVWo3TmlRNk41?=
 =?utf-8?B?R1g0M0FlaHFsc2s1MTZqOEZQQXB3QmFwQTRoZEZxbUZyQ2Vza2l4MUJJVjhS?=
 =?utf-8?B?TGhNV2FibzNNblhRa2ZXRW5xWkxnTXoyRlZpZVdaZXVrMXRLMnNvTjJvUXBk?=
 =?utf-8?B?dENnLzJPRVJGS1Z6WGR1K25uakoxTE0yU2kyOW9kNkk4cWxjS2RuM2d0YzFu?=
 =?utf-8?B?NERuYW54bjQ5aGRDb2NaVkFkdzg2RjVUU1dJMk5RZWNMK2lzMkdnM1ZhRTNw?=
 =?utf-8?B?VUFIcVZKeXJBWUttN1oyVEZ1THNFUHdhT3lTUU1Rb3l5eUoxMWlRVU9hNUhI?=
 =?utf-8?B?OUVVd0hLek1DVzR1K1RBbTl3RkxzanBwem5ydDM2N2loM0c5cEpnc0huZWdP?=
 =?utf-8?B?NmQwMUlzb1IrUEdlWXFmMFI1NmM2VFVJSVBXdDRYdU9SQW9yWWprUEY1aUNN?=
 =?utf-8?B?YjdwWHdCbEVXc0NoL2xsV29qVHRmbkdLcjYwNzZjdlNMeTBnWWtrRVdld0FR?=
 =?utf-8?B?b2UxVkI0a0xTc1FqeFV4VEJHeGN5REp2T1hZaUliUEpmelAxRWRWSVhpbUhI?=
 =?utf-8?B?bzNTU0RPajJXT3lHN3dORnUyMzViOGNEUDMyK0hUbEh3S2E4d1pjcStZWUZt?=
 =?utf-8?B?RTBpSm9DSmhRa055N3lwaXplQzcwUjR0T1lPcWhJeFJxQWNjMGo1Slc1TFF6?=
 =?utf-8?B?Y0lFbXpwQlhOcjVyMEEwbG1FY2lma05TUlcwNFBmVUZVN29qSEZuM2c5SDJR?=
 =?utf-8?Q?bogaDTZVcxMlDR5GiX9aDdjGBH8ths3D?=
X-Forefront-Antispam-Report:
	CIP:20.160.56.87;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(35042699022);DIR:OUT;SFP:1102;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 14:50:50.9974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82660a93-6e23-41c2-419f-08dc9aa65dee
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.87];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB10142

On 7/2/24 10:01, Aleksandr Mishin wrote:
> [You don't often get email from amishin@t-argos.ru. Learn why this is imp=
ortant at https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/que=
ry?url=3Dhttps%3a%2f%2faka.ms%2fLearnAboutSenderIdentification&umid=3Dca782=
a5b-a3fd-4738-b50c-ffbd8e52e50f&auth=3Dd807158c60b7d2502abde8a2fc01f4066298=
0862-ac0deac714bbe85d389fd2711a17d0113034b3ca ]
>
> Cell-index value is obtained from Device Tree and then used to calculate
> the index for accessing arrays port_mfl[], mac_mfl[] and intr_mng[].
> In case of broken DT due to any error cell-index can contain any value
> and it is possible to go beyond the array boundaries which can lead
> at least to memory corruption.
> Validate cell-index value obtained from Device Tree.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 414fd46e7762 ("fsl/fman: Add FMan support")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
> v1->v2: Move check to mac.c to avoid allmodconfig build errors and refere=
nce leaks
>
>  drivers/net/ethernet/freescale/fman/fman.c | 1 -
>  drivers/net/ethernet/freescale/fman/fman.h | 3 +++
>  drivers/net/ethernet/freescale/fman/mac.c  | 4 ++++
>  3 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/eth=
ernet/freescale/fman/fman.c
> index d96028f01770..fb416d60dcd7 100644
> --- a/drivers/net/ethernet/freescale/fman/fman.c
> +++ b/drivers/net/ethernet/freescale/fman/fman.c
> @@ -24,7 +24,6 @@
>
>  /* General defines */
>  #define FMAN_LIODN_TBL                 64      /* size of LIODN table */
> -#define MAX_NUM_OF_MACS                        10
>  #define FM_NUM_OF_FMAN_CTRL_EVENT_REGS 4
>  #define BASE_RX_PORTID                 0x08
>  #define BASE_TX_PORTID                 0x28
> diff --git a/drivers/net/ethernet/freescale/fman/fman.h b/drivers/net/eth=
ernet/freescale/fman/fman.h
> index 2ea575a46675..74eb62eba0d7 100644
> --- a/drivers/net/ethernet/freescale/fman/fman.h
> +++ b/drivers/net/ethernet/freescale/fman/fman.h
> @@ -74,6 +74,9 @@
>  #define BM_MAX_NUM_OF_POOLS            64 /* Buffers pools */
>  #define FMAN_PORT_MAX_EXT_POOLS_NUM    8  /* External BM pools per Rx po=
rt */
>
> +/* General defines */
> +#define MAX_NUM_OF_MACS                        10
> +
>  struct fman; /* FMan data */
>
>  /* Enum for defining port types */
> diff --git a/drivers/net/ethernet/freescale/fman/mac.c b/drivers/net/ethe=
rnet/freescale/fman/mac.c
> index 9767586b4eb3..ac9ad5e67b44 100644
> --- a/drivers/net/ethernet/freescale/fman/mac.c
> +++ b/drivers/net/ethernet/freescale/fman/mac.c
> @@ -247,6 +247,10 @@ static int mac_probe(struct platform_device *_of_dev=
)
>                 dev_err(dev, "failed to read cell-index for %pOF\n", mac_=
node);
>                 return -EINVAL;
>         }
> +       if (val >=3D MAX_NUM_OF_MACS) {
> +               dev_err(dev, "cell-index value is too big for %pOF\n", ma=
c_node);
> +               return -EINVAL;
> +       }
>         priv->cell_index =3D (u8)val;
>
>         /* Get the MAC address */
> --
> 2.30.2
>

Reviewed-by: Sean Anderson <sean.anderson@seco.com>

[StudioX, SECO SpA]<https://www.seco.com/applications/studiox>

